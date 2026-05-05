<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Follower;
use App\Models\ReviewAlbum;
use App\Models\SavedAlbum;
use App\Models\FavoriteAlbum;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class FriendsController extends Controller
{
    /**
     * Devuelve los IDs de usuarios que sigue el usuario logueado.
     */
    private function getFollowingIds(): array
    {
        return Follower::where('follower_id', Auth::id())
            ->pluck('following_id')
            ->toArray();
    }

    /**
     * Reseñas recientes de usuarios que sigo.
     */
    public function reviews(): JsonResponse
    {
        $followingIds = $this->getFollowingIds();

        if (empty($followingIds)) {
            return response()->json(['data' => [], 'empty' => true]);
        }

        $reviews = ReviewAlbum::whereIn('usuario_id', $followingIds)
            ->with(['usuario:id,nombre,username,foto_perfil', 'album'])
            ->orderByDesc('fecha_creacion')
            ->limit(20)
            ->get()
            ->map(function ($review) {
                return [
                    'id'          => $review->id,
                    'userId'      => $review->usuario_id,
                    'username'    => $review->usuario->username ?? '',
                    'userAvatar'  => $review->usuario->foto_perfil ?? '',
                    'albumTitle'  => $review->album->titulo ?? '',
                    'artist'      => $review->album->artista_nombre ?? ($review->album->artista->nombre ?? ''),
                    'albumImage'  => $review->album->imagen_url ?? $review->album->portada ?? '',
                    'rating'      => (float) $review->calificacion,
                    'reviewTitle' => $review->titulo ?? '',
                    'content'     => $review->contenido ?? '',
                    'likes'       => $review->likes ?? 0,
                    'date'        => $review->fecha_creacion ? Carbon::parse($review->fecha_creacion)->format('d M') : '',
                ];
            });

        return response()->json(['data' => $reviews]);
    }

    /**
     * Álbumes guardados de usuarios que sigo.
     */
    public function savedAlbums(): JsonResponse
    {
        $followingIds = $this->getFollowingIds();

        if (empty($followingIds)) {
            return response()->json(['data' => [], 'empty' => true]);
        }

        $saved = SavedAlbum::whereIn('usuario_id', $followingIds)
            ->with('user:id,nombre,username,foto_perfil')
            ->limit(20)
            ->get()
            ->map(function ($item) {
                return [
                    'id'         => $item->id,
                    'userId'     => $item->usuario_id,
                    'username'   => $item->user->username ?? '',
                    'userAvatar' => $item->user->foto_perfil ?? '',
                    'title'      => $item->album_titulo ?? '',
                    'artist'     => $item->album_artista ?? '',
                    'image'      => $item->album_portada ?? '',
                    'savedAt'    => '',
                ];
            });

        return response()->json(['data' => $saved]);
    }

    /**
     * Álbumes favoritos de usuarios que sigo.
     */
    public function favoriteAlbums(): JsonResponse
    {
        $followingIds = $this->getFollowingIds();

        if (empty($followingIds)) {
            return response()->json(['data' => [], 'empty' => true]);
        }

        $favs = FavoriteAlbum::whereIn('usuario_id', $followingIds)
            ->with('user:id,nombre,username,foto_perfil')
            ->limit(20)
            ->get()
            ->map(function ($item) {
                return [
                    'id'         => $item->id,
                    'userId'     => $item->usuario_id,
                    'username'   => $item->user->username ?? '',
                    'userAvatar' => $item->user->foto_perfil ?? '',
                    'title'      => $item->album_titulo ?? '',
                    'artist'     => $item->album_artista ?? '',
                    'image'      => $item->album_portada ?? '',
                    'addedAt'    => '',
                ];
            });

        return response()->json(['data' => $favs]);
    }
}
