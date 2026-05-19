<?php

declare(strict_types=1);

namespace App\Services;

use App\Exceptions\LastFmApiException;
use Illuminate\Http\Client\Response;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

/**
 * Servicio de integración con la API pública de Last.fm.
 *
 * Las credenciales y ajustes se inyectan desde config/services.php
 * (que a su vez lee del .env), siguiendo el patrón recomendado por Laravel.
 *
 * Las consultas a la BD NO se realizan aquí: los métodos que necesitan IDs
 * o datos del repositorio los reciben como parámetros, manteniendo el servicio
 * desacoplado de Eloquent/ORM.
 */
class LastFmService
{
    // ─── Configuración ────────────────────────────────────────────────────────

    private readonly string $apiKey;
    private readonly string $baseUrl;
    private readonly int $searchLimit;
    private readonly int $cacheTtl;
    protected string $spotifyAccessToken = '';

    /** @var array<string, string> */
    private readonly array $brokenImageMap;

    // ─── Constructor (Inyección de dependencias) ───────────────────────────────

    /**
     * CAMBIO: se eliminó env() directo. Ahora todo viene de config('services.lastfm.*'),
     * que es la forma recomendada en Laravel para no acoplar el código al entorno. y no regalarlas las apis por github
     */
    public function __construct()
    {
        $this->apiKey = (string) config('services.lastfm.api_key', '');
        $this->baseUrl = (string) config('services.lastfm.base_url', 'http://ws.audioscrobbler.com/2.0/');
        $this->searchLimit = (int) config('services.lastfm.search_limit', 5);
        $this->cacheTtl = (int) config('services.lastfm.cache_ttl', 3600);
        $this->brokenImageMap = (array) config('services.lastfm.broken_image_map', []);
    }

    // ─── Búsquedas ────────────────────────────────────────────────────────────

    /**
     * Busca artistas por nombre.
     *
     * @return array{artists: list<array{id: string, name: string, country: string, score: int, image: string|null}>}
     * @throws LastFmApiException
     */
    public function searchArtist(string $query): array
    {
        $response = $this->request([
            'method' => 'artist.search',
            'artist' => $query,
            'limit' => $this->searchLimit,
        ]);

        $artists = $response['results']['artistmatches']['artist'] ?? [];

        return ['artists' => array_map([$this, 'formatArtist'], $artists)];
    }

    /**
     * Busca álbumes por nombre.
     *
     * 
     *
     * @return array{albums: list<array{name: string, artist: string, image: string|null, score: null}>}
     * @throws LastFmApiException
     */
    public function searchAlbum(string $query): array
    {
        $response = $this->request([
            'method' => 'album.search',
            'album' => $query,
            'limit' => $this->searchLimit,
        ]);

        $albums = $response['results']['albummatches']['album'] ?? [];

        return ['albums' => array_map([$this, 'formatAlbumSearchResult'], $albums)];
    }

    // ─── Información detallada ─────────────────────────────────────────────────

    /**
     * Obtiene información completa de un álbum (portada, plays, oyentes, tracklist…).
     *
     * @return array{title: string, artist: string, plays: int, listeners: int, image: string|null, year: string, tracks: list<array{name: string, duration: int}>, description: string, tags: list<string>}
     * @throws LastFmApiException
     */
    public function getAlbumInfo(string $artist, string $album): array
    {
        $data = $this->request([
            'method' => 'album.getinfo',
            'artist' => $artist,
            'album' => $album,
            'lang' => 'es',
        ]);

        // Fallback a inglés si no hay wiki en español
        if (empty($data['album']['wiki']['summary'])) {
            try {
                $dataEn = $this->request([
                    'method' => 'album.getinfo',
                    'artist' => $artist,
                    'album' => $album,
                ]);
                if (!empty($dataEn['album']['wiki'])) {
                    $data['album']['wiki'] = $dataEn['album']['wiki'];
                }
            } catch (LastFmApiException) {
                // Si el fallback también falla, continuamos con lo que hay
            }
        }

        $info = $data['album'] ?? [];

        return [
            'title' => (string) ($info['name'] ?? $album),
            'artist' => (string) ($info['artist'] ?? $artist),
            'plays' => (int) ($info['playcount'] ?? 0),
            'listeners' => (int) ($info['listeners'] ?? 0),
            'image' => $this->extractBestImage($info['image'] ?? []),
            'year' => $this->extractYear($info),
            'tracks' => $this->extractTracks($info['tracks']['track'] ?? []),
            'description' => $this->extractDescription($info),
            'tags' => $this->extractGenreTags($info),
        ];
    }

