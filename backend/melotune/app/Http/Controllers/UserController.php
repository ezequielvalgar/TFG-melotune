<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return User::all();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'username' => 'required|string|max:50|unique:usuarios,username',
            'email' => 'required|string|email|max:100|unique:usuarios,email',
            'password' => 'required|string|min:8',
            'nombre' => 'nullable|string|max:100',
            'bio' => 'nullable|string',
            'foto_perfil' => 'nullable|string|max:255',
        ]);

        $user = User::create($validated);
        return response()->json($user, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id): \Illuminate\Http\JsonResponse
    {
        $user = User::findOrFail($id);

        return response()->json([
            'id'          => $user->id,
            'username'    => $user->username,
            'nombre'      => $user->nombre,
            'foto_perfil' => $user->foto_perfil,
            'bio'         => $user->bio,
            'created_at'  => $user->created_at,
            'followers_count' => $user->followersCount(),
            'following_count' => $user->followingCount(),
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $user = User::find($id);
        if (!$user) return response()->json(['message' => 'Not found'], 404);

        $validated = $request->validate([
            'username' => 'string|max:50|unique:usuarios,username,' . $id,
            'email' => 'string|email|max:100|unique:usuarios,email,' . $id,
            'password' => 'string|min:8',
            'nombre' => 'nullable|string|max:100',
            'bio' => 'nullable|string',
            'foto_perfil' => 'nullable|string|max:255',
            'activo' => 'boolean',
        ]);

        $user->update($validated);
        return response()->json($user, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $user = User::find($id);
        if (!$user) return response()->json(['message' => 'Not found'], 404);

        $user->delete();
        return response()->json(null, 204);
    }
}
