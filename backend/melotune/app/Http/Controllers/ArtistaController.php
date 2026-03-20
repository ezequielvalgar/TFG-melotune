<?php

namespace App\Http\Controllers;

use App\Models\Artista;
use Illuminate\Http\Request;

class ArtistaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Artista::all();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'nombre' => 'required|string|max:200',
            'biografia' => 'nullable|string',
            'imagen' => 'nullable|string|max:255',
            'genero' => 'nullable|string|max:100',
            'pais' => 'nullable|string|max:100',
            'fecha_creacion' => 'nullable|date',
        ]);

        $artista = Artista::create($validated);
        return response()->json($artista, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $artista = Artista::find($id);
        if (!$artista) return response()->json(['message' => 'Not found'], 404);
        return $artista;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $artista = Artista::find($id);
        if (!$artista) return response()->json(['message' => 'Not found'], 404);

        $validated = $request->validate([
            'nombre' => 'string|max:200',
            'biografia' => 'nullable|string',
            'imagen' => 'nullable|string|max:255',
            'genero' => 'nullable|string|max:100',
            'pais' => 'nullable|string|max:100',
            'fecha_creacion' => 'nullable|date',
        ]);

        $artista->update($validated);
        return response()->json($artista, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $artista = Artista::find($id);
        if (!$artista) return response()->json(['message' => 'Not found'], 404);

        $artista->delete();
        return response()->json(null, 204);
    }
}
