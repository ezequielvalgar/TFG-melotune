<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Follower;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class FollowerController extends Controller
{
    // POST /api/users/{id}/follow → seguir usuario
    public function follow(int $userId): JsonResponse
    {
        $authUser = Auth::user();

        if ($authUser->id === $userId) {
            return response()->json(['message' => 'No puedes seguirte a ti mismo'], 422);
        }

        if ($authUser->isFollowing($userId)) {
            return response()->json(['message' => 'Ya sigues a este usuario'], 422);
        }

        Follower::create([
            'follower_id'  => $authUser->id,
            'following_id' => $userId,
        ]);

        return response()->json(['message' => 'Ahora sigues a este usuario']);
    }

    // DELETE /api/users/{id}/unfollow → dejar de seguir
    public function unfollow(int $userId): JsonResponse
    {
        $authUser = Auth::user();

        Follower::where('follower_id', $authUser->id)
            ->where('following_id', $userId)
            ->delete();

        return response()->json(['message' => 'Has dejado de seguir a este usuario']);
    }

    // GET /api/users/{id}/followers → lista de seguidores
    public function followers(int $userId): JsonResponse
    {
        $user = User::findOrFail($userId);

        $followers = $user->followers()
            ->with('follower:id,username,nombre,foto_perfil')
            ->get()
            ->map(fn($f) => $f->follower)
            ->filter()
            ->values();

        return response()->json($followers);
    }

    // GET /api/users/{id}/following → lista de seguidos
    public function following(int $userId): JsonResponse
    {
        $user = User::findOrFail($userId);

        $following = $user->following()
            ->with('following:id,username,nombre,foto_perfil')
            ->get()
            ->map(fn($f) => $f->following)
            ->filter()
            ->values();

        return response()->json($following);
    }

    // GET /api/users/{id}/follow-stats → contadores para el perfil
    public function stats(int $userId): JsonResponse
    {
        $user = User::findOrFail($userId);
        $authUser = Auth::guard('sanctum')->user();

        return response()->json([
            'followers_count' => $user->followersCount(),
            'following_count' => $user->followingCount(),
            'is_following'    => $authUser ? $authUser->isFollowing($userId) : false,
        ]);
    }
}
