<?php

namespace App\Http\Controllers;

use App\Models\Lista;
use Illuminate\Http\Request;

class ListaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Lista::with(['usuario', 'albumes'])->get();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'usuario_id' => 'required|integer|exists:usuarios,id',
            'nombre' => 'required|string|max:200',
            'descripcion' => 'nullable|string',
            'publica' => 'boolean',
        ]);

        $lista = Lista::create($validated);
        return response()->json($lista, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $lista = Lista::with(['usuario', 'albumes'])->find($id);
        if (!$lista) return response()->json(['message' => 'Not found'], 404);
        return $lista;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $lista = Lista::find($id);
        if (!$lista) return response()->json(['message' => 'Not found'], 404);

        $validated = $request->validate([
            'nombre' => 'string|max:200',
            'descripcion' => 'nullable|string',
            'publica' => 'boolean',
        ]);

        $lista->update($validated);
        return response()->json($lista, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $lista = Lista::find($id);
        if (!$lista) return response()->json(['message' => 'Not found'], 404);

        $lista->delete();
        return response()->json(null, 204);
    }
}
