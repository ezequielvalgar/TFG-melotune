<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * @extends Factory<User>
 */
class UserFactory extends Factory
{
    /**
     * The current password being used by the factory.
     */
    protected static ?string $password;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $username = fake()->unique()->userName();
        
        return [
            'username' => $username,
            'email' => fake()->unique()->safeEmail(),
            'password' => static::$password ??= Hash::make('password'),
            'nombre' => fake()->name(),
            'bio' => fake()->realText(100),
            'foto_perfil' => null, // Dejamos que el accesor genere el avatar por UI-Avatars
            'fecha_registro' => fake()->dateTimeBetween('-1 year', 'now'),
            'activo' => 1,
            'email_verified_at' => now(),
        ];
    }

    /**
     * Indicate that the model's email address should be unverified.
     */
    public function unverified(): static
    {
        return $this->state(fn (array $attributes) => [
            'email_verified_at' => null,
        ]);
    }
}
