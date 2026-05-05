<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\SavedAlbum;
use Illuminate\Http\Request;

class SavedAlbumController extends Controller
{
    /**
     * Listar todos los álbumes guardados del usuario autenticado.
     */
    public function index(Request $request)
    {
        $saved = SavedAlbum::where('usuario_id', $request->user()->id)
            ->latest()
            ->get();

        return response()->json($saved);
    }

    /**
     * Guardar o Alternar (Toggle) un álbum en la lista de guardados.
     */
    public function toggle(Request $request)
    {
        $request->validate([
            'album_titulo'  => 'required|string',
            'album_artista' => 'required|string',
            'album_portada' => 'nullable|string',
        ]);

        $userId = $request->user()->id;

        $existing = SavedAlbum::where('usuario_id', $userId)
            ->where('album_titulo', $request->album_titulo)
            ->where('album_artista', $request->album_artista)
            ->first();

        if ($existing) {
            $existing->delete();
            return response()->json(['message' => 'Álbum eliminado de guardados', 'saved' => false]);
        }

        $saved = SavedAlbum::create([
            'usuario_id'    => $userId,
            'album_titulo'  => $request->album_titulo,
            'album_artista' => $request->album_artista,
            'album_portada' => $request->album_portada,
        ]);

        return response()->json([
            'message' => 'Álbum guardado correctamente',
            'saved'   => true,
            'album'   => $saved
        ]);
    }

    /**
     * Eliminar específicamente un álbum de guardados por su ID.
     */
    public function destroy(Request $request, $id)
    {
        $saved = SavedAlbum::where('id', $id)
            ->where('usuario_id', $request->user()->id)
            ->first();

        if (!$saved) {
            return response()->json(['message' => 'No encontrado'], 404);
        }

        $saved->delete();
        return response()->json(['message' => 'Eliminado de guardados']);
    }
}
