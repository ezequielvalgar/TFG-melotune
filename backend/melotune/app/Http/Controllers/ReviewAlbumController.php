<?php

namespace App\Http\Controllers;

use App\Models\ReviewAlbum;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class ReviewAlbumController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return ReviewAlbum::with(['usuario', 'album'])->get();
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
                Rule::unique('reviews_albumes')->where(fn ($query) => $query->where('album_id', $request->album_id))
            ],
            'album_id' => 'required|integer|exists:albumes,id',
            'calificacion' => 'required|numeric|min:0.5|max:5.0',
            'titulo' => 'nullable|string|max:200',
            'contenido' => 'nullable|string',
            'likes' => 'integer',
        ]);

        $review = ReviewAlbum::create($validated);
        return response()->json($review, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $review = ReviewAlbum::with(['usuario', 'album'])->find($id);
        if (!$review) return response()->json(['message' => 'Not found'], 404);
        return $review;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $review = ReviewAlbum::find($id);
        if (!$review) return response()->json(['message' => 'Not found'], 404);

        $validated = $request->validate([
            'calificacion' => 'numeric|min:0.5|max:5.0',
            'titulo' => 'nullable|string|max:200',
            'contenido' => 'nullable|string',
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
        $review = ReviewAlbum::find($id);
        if (!$review) return response()->json(['message' => 'Not found'], 404);

        $review->delete();
        return response()->json(null, 204);
    }
}
