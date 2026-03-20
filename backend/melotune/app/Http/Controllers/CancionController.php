<?php

namespace App\Http\Controllers;

use App\Models\Cancion;
use Illuminate\Http\Request;

class CancionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Cancion::with(['album', 'artista'])->get();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'titulo' => 'required|string|max:200',
            'album_id' => 'nullable|integer|exists:albumes,id',
            'artista_id' => 'required|integer|exists:artistas,id',
            'duracion' => 'nullable|integer',
            'numero_pista' => 'nullable|integer',
        ]);

        $cancion = Cancion::create($validated);
        return response()->json($cancion, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $cancion = Cancion::with(['album', 'artista'])->find($id);
        if (!$cancion) return response()->json(['message' => 'Not found'], 404);
        return $cancion;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $cancion = Cancion::find($id);
        if (!$cancion) return response()->json(['message' => 'Not found'], 404);

        $validated = $request->validate([
            'titulo' => 'string|max:200',
            'album_id' => 'nullable|integer|exists:albumes,id',
            'artista_id' => 'integer|exists:artistas,id',
            'duracion' => 'nullable|integer',
            'numero_pista' => 'nullable|integer',
        ]);

        $cancion->update($validated);
        return response()->json($cancion, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $cancion = Cancion::find($id);
        if (!$cancion) return response()->json(['message' => 'Not found'], 404);

        $cancion->delete();
        return response()->json(null, 204);
    }
}
