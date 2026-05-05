<?php

namespace Database\Factories;

use App\Models\ReviewAlbum;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\ReviewAlbum>
 */
class ReviewAlbumFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // IDs enteros reales de la tabla 'albumes' en la base de datos
        $albumIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

        $tags = ['Obra maestra', 'Para llorar', 'Producción increíble', 'Concepto profundo', 'Vibras de verano', 'Voz angelical', 'Experimental', 'Clásico moderno'];

        return [
            'usuario_id' => User::factory(), // O podemos inyectar IDs reales luego
            'album_id' => fake()->randomElement($albumIds),
            'calificacion' => fake()->randomFloat(1, 1, 5), // De 1.0 a 5.0
            'titulo' => fake()->sentence(4),
            'contenido' => fake()->paragraphs(3, true),
            'etiquetas' => fake()->randomElements($tags, rand(1, 3)),
            'encuesta' => [
                'recomendarias' => fake()->boolean(),
                'reproduccion_repetida' => fake()->boolean()
            ],
            'preguntas_guia' => [
                'cancion_destacada' => fake()->sentence(3),
                'momento_escucha' => 'Por la mañana'
            ],
            'contexto_escucha' => 'En casa con auriculares',
            'cancion_favorita' => fake()->words(3, true),
            'vibe_factor' => fake()->numberBetween(1, 5),
            'likes' => fake()->numberBetween(0, 50),
            'fecha_creacion' => fake()->dateTimeBetween('-1 year', 'now'),
            'fecha_modificacion' => fake()->dateTimeBetween('-1 year', 'now'),
        ];
    }
}