    /**
     * Obtiene información completa de un artista desde Last.fm + Spotify.
     */
    public function getArtistInfo(string $artistName): array
    {
        $cacheKey = 'artist_info_' . md5($artistName);

        return Cache::remember($cacheKey, $this->cacheTtl, function () use ($artistName): array {
            // Info básica del artista desde Last.fm
            $data = $this->request([
                'method' => 'artist.getinfo',
                'artist' => $artistName,
                'lang' => 'es',
            ]);

            $info = $data['artist'] ?? [];

            // Fallback a inglés si no hay bio en español
            if (empty($info['bio']['summary'])) {
                try {
                    $dataEn = $this->request([
                        'method' => 'artist.getinfo',
                        'artist' => $artistName,
                    ]);
                    if (!empty($dataEn['artist']['bio']['summary'])) {
                        $info['bio'] = $dataEn['artist']['bio'];
                    }
                } catch (LastFmApiException) {
                }
            }

            // Top álbumes del artista
            $albumsData = $this->request([
                'method' => 'artist.gettopalbums',
                'artist' => $artistName,
                'limit' => 6,
            ]);
            $topAlbums = $albumsData['topalbums']['album'] ?? [];

            // Tags/géneros
            $tags = $info['tags']['tag'] ?? [];
            if (isset($tags['name']))
                $tags = [$tags];
            $genres = array_slice(array_map(
                fn($t) => ucwords(strtolower($t['name'] ?? '')),
                (array) $tags
            ), 0, 3);

            // Bio limpia
            $bio = '';
            if (!empty($info['bio']['summary'])) {
                $bio = preg_replace('/<a href=".*?">.*?<\/a>/i', '', $info['bio']['summary']) ?? '';
                $bio = trim(strip_tags($bio));
            }

            // Foto del artista desde Spotify
            $imageUrl = $this->fetchArtistImageFromSpotify($artistName);

            // Álbumes formateados
            $albums = array_map(function ($album) {
                return [
                    'name' => $album['name'] ?? '',
                    'image' => $this->extractBestImage($album['image'] ?? []),
                ];
            }, $topAlbums);

            return [
                'name' => (string) ($info['name'] ?? $artistName),
                'image' => $imageUrl,
                'bio' => $bio ?: 'Sin biografía disponible.',
                'genres' => $genres ?: ['Desconocido'],
                'listeners' => (int) ($info['stats']['listeners'] ?? 0),
                'playcount' => (int) ($info['stats']['playcount'] ?? 0),
                'albums' => $albums,
            ];
        });
    }

    // ─── Colecciones (reciben datos ya resueltos desde fuera) ──────────────────

    /**
     * Devuelve información de Last.fm para un conjunto de álbumes ya seleccionados.
     *

     * La clave de caché se genera a partir de un hash de los IDs consultados,
     * por lo que se invalida automáticamente si cambia el conjunto de álbumes.
     *
     * @param  list<array{artist: string, title: string}> $albums
     * @return list<array<string, mixed>>
     */
    public function getFeaturedAlbums(array $albums): array
    {
        // CAMBIO: clave de caché dinámica basada en el conjunto de álbumes
        $cacheKey = 'featured_albums_' . md5(serialize($albums));

        return Cache::remember($cacheKey, $this->cacheTtl, function () use ($albums): array {
            return array_values(array_filter(array_map(function (array $item): ?array {
                try {
                    return $this->getAlbumInfo($item['artist'], $item['title']);
                } catch (LastFmApiException $e) {
                    Log::warning('LastFm: no se pudo obtener info de álbum destacado', [
                        'album' => $item,
                        'error' => $e->getMessage(),
                    ]);
                    return null;
                }
            }, $albums)));
        });
    }

