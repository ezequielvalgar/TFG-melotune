<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ArtistaController;
use App\Http\Controllers\AlbumController;
use App\Http\Controllers\CancionController;
use App\Http\Controllers\ReviewAlbumController;
use App\Http\Controllers\ReviewCancionController;
use App\Http\Controllers\ListaController;

use App\Http\Controllers\Api\MusicController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ReviewController;
use App\Http\Controllers\Api\FriendsController;

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/verify-email', [AuthController::class, 'verifyEmail']);
Route::middleware('auth:sanctum')->post('/logout', [AuthController::class, 'logout']);
Route::middleware('auth:sanctum')->get('/user', [AuthController::class, 'user']);

// Perfil y Estadísticas
Route::get('/user/{userId}/stats', [\App\Http\Controllers\Api\UserStatsController::class, 'getStats']);
Route::get('/user/{userId}/activity', [\App\Http\Controllers\Api\UserStatsController::class, 'getActivity']);
Route::get('/user/{userId}/favorites', [\App\Http\Controllers\Api\UserStatsController::class, 'getFavorites']);
Route::get('/user/{userId}/favorite-artists', [\App\Http\Controllers\Api\UserStatsController::class, 'getFavoriteArtists']);

// Endpoints de Reseñas
Route::get('/reviews', [ReviewController::class, 'index']);
Route::get('/reviews/user/{userId}', [ReviewController::class, 'byUser']);
Route::get('/albums/{artist}/{title}/reviews', [ReviewController::class, 'byAlbum'])->where('title', '.*');
Route::middleware('auth:sanctum')->group(function () {
    // Rutas de reseñas requeridas de auth
    Route::post('/reviews', [ReviewController::class, 'store']);
    Route::post('/reviews/{id}/like', [ReviewController::class, 'toggleLike']);
    Route::delete('/reviews/{id}', [ReviewController::class, 'destroy']);

    // Perfil y preferencias
    Route::post('/profile/update', [UserController::class, 'updateProfile']);
    Route::post('/profile/update-password', [UserController::class, 'updatePassword']);
    Route::post('/profile/delete-account', [UserController::class, 'deleteAccount']);

    // Amigos (Actividad de seguidos)
    Route::get('/friends/reviews', [FriendsController::class, 'reviews']);
    Route::get('/friends/saved-albums', [FriendsController::class, 'savedAlbums']);
    Route::get('/friends/favorite-albums', [FriendsController::class, 'favoriteAlbums']);

    // Ruta de edición de perfil
    Route::post('/profile', [\App\Http\Controllers\Api\ProfileController::class, 'update']);

    // Rutas de álbumes guardados
    Route::get('/saved-albums', [\App\Http\Controllers\Api\SavedAlbumController::class, 'index']);
    Route::post('/saved-albums/toggle', [\App\Http\Controllers\Api\SavedAlbumController::class, 'toggle']);
    Route::delete('/saved-albums/{id}', [\App\Http\Controllers\Api\SavedAlbumController::class, 'destroy']);

    // Rutas de seguidores (Followers)
    Route::post('/users/{id}/follow', [\App\Http\Controllers\Api\FollowerController::class, 'follow']);
    Route::delete('/users/{id}/unfollow', [\App\Http\Controllers\Api\FollowerController::class, 'unfollow']);

    // Favoritos
    Route::post('/user/favorites/toggle', [\App\Http\Controllers\Api\UserStatsController::class, 'toggleFavorite']);
    Route::post('/user/favorite-artists/toggle', [\App\Http\Controllers\Api\UserStatsController::class, 'toggleFavoriteArtist']);
});

// Rutas de seguidores públicas
Route::get('/users/{id}/followers', [\App\Http\Controllers\Api\FollowerController::class, 'followers']);
Route::get('/users/{id}/following', [\App\Http\Controllers\Api\FollowerController::class, 'following']);
Route::get('/users/{id}/follow-stats', [\App\Http\Controllers\Api\FollowerController::class, 'stats']);

// Endpoints de MusicBrainz (Proxy seguro para evitar CORS en el frontend)
Route::get('/music/artists/search', [MusicController::class, 'searchArtists']);
Route::get('/music/albums/search', [MusicController::class, 'searchAlbums']);
Route::get('/music/search', [MusicController::class, 'searchSpotify']);
Route::get('/music/album-info', [MusicController::class, 'albumInfo']);
Route::get('/music/artist-info', [MusicController::class, 'artistInfo']);
Route::get('/music/featured-albums', [MusicController::class, 'featuredAlbums']);
Route::get('/music/popular-artists', [MusicController::class, 'popularArtists']);
Route::get('/music/weekly-promo', [MusicController::class, 'weeklyPromo']);
Route::get('/music/review-albums', [MusicController::class, 'reviewAlbums']);
Route::get('/music/new-releases', [MusicController::class, 'newReleases']);
Route::get('/music/search-users', [MusicController::class, 'searchUsers']);

// Endpoints Públcos (o privados según se requiera, los dejaremos públicos para lectura por ahora)
Route::apiResource('users', UserController::class);
Route::apiResource('artistas', ArtistaController::class);
Route::apiResource('albumes', AlbumController::class);
Route::apiResource('canciones', CancionController::class);
Route::apiResource('reviews-albumes', ReviewAlbumController::class);
Route::apiResource('reviews-canciones', ReviewCancionController::class);
Route::apiResource('listas', ListaController::class);
