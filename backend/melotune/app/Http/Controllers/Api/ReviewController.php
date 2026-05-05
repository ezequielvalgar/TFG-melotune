<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ReviewAlbum;
use App\Models\Album;
use App\Models\Artista;
use App\Models\LikeReview;

class ReviewController extends Controller
{
    /**
     * GET /api/reviews
     * Devuelve la lista de reseñas paginadas, con info del álbum y usuario.
     */
    public function index(Request $request)
    {
        $reviews = ReviewAlbum::with(['usuario', 'album.artista'])
            ->orderBy('fecha_creacion', 'desc')
            ->paginate(12);

        // Añadir si el usuario autenticado ha dado like
        $userId = null;
        if ($request->bearerToken()) {
            $user = $request->user('sanctum');
            if ($user) $userId = $user->id;
        }

        $reviews->getCollection()->transform(function ($review) use ($userId) {
            return $this->formatReview($review, $userId);
        });

        return response()->json($reviews);
    }

    /**
     * GET /api/reviews/user/{userId}
     * Reseñas de un usuario concreto.
     */
    public function byUser(Request $request, $userId)
    {
        $authUserId = null;
        if ($request->bearerToken()) {
            $user = $request->user('sanctum');
            if ($user) $authUserId = $user->id;
        }

        $reviews = ReviewAlbum::with(['usuario', 'album.artista'])
            ->where('usuario_id', $userId)
            ->orderBy('fecha_creacion', 'desc')
            ->get()
            ->map(fn($r) => $this->formatReview($r, $authUserId));

        return response()->json($reviews);
    }

    /**
     * GET /api/albums/{artist}/{title}/reviews
     * Reseñas de un álbum concreto.
     */
    public function byAlbum(Request $request, $artist, $title)
    {
        $authUserId = null;
        if ($request->bearerToken()) {
            $user = $request->user('sanctum');
            if ($user) $authUserId = $user->id;
        }

        $reviews = ReviewAlbum::with(['usuario', 'album.artista'])
            ->whereHas('album', function($q) use ($artist, $title) {
                $q->where('titulo', 'like', $title)
                  ->where(function($qArtist) use ($artist) {
                      $qArtist->where('artista_nombre', 'like', $artist)
                              ->orWhereHas('artista', function($qA) use ($artist) {
                                  $qA->where('nombre', 'like', $artist);
                              });
                  });
            })
            ->orderBy('fecha_creacion', 'desc')
            ->get()
            ->map(fn($r) => $this->formatReview($r, $authUserId));

        return response()->json($reviews);
    }

    /**
     * POST /api/reviews
     * Crea una nueva reseña. Requiere autenticación.
     */
    public function store(Request $request)
    {
        $request->validate([
            'album_titulo'  => 'required|string|max:200',
            'album_artista' => 'required|string|max:200',
            'album_portada' => 'nullable|string|max:500',
            'calificacion'  => 'required|numeric|min:0.5|max:5',
            'titulo'        => 'nullable|string|max:200',
            'contenido'     => 'nullable|string|max:5000',
        ]);

        $user = $request->user();

        // 1. Buscar o crear el artista
        $artista = Artista::firstOrCreate(
            ['nombre' => $request->album_artista],
            ['nombre' => $request->album_artista]
        );

        // 2. Buscar o crear el álbum
        $album = Album::firstOrCreate(
            ['titulo' => $request->album_titulo, 'artista_id' => $artista->id],
            [
                'titulo'         => $request->album_titulo,
                'artista_id'     => $artista->id,
                'artista_nombre' => $request->album_artista,
                'portada'        => $request->album_portada,
                'imagen_url'     => $request->album_portada,
            ]
        );

        // 3. Verificar si ya tiene una reseña de este álbum (unique constraint)
        $existing = ReviewAlbum::where('usuario_id', $user->id)
            ->where('album_id', $album->id)
            ->first();

        if ($existing) {
            // Actualizar la reseña existente
            $existing->update([
                'calificacion'   => $request->calificacion,
                'titulo'         => $request->titulo,
                'contenido'      => $request->contenido,
                'etiquetas'      => $request->etiquetas ?? [],
                'encuesta'       => $request->encuesta ?? null,
                'preguntas_guia' => $request->preguntas_guia ?? null,
                'contexto_escucha' => $request->contexto_escucha,
                'cancion_favorita' => $request->cancion_favorita,
                'vibe_factor'    => $request->vibe_factor,
            ]);
            $review = $existing->fresh(['usuario', 'album.artista']);
            return response()->json($this->formatReview($review, $user->id), 200);
        }

        // 4. Crear la reseña nueva
        $review = ReviewAlbum::create([
            'usuario_id'     => $user->id,
            'album_id'       => $album->id,
            'calificacion'   => $request->calificacion,
            'titulo'         => $request->titulo,
            'contenido'      => $request->contenido,
            'etiquetas'      => $request->etiquetas ?? [],
            'encuesta'       => $request->encuesta ?? null,
            'preguntas_guia' => $request->preguntas_guia ?? null,
            'contexto_escucha' => $request->contexto_escucha,
            'cancion_favorita' => $request->cancion_favorita,
            'vibe_factor'    => $request->vibe_factor,
            'likes'          => 0,
        ]);

        $review->load(['usuario', 'album.artista']);
        return response()->json($this->formatReview($review, $user->id), 201);
    }