    /**
     * Devuelve los álbumes de la sección "Recomendación de la semana".
     *
     * 
     * @return list<array<string, mixed>>
     */
    public function getWeeklyRecommendation(): array
    {
        return Cache::remember('weekly_promo_albums', $this->cacheTtl, function (): array {
            /** @var list<array{artist: string, album: string, score: string}> $picks */
            $picks = (array) config('services.lastfm.weekly_picks', []);

            $results = [];
            foreach ($picks as $pick) {
                try {
                    $info = $this->getAlbumInfo($pick['artist'], $pick['album']);
                    $info['score'] = $pick['score'];
                    $results[] = $info;
                } catch (LastFmApiException $e) {
                    Log::warning('LastFm: no se pudo obtener recomendación semanal', [
                        'pick' => $pick,
                        'error' => $e->getMessage(),
                    ]);
                }
            }

            return $results;
        });
    }

    /**
     * Devuelve información de Last.fm para álbumes de la sección de reseñas.
     *
     * @param  list<array{artist: string, title: string, score: float|string}> $albums
     * @return list<array<string, mixed>>
     */
    public function getReviewAlbums(array $albums): array
    {
        $cacheKey = 'review_albums_' . md5(serialize($albums));

        return Cache::remember($cacheKey, $this->cacheTtl, function () use ($albums): array {
            $results = [];
            foreach ($albums as $item) {
                try {
                    $info = $this->getAlbumInfo($item['artist'], $item['title']);
                    $info['score'] = number_format((float) $item['score'], 1);
                    $results[] = $info;
                } catch (LastFmApiException $e) {
                    Log::warning('LastFm: no se pudo obtener álbum de reseña', [
                        'album' => $item,
                        'error' => $e->getMessage(),
                    ]);
                }
            }
            return $results;
        });
    }

    /**
     * Carga artistas populares en tiempo real desde Last.fm.
     *
     * @return list<array{name: string, listeners: int, image: string|null}>
     */
    public function getPopularArtists(): array
    {
        return Cache::remember('popular_artists_dynamic', $this->cacheTtl, function (): array {
            $data = $this->request(['method' => 'chart.gettopartists', 'limit' => 10]);
            $artists = $data['artists']['artist'] ?? [];

            // Ordenar por listeners descendente antes de procesar
            usort($artists, fn($a, $b) => (int) ($b['listeners'] ?? 0) <=> (int) ($a['listeners'] ?? 0));

            // Quedarnos solo con los 6 primeros
            $artists = array_slice($artists, 0, 6);

            $results = [];
            foreach ($artists as $artistData) {
                $artistName = (string) ($artistData['name'] ?? '');
                $listeners = (int) ($artistData['listeners'] ?? $artistData['playcount'] ?? 0);
                $imageUrl = $this->fetchArtistImageFromSpotify($artistName);

                $results[] = [
                    'name' => $artistName,
                    'listeners' => (int) $listeners,
                    'image' => $imageUrl,
                ];
            }

            return $results;
        });
    }

    private function getSpotifyToken(): string
    {
        if (!empty($this->spotifyAccessToken)) {
            return $this->spotifyAccessToken;
        }

        try {
            $response = Http::asForm()->post(config('services.spotify.auth_url'), [
                'grant_type' => 'client_credentials',
                'client_id' => config('services.spotify.client_id'),
                'client_secret' => config('services.spotify.client_secret'),
            ]);

            if ($response->successful()) {
                $this->spotifyAccessToken = $response->json()['access_token'];
                return $this->spotifyAccessToken;
            }
        } catch (\Exception $e) {
            \Log::error('Spotify auth failed: ' . $e->getMessage());
        }

        throw new LastFmApiException('No se pudo autenticar con Spotify');
    }

