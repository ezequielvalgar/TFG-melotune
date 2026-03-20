<?php

namespace App\Http\Controllers;

use App\Models\ReviewCancion;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class ReviewCancionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return ReviewCancion::with(['usuario', 'cancion'])->get();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'usuario_id' => [
                'required',
                'integer',
                'exists:usuarios,id',
                Rule::unique('reviews_canciones')->where(fn ($query) => $query->where('cancion_id', $request->cancion_id))
            ],
            'cancion_id' => 'required|integer|exists:canciones,id',
            'calificacion' => 'required|numeric|min:0.5|max:5.0',
            'comentario' => 'nullable|string',
            'likes' => 'integer',
        ]);

        $review = ReviewCancion::create($validated);
        return response()->json($review, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $review = ReviewCancion::with(['usuario', 'cancion'])->find($id);
        if (!$review) return response()->json(['message' => 'Not found'], 404);
        return $review;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $review = ReviewCancion::find($id);
        if (!$review) return response()->json(['message' => 'Not found'], 404);

        $validated = $request->validate([
            'calificacion' => 'numeric|min:0.5|max:5.0',
            'comentario' => 'nullable|string',
            'likes' => 'integer',
        ]);

        $review->update($validated);
        return response()->json($review, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $review = ReviewCancion::find($id);
        if (!$review) return response()->json(['message' => 'Not found'], 404);

        $review->delete();
        return response()->json(null, 204);
    }
}