    /**
     * POST /api/reviews/{id}/like
     * Toggle like de una reseña. Requiere autenticación.
     */
    public function toggleLike(Request $request, $id)
    {
        $user = $request->user();
        $review = ReviewAlbum::findOrFail($id);

        $existing = LikeReview::where('usuario_id', $user->id)
            ->where('review_id', $id)
            ->first();

        if ($existing) {
            // Ya le dio like → quitar like
            $existing->delete();
            $review->decrement('likes');
            return response()->json(['liked' => false, 'likes' => $review->fresh()->likes]);
        } else {
            // No tiene like → dar like
            LikeReview::create([
                'usuario_id' => $user->id,
                'review_id'  => $id,
                'fecha'      => now(),
            ]);
            $review->increment('likes');
            return response()->json(['liked' => true, 'likes' => $review->fresh()->likes]);
        }
    }

    /**
     * DELETE /api/reviews/{id}
     * Eliminar una reseña propia.
     */
    public function destroy(Request $request, $id)
    {
        $user = $request->user();
        $review = ReviewAlbum::where('id', $id)->where('usuario_id', $user->id)->firstOrFail();
        $review->delete();
        return response()->json(['message' => 'Reseña eliminada']);
    }

    /**
     * Formatea una reseña para la respuesta JSON.
     */
    private function formatReview(ReviewAlbum $review, ?int $authUserId): array
    {
        $likedByUser = false;
        if ($authUserId) {
            $likedByUser = LikeReview::where('usuario_id', $authUserId)
                ->where('review_id', $review->id)
                ->exists();
        }

        $album = $review->album;
        $artista = $album?->artista;

        $albumImage = $album?->imagen_url ?? $album?->portada ?? '';
        if ($albumImage && !str_starts_with($albumImage, 'http') && $album) {
            try {
                $lastFm = app(\App\Services\LastFmService::class);
                $artistName = $artista?->nombre ?? $album->artista_nombre;
                $info = $lastFm->getAlbumInfo($artistName, $album->titulo);
                if (!empty($info['image'])) {
                    $albumImage = $info['image'];
                    $album->update(['imagen_url' => $albumImage, 'portada' => $albumImage]);
                }
            } catch (\Exception $e) {
                // Ignore
            }
        }

        // Calcular vibe
        $vibe = $this->calcVibe($review->vibe_factor);

        return [
            'id'          => $review->id,
            'albumTitle'  => $album?->titulo ?? '—',
            'artist'      => $artista?->nombre ?? $album?->artista_nombre ?? '—',
            'albumImage'  => $albumImage,
            'username'    => $review->usuario?->username ?? 'anon',
            'userAvatar'  => $this->getAvatarUrl($review->usuario),
            'userId'      => $review->usuario_id,
            'date'        => $review->fecha_creacion
                ? \Carbon\Carbon::parse($review->fecha_creacion)->locale('es')->isoFormat('D [de] MMMM [de] YYYY')
                : '',
            'reviewTitle' => $review->titulo ?? '',
            'content'     => $review->contenido ?? '',
            'rating'      => (float) $review->calificacion,
            'likes'       => (int) $review->likes,
            'likedByUser' => $likedByUser,
            'tags'        => $review->etiquetas ?? [],
            'encuesta'    => $review->encuesta,
            'preguntasGuia' => $review->preguntas_guia,
            'contextoEscucha' => $review->contexto_escucha,
            'favoriteSong'   => $review->cancion_favorita ?? '',
            'vibeFactor'  => $review->vibe_factor,
            'vibeIcon'    => $vibe['icon'],
            'vibeColor'   => $vibe['color'],
            'vibeMood'    => $vibe['mood'],
            'comments'    => 0,
        ];
    }

    private function getAvatarUrl($usuario): string
    {
        if (!$usuario) return 'https://ui-avatars.com/api/?name=Anon&background=1a1c2e&color=E83E8C&bold=true';
        $foto = $usuario->foto_perfil;
        
        if (empty($foto) || $foto === 'default.jpg' || $foto === 'avatar1.jpg') {
            return 'https://ui-avatars.com/api/?name=' . urlencode($usuario->username) . '&background=1a1c2e&color=E83E8C&size=200&bold=true';
        }

        // Si es una ruta local de Laravel storage, convertirla a URL absoluta
        if (str_starts_with($foto, 'avatars/') || str_starts_with($foto, 'storage/')) {
            // Asegurarnos de que no empiece con slash doble o falte storage/
            $path = str_starts_with($foto, 'storage/') ? $foto : 'storage/' . $foto;
            return url($path);
        }

        return $foto;
    }

    private function calcVibe(?int $factor): array
    {
        if ($factor === null || $factor >= 60) {
            return ['icon' => 'fa-regular fa-face-smile', 'color' => '#20c997', 'mood' => 'Feliz'];
        } elseif ($factor >= 35) {
            return ['icon' => 'fa-regular fa-face-meh', 'color' => '#f59e0b', 'mood' => 'Neutral'];
        } else {
            return ['icon' => 'fa-regular fa-face-frown', 'color' => '#3b82f6', 'mood' => 'Melancólico'];
        }
    }
}
