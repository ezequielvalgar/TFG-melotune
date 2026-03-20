<?php

namespace App\Http\Controllers;

use App\Models\Album;
use Illuminate\Http\Request;

class AlbumController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Album::with('artista')->get();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'titulo' => 'required|string|max:200',
            'artista_id' => 'required|integer|exists:artistas,id',
            'fecha_lanzamiento' => 'nullable|date',
            'genero' => 'nullable|string|max:100',
            'portada' => 'nullable|string|max:255',
            'duracion' => 'nullable|integer',
            'discografica' => 'nullable|string|max:100',
            'descripcion' => 'nullable|string',
        ]);

        $album = Album::create($validated);
        return response()->json($album, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $album = Album::with(['artista', 'canciones'])->find($id);
        if (!$album) return response()->json(['message' => 'Not found'], 404);
        return $album;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $album = Album::find($id);
        if (!$album) return response()->json(['message' => 'Not found'], 404);

        $validated = $request->validate([
            'titulo' => 'string|max:200',
            'artista_id' => 'integer|exists:artistas,id',
            'fecha_lanzamiento' => 'nullable|date',
            'genero' => 'nullable|string|max:100',
            'portada' => 'nullable|string|max:255',
            'duracion' => 'nullable|integer',
            'discografica' => 'nullable|string|max:100',
            'descripcion' => 'nullable|string',
        ]);

        $album->update($validated);
        return response()->json($album, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $album = Album::find($id);
        if (!$album) return response()->json(['message' => 'Not found'], 404);

        $album->delete();
        return response()->json(null, 204);
    }
}
