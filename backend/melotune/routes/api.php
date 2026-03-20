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

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// Endpoints Públcos (o privados según se requiera, los dejaremos públicos para lectura por ahora)
Route::apiResource('users', UserController::class);
Route::apiResource('artistas', ArtistaController::class);
Route::apiResource('albumes', AlbumController::class);
Route::apiResource('canciones', CancionController::class);
Route::apiResource('reviews-albumes', ReviewAlbumController::class);
Route::apiResource('reviews-canciones', ReviewCancionController::class);
Route::apiResource('listas', ListaController::class);
