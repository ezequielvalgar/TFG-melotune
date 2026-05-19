<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Exceptions\LastFmApiException;
use App\Http\Controllers\Controller;
use App\Models\ReviewAlbum;
use App\Services\LastFmService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class MusicController extends Controller
{
    public function __construct(private readonly LastFmService $musicService)
    {
    }

    public function searchArtists(Request $request): JsonResponse
    {
        $query = $request->input('q');

        if (!$query) {
            return response()->json(['error' => 'Se requiere el parámetro "q" para buscar'], 400);
        }

        try {
            return response()->json($this->musicService->searchArtist($query));
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@searchArtists: ' . $e->getMessage());
            return response()->json(['error' => 'No se pudo conectar con Last.fm'], 502);
        }
    }

    public function searchAlbums(Request $request): JsonResponse
    {
        $query = $request->input('q');

        if (!$query) {
            return response()->json(['error' => 'Se requiere el parámetro "q" para buscar'], 400);
        }

        try {
            return response()->json($this->musicService->searchAlbum($query));
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@searchAlbums: ' . $e->getMessage());
            return response()->json(['error' => 'No se pudo conectar con Last.fm'], 502);
        }
    }

    public function searchSpotify(Request $request): JsonResponse
    {
        $query = (string) $request->query('q', '');

        if (strlen($query) < 2) {
            return response()->json(['albums' => [], 'artists' => []]);
        }

        try {
            $token = $this->musicService->getSpotifyTokenPublic();

            $response = \Illuminate\Support\Facades\Http::withToken($token)->get(
                config('services.spotify.api_url') . '/search',
                [
                    'q' => $query,
                    'type' => 'album,artist',
                    'market' => 'ES',
                    'limit' => 5,
                ]
            );

            if (!$response->successful()) {
                return response()->json(['albums' => [], 'artists' => []]);
            }

            $data = $response->json();

            // Formatear álbumes
            $albums = array_map(function ($album) {
                return [
                    'name' => $album['name'],
                    'artist' => $album['artists'][0]['name'] ?? 'Desconocido',
                    'image' => $album['images'][0]['url'] ?? null,
                    'score' => null,
                    'type' => 'album',
                ];
            }, $data['albums']['items'] ?? []);

            // Formatear artistas
            $artists = array_map(function ($artist) {
                return [
                    'name' => $artist['name'],
                    'image' => $artist['images'][0]['url'] ?? null,
                    'followers' => $artist['followers']['total'] ?? 0,
                    'type' => 'artist',
                ];
            }, $data['artists']['items'] ?? []);

            return response()->json([
                'albums' => $albums,
                'artists' => $artists,
            ]);

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('searchSpotify failed: ' . $e->getMessage());
            return response()->json(['albums' => [], 'artists' => []]);
        }
    }


    public function featuredAlbums(): JsonResponse
    {
        try {
            $albums = $this->resolveTopAlbumsByReviews(limit: 8);
            return response()->json($this->musicService->getFeaturedAlbums($albums));
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@featuredAlbums: ' . $e->getMessage());
            return response()->json([], 502);
        }
    }

    public function popularArtists(): JsonResponse
    {
        try {
            return response()->json($this->musicService->getPopularArtists());
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@popularArtists: ' . $e->getMessage());
            return response()->json([], 502);
        }
    }

    public function weeklyPromo(): JsonResponse
    {
        try {
            return response()->json($this->musicService->getWeeklyRecommendation());
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@weeklyPromo: ' . $e->getMessage());
            return response()->json([], 502);
        }
    }


    public function reviewAlbums(): JsonResponse
    {
        try {
            $albums = $this->resolveTopAlbumsByAvgRating(limit: 5);
            return response()->json($this->musicService->getReviewAlbums($albums));
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@reviewAlbums: ' . $e->getMessage());
            return response()->json([], 502);
        }
    }

    public function newReleases(): JsonResponse
    {
        try {
            return response()->json($this->musicService->getNewReleases());
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@newReleases: ' . $e->getMessage());
            return response()->json([], 502);
        }
    }

    public function searchUsers(Request $request): JsonResponse
    {
        $query = (string) $request->query('q', '');

        if (strlen($query) < 2) {
            return response()->json(['users' => []]);
        }

        $users = \App\Models\User::where('username', 'LIKE', "%{$query}%")
            ->orWhere('nombre', 'LIKE', "%{$query}%")
            ->limit(5)
            ->get()
            ->map(function ($user) {
                return [
                    'id' => $user->id,
                    'username' => $user->username,
                    'nombre' => $user->nombre,
                    'foto_perfil' => $user->foto_perfil,
                    'followers_count' => $user->followersCount(),
                ];
            });

        return response()->json(['users' => $users]);
    }

    public function albumInfo(Request $request): JsonResponse
    {
        $artist = $request->input('artist');
        $album = $request->input('album');

        if (!$artist || !$album) {
            return response()->json(['error' => 'Se requiere artist y album'], 400);
        }

        try {
            return response()->json($this->musicService->getAlbumInfo($artist, $album));
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@albumInfo: ' . $e->getMessage());
            return response()->json(['error' => 'No se pudo obtener la información del álbum'], 502);
        }
    }

    public function artistInfo(Request $request): JsonResponse
    {
        $artist = (string) $request->query('artist', '');
        if (!$artist) {
            return response()->json(['error' => 'Artist required'], 422);
        }

        try {
            return response()->json($this->musicService->getArtistInfo($artist));
        } catch (LastFmApiException $e) {
            Log::warning('MusicController@artistInfo: ' . $e->getMessage());
            return response()->json(['error' => 'No se pudo obtener la información del artista'], 502);
        }
    }

    // ─── Helpers de consulta (responsabilidad del controlador) ─────────────────

    /**
     * Devuelve los N álbumes con más reseñas, con el nombre del artista resuelto.
     *
     * @return list<array{artist: string, title: string}>
     */
    private function resolveTopAlbumsByReviews(int $limit): array
    {
        return ReviewAlbum::select('album_id', DB::raw('COUNT(id) as total_reviews'))
            ->groupBy('album_id')
            ->orderByDesc('total_reviews')
            ->limit($limit)
            ->with('album.artista')
            ->get()
            ->map(function (ReviewAlbum $row): ?array {
                $album = $row->album;
                if (!$album)
                    return null;

                $artist = $album->artista_nombre
                    ?? ($album->artista?->nombre ?? null);

                return $artist ? ['artist' => $artist, 'title' => $album->titulo] : null;
            })
            ->filter()
            ->values()
            ->toArray();
    }

    /**
     * Devuelve los N álbumes con mejor calificación media.
     *
     * @return list<array{artist: string, title: string, score: float}>
     */
    private function resolveTopAlbumsByAvgRating(int $limit): array
    {
        return ReviewAlbum::select('album_id', DB::raw('AVG(calificacion) as media'))
            ->groupBy('album_id')
            ->orderByDesc('media')
            ->limit($limit)
            ->with('album.artista')
            ->get()
            ->map(function (ReviewAlbum $row): ?array {
                $album = $row->album;
                if (!$album)
                    return null;

                $artist = $album->artista_nombre
                    ?? ($album->artista?->nombre ?? null);

                return $artist ? [
                    'artist' => $artist,
                    'title' => $album->titulo,
                    'score' => (float) $row->media,
                ] : null;
            })
            ->filter()
            ->values()
            ->toArray();
    }
}
