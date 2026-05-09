<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ReviewAlbum;
use App\Models\FavoriteAlbum;
use App\Models\LikeReview;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UserStatsController extends Controller
{
    /**
     * Obtener estadísticas globales de un usuario.
     */
    public function getStats(Request $request, $userId): JsonResponse
    {
        $reviews = ReviewAlbum::where('usuario_id', $userId)->get();
        
        $totalReviews = $reviews->count();
        $uniqueAlbums = $reviews->pluck('album_id')->unique()->count();
        
        // Obtener artistas únicos a través de los álbumes de las reseñas
        $uniqueArtists = DB::table('reviews_albumes')
            ->join('albumes', 'reviews_albumes.album_id', '=', 'albumes.id')
            ->where('usuario_id', $userId)
            ->distinct('albumes.artista_id')
            ->count('albumes.artista_id');

        $avgRating = $reviews->avg('calificacion') ?: 0;
        
        // Determinar género favorito (basado en etiquetas más usadas)
        $allTags = [];
        foreach ($reviews as $r) {
            $tags = is_string($r->etiquetas) ? json_decode($r->etiquetas, true) : $r->etiquetas;
            if (is_array($tags)) $allTags = array_merge($allTags, $tags);
        }
        $tagCounts = array_count_values($allTags);
        arsort($tagCounts);
        $favGenre = !empty($tagCounts) ? array_key_first($tagCounts) : 'Varios';

        // Mock de horas escuchadas (podría basearse en duración de canciones si tuviéramos ese dato)
        $hours = round($uniqueAlbums * 0.75, 1); 

        return response()->json([
            'total_reviews'   => $totalReviews,
            'unique_albums'   => $uniqueAlbums,
            'unique_artists'  => $uniqueArtists,
            'average_rating'  => round($avgRating, 1),
            'favorite_genre'  => $favGenre,
            'hours_listened'  => $hours,
        ]);
    }

    /**
     * Obtener feed de actividad reciente del usuario.
     */
    public function getActivity(Request $request, $userId): JsonResponse
    {
        // 1. Últimas reseñas
        $recentReviews = ReviewAlbum::with('album')
            ->where('usuario_id', $userId)
            ->latest('fecha_creacion')
            ->limit(5)
            ->get()
            ->map(function($r) {
                return [
                    'id'      => $r->id,
                    'type'    => 'Reseña',
                    'action'  => 'publicó una reseña de',
                    'title'   => $r->album->titulo,
                    'artist'  => $r->album->artista_nombre,
                    'image'   => $r->album->imagen_url ?: $r->album->portada,
                    'rating'  => $r->calificacion,
                    'date'    => $r->fecha_creacion,
                ];
            });

        // 2. Últimos likes dados
        $recentLikes = LikeReview::with('review.album')
            ->where('usuario_id', $userId)
            ->latest('fecha')
            ->limit(5)
            ->get()
            ->map(function($l) {
                if (!$l->review) return null;
                return [
                    'id'      => $l->id,
                    'type'    => 'Like',
                    'action'  => 'le dio like a la reseña de',
                    'title'   => $l->review->album->titulo,
                    'artist'  => $l->review->album->artista_nombre,
                    'image'   => $l->review->album->imagen_url ?: $l->review->album->portada,
                    'rating'  => null,
                    'date'    => $l->fecha,
                ];
            })->filter();

        $activity = $recentReviews->concat($recentLikes)->sortByDesc('date')->values();

        return response()->json($activity);
    }

    /**
     * Listar álbumes favoritos.
     */
    public function getFavorites(Request $request, $userId): JsonResponse
    {
        $favs = FavoriteAlbum::where('usuario_id', $userId)->latest()->get();
        return response()->json($favs);
    }

    /**
     * Toggle favorito de un álbum.
     */
    public function toggleFavorite(Request $request): JsonResponse
    {
        $request->validate([
            'album_titulo'  => 'required|string',
            'album_artista' => 'required|string',
            'album_portada' => 'nullable|string',
        ]);

        $userId = $request->user()->id;

        $existing = FavoriteAlbum::where('usuario_id', $userId)
            ->where('album_titulo', $request->album_titulo)
            ->where('album_artista', $request->album_artista)
            ->first();

        if ($existing) {
            $existing->delete();
            return response()->json(['status' => 'removed', 'favorited' => false]);
        }

        FavoriteAlbum::create([
            'usuario_id'    => $userId,
            'album_titulo'  => $request->album_titulo,
            'album_artista' => $request->album_artista,
            'album_portada' => $request->album_portada,
        ]);

        return response()->json(['status' => 'added', 'favorited' => true]);
    }

    /**
     * Listar artistas favoritos de un usuario.
     */
    public function getFavoriteArtists(Request $request, $userId): JsonResponse
    {
        $favs = \App\Models\FavoriteArtist::where('usuario_id', $userId)->latest('id')->get();
        return response()->json($favs);
    }

    /**
     * Toggle favorito de un artista.
     */
    public function toggleFavoriteArtist(Request $request): JsonResponse
    {
        $request->validate([
            'artist_nombre' => 'required|string',
            'artist_imagen' => 'nullable|string',
        ]);

        $userId = $request->user()->id;

        $existing = \App\Models\FavoriteArtist::where('usuario_id', $userId)
            ->where('artist_nombre', $request->artist_nombre)
            ->first();

        if ($existing) {
            $existing->delete();
            return response()->json(['status' => 'removed']);
        }

        \App\Models\FavoriteArtist::create([
            'usuario_id'    => $userId,
            'artist_nombre' => $request->artist_nombre,
            'artist_imagen' => $request->artist_imagen,
        ]);

        return response()->json(['status' => 'added']);
    }
}