    /**
     * Devuelve álbumes de lanzamiento reciente desde Spotify API.
     * Filtra por mes y año actual, país ES.
     */
    public function getNewReleases(): array
    {
        $cacheKey = 'new_releases_spotify_' . date('Y_m');

        return Cache::remember($cacheKey, 3600, function (): array {
            try {
                $token = $this->getSpotifyToken();

                // Spotify ha restringido el endpoint /browse/new-releases. por lo que tengo que usar /search como alternativa.
                $response = Http::withToken($token)->get(
                    config('services.spotify.api_url') . '/search',
                    [
                        'q' => 'tag:new',
                        'type' => 'album',
                    ]
                );

                if (!$response->successful()) {
                    \Log::error('Spotify search failed', [
                        'status' => $response->status(),
                        'body' => $response->body(),
                        'url' => config('services.spotify.api_url') . '/search'
                    ]);
                    return [];
                }

                $albums = $response->json()['albums']['items'] ?? [];
                if (empty($albums)) {
                    \Log::warning('Spotify returned empty albums list');
                }

                $results = [];
                foreach ($albums as $album) {
                    $releaseTimestamp = strtotime($album['release_date']);
                    $ninetyDaysAgo = strtotime('-90 days');
                    if ($releaseTimestamp < $ninetyDaysAgo) {
                        \Log::debug('Album filtered out: ' . $album['name'] . ' release_date: ' . $album['release_date']);
                        continue;
                    }

                    $imageUrl = $album['images'][0]['url'] ?? null;
                    $artistName = $album['artists'][0]['name'] ?? 'Desconocido';

                    // Intentar traer info completa de Last.fm para descripción y tags
                    $albumInfo = null;
                    try {
                        $albumInfo = $this->getAlbumInfo($artistName, $album['name']);
                    } catch (LastFmApiException) {
                        // Si Last.fm falla, usamos datos de Spotify como fallback
                    }

                    $results[] = [
                        'name' => $album['name'],
                        'artist' => $artistName,
                        'image' => $imageUrl,
                        'release_date' => date('d/m/Y', strtotime($album['release_date'])),
                        'year' => date('Y', strtotime($album['release_date'])),
                        'plays' => $albumInfo['plays'] ?? 0,
                        'listeners' => $albumInfo['listeners'] ?? 0,
                        'tracks' => $albumInfo['tracks'] ?? [],
                        'description' => $albumInfo['description'] ?? 'Sin descripción disponible.',
                        'tags' => $albumInfo['tags'] ?? ['Desconocido'],
                        'score' => null,
                    ];

                    if (count($results) >= 8) {
                        break;
                    }
                }

                return $results;
            } catch (\Exception $e) {
                \Log::error('getNewReleases failed: ' . $e->getMessage());
                return [];
            }
        });
    }

    // ─── HTTP helper ───────────────────────────────────────────────────────────

    /**
     * Realiza una petición GET a la API de Last.fm y devuelve los datos decodificados.
     *
     * 
     * 
     * @param  array<string, mixed> $params
     * @return array<string, mixed>
     * @throws LastFmApiException
     */
    private function request(array $params): array
    {
        $params = array_merge([
            'api_key' => $this->apiKey,
            'format' => 'json',
        ], $params);

        $method = (string) ($params['method'] ?? 'unknown');

        try {
            /** @var Response $response */
            $response = Http::get($this->baseUrl, $params);
        } catch (\Throwable $e) {
            throw new LastFmApiException(
                "Error de red al llamar a Last.fm [{$method}]: {$e->getMessage()}",
                $method
            );
        }

        if (!$response->successful()) {
            throw new LastFmApiException(
                "Last.fm [{$method}] devolvió HTTP {$response->status()}",
                $method
            );
        }

        $data = $response->json() ?? [];

        // Last.fm puede devolver 200 OK con un bloque de error interno
        if (isset($data['error'])) {
            throw new LastFmApiException(
                "Last.fm [{$method}] error {$data['error']}: " . ($data['message'] ?? ''),
                $method
            );
        }

        return $data;
    }

