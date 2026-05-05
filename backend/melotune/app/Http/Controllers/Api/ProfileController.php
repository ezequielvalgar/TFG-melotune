<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{
    /**
     * Actualiza la información del perfil del usuario logueado.
     * Soporta multipart/form-data para poder subir una foto de perfil.
     */
    public function update(Request $request)
    {
        $user = $request->user();

        // Validar la entrada
        $validator = Validator::make($request->all(), [
            'nombre'      => 'nullable|string|max:50',
            'bio'         => 'nullable|string|max:500',
            'foto_perfil' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048', // max 2MB
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Actualizar datos de texto
        if ($request->has('nombre')) {
            $user->nombre = $request->nombre;
        }

        if ($request->has('bio')) {
            $user->bio = $request->bio;
        }

        // Gestionar la subida del avatar
        $fotoPerfil = null; // URL final de la foto (null si no se cambió)

        if ($request->hasFile('foto_perfil')) {
            $file = $request->file('foto_perfil');

            // Borrar foto anterior si era de nuestro storage
            // Leer el raw attr antes de que el accessor lo transforme
            $rawFoto = $user->getRawOriginal('foto_perfil');
            if ($rawFoto && str_starts_with($rawFoto, 'http') && str_contains($rawFoto, '/storage/avatars/')) {
                $oldStoragePath = 'avatars/' . basename($rawFoto);
                if (Storage::disk('public')->exists($oldStoragePath)) {
                    Storage::disk('public')->delete($oldStoragePath);
                }
            }

            // Guardar el archivo
            $path = $file->store('avatars', 'public');

            // URL pública absoluta
            $fotoPerfil = url(Storage::url($path));

            // Actualizar directamente en BD para evitar la caché del accessor de Eloquent
            \DB::table('usuarios')->where('id', $user->id)->update(['foto_perfil' => $fotoPerfil]);
        }

        $user->save();

        // Construir la respuesta con la foto_perfil correcta:
        // Si se subió nueva foto, usamos la URL de storage (bypass del accessor cacheado).
        // Si no, el accessor ya devuelve el valor correcto.
        $userData = $user->toArray();
        if ($fotoPerfil !== null) {
            $userData['foto_perfil'] = $fotoPerfil;
        }

        return response()->json([
            'message' => 'Perfil actualizado correctamente',
            'user'    => $userData
        ], 200);
    }
}
