<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Generar 15 usuarios
        $users = clone User::factory(15)->create(); // Hack de clone para calmar intelephense

        $albumIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

        // Para cada usuario, generar de 1 a 4 reseñas de álbumes
        foreach ($users as $user) {
            // Mezclar los ids y coger un subconjunto para no repetir álbumes reseñados
            shuffle($albumIds);
            $numReviews = rand(1, 4);
            $userAlbumIds = array_slice($albumIds, 0, $numReviews);

            foreach ($userAlbumIds as $albumId) {
                \App\Models\ReviewAlbum::factory()->create([
                    'usuario_id' => $user->id,
                    'album_id' => $albumId,
                ]);
            }
        }
    }
}