    // ─── Formatters privados ───────────────────────────────────────────────────

    /**
     *
     * @param  array<string, mixed> $artist
     * @return array{id: string, name: string, country: string, score: int, image: string|null}
     */
    private function formatArtist(array $artist): array
    {
        $images = $artist['image'] ?? [];

        // Preferimos extralarge; si no existe, el último disponible
        $imageUrl = null;
        foreach ($images as $img) {
            if (($img['size'] ?? '') === 'extralarge' && !empty($img['#text'])) {
                $imageUrl = $img['#text'];
                break;
            }
        }
        if ($imageUrl === null && !empty($images)) {
            $imageUrl = (string) (end($images)['#text'] ?? '');
            $imageUrl = $imageUrl === '' ? null : $imageUrl;
        }

        return [
            'id' => (string) ($artist['mbid'] ?? uniqid('', true)),
            'name' => (string) ($artist['name'] ?? ''),
            'country' => 'Oyentes: ' . number_format((int) ($artist['listeners'] ?? 0)),
            'score' => 100,
            'image' => $imageUrl,
        ];
    }

    /**
     * 
     * @param  array<string, mixed> $album
     * @return array{name: string, artist: string, image: string|null, score: null}
     */
    private function formatAlbumSearchResult(array $album): array
    {
        return [
            'name' => (string) ($album['name'] ?? ''),
            'artist' => (string) ($album['artist'] ?? ''),
            'image' => $this->extractBestImage($album['image'] ?? []),
            'score' => null,
        ];
    }

    /**
     * Extrae la URL de imagen de mayor calidad de un array de imágenes de Last.fm,
     * aplicando el mapa de imágenes rotas definido en la configuración.
     *
     * @param  array<int, array{#text: string, size: string}> $images
     */
    private function extractBestImage(array $images): ?string
    {
        foreach (array_reverse($images) as $img) {
            $url = (string) ($img['#text'] ?? '');
            if ($url === '') {
                continue;
            }

            // Sustituir imágenes cuyo hash coincida con una entrada del mapa de rotas
            foreach ($this->brokenImageMap as $brokenFragment => $replacement) {
                if (str_contains($url, $brokenFragment)) {
                    return $replacement;
                }
            }

            return $url;
        }

        return null;
    }

    /**
     * Extrae el año de lanzamiento de los tags o de la fecha wiki.
     *
     * @param array<string, mixed> $info
     */
    private function extractYear(array $info): string
    {
        $tags = $info['tags']['tag'] ?? [];
        if (isset($tags['name'])) {
            $tags = [$tags]; // Last.fm puede devolver un objeto en lugar de array es posible pasa en algunos
        }

        foreach ((array) $tags as $tag) {
            $name = trim((string) ($tag['name'] ?? ''));
            if (preg_match('/^(19|20)\d{2}$/', $name)) {
                return $name;
            }
        }

        $published = (string) ($info['wiki']['published'] ?? '');
        if ($published !== '' && preg_match('/(19|20)\d{2}/', $published, $m)) {
            return $m[0];
        }

        return 'Desconocido';
    }

    /**
     * Extrae el tracklist normalizado.
     *
     * @param  array<mixed>|array{name: string, duration: mixed} $tracksData
     * @return list<array{name: string, duration: int}>
     */
    private function extractTracks(array $tracksData): array
    {
        $tracks = [];

        if (isset($tracksData[0])) {
            foreach ($tracksData as $track) {
                $tracks[] = [
                    'name' => (string) ($track['name'] ?? ''),
                    'duration' => (int) ($track['duration'] ?? 0),
                ];
            }
        } elseif (isset($tracksData['name'])) {
            $tracks[] = [
                'name' => (string) ($tracksData['name'] ?? ''),
                'duration' => (int) ($tracksData['duration'] ?? 0),
            ];
        }

        return $tracks;
    }

    public function getSpotifyTokenPublic(): string
    {
        return $this->getSpotifyToken();
    }

    /**
     * Extrae y sanitiza la descripción wiki del álbum.
     *
     * @param array<string, mixed> $info
     */
    private function extractDescription(array $info): string
    {
        $summary = (string) ($info['wiki']['summary'] ?? '');
        if ($summary === '') {
            return 'Sin descripción disponible.';
        }

        // Elimina los enlaces "Read more on Last.fm" que Last.fm inyecta al final
        $summary = preg_replace('/<a href=".*?">.*?<\/a>/i', '', $summary) ?? $summary;

        return trim(strip_tags($summary));
    }

    /**
     * Extrae hasta 3 etiquetas de género, filtrando las inutilizables de Last.fm.
     *
     * @param  array<string, mixed> $info
     * @return list<string>
     */
    private function extractGenreTags(array $info): array
    {
        $rawTags = $info['tags']['tag'] ?? [];
        if (isset($rawTags['name'])) {
            $rawTags = [$rawTags];
        }

        $ignored = ['albums i own', 'favorite albums'];
        $genreTags = [];

        foreach ((array) $rawTags as $t) {
            $name = strtolower(trim((string) ($t['name'] ?? '')));
            if (!in_array($name, $ignored, true) && !is_numeric($name)) {
                $genreTags[] = ucwords($name);
            }
            if (count($genreTags) >= 3) {
                break;
            }
        }

        return $genreTags ?: ['Desconocido'];
    }

    /**
     * Obtiene la imagen del álbum top de un artista como fallback de imagen de artista
     * last fm no da imágenes de artistas por lo que se usa la del álbum top
     */
    private function fetchArtistImageFallback(string $artistName): ?string
    {
        try {
            $data = $this->request([
                'method' => 'artist.gettopalbums',
                'artist' => $artistName,
                'limit' => 1,
            ]);
            $topAlbum = $data['topalbums']['album'][0] ?? null;
            if ($topAlbum) {
                return $this->extractBestImage($topAlbum['image'] ?? []);
            }
        } catch (LastFmApiException $e) {
            Log::warning('LastFm: no se pudo obtener imagen de artista', [
                'artist' => $artistName,
                'error' => $e->getMessage(),
            ]);
        }

        return null;
    }
    /**
     * Obtiene la foto real del artista desde Spotify Search API.
     * Fallback a Last.fm (portada de álbum) si Spotify falla.
     */
    private function fetchArtistImageFromSpotify(string $artistName): ?string
    {
        try {
            $token = $this->getSpotifyToken();

            $response = Http::withToken($token)->get(
                config('services.spotify.api_url') . '/search',
                [
                    'q' => $artistName,
                    'type' => 'artist',
                    'limit' => 1,
                ]
            );

            if ($response->successful()) {
                $artists = $response->json()['artists']['items'] ?? [];
                if (!empty($artists) && !empty($artists[0]['images'])) {
                    // Spotify devuelve imágenes ordenadas de mayor a menor resolución
                    return $artists[0]['images'][0]['url'] ?? null;
                }
            }
        } catch (\Exception $e) {
            Log::warning('Spotify artist image failed, falling back to Last.fm', [
                'artist' => $artistName,
                'error' => $e->getMessage(),
            ]);
        }

        // Fallback a Last.fm si Spotify falla
        return $this->fetchArtistImageFallback($artistName);
    }
}
