<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Casts\Attribute;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'usuarios';
    public $timestamps = false;
    const CREATED_AT = 'fecha_registro';
    const UPDATED_AT = null;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'username',
        'email',
        'password',
        'nombre',
        'bio',
        'foto_perfil',
        'fecha_registro',
        'activo',
        'verification_token',
        'email_verified_at',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
    ];

    /**
     * Atributos que se añaden al JSON.
     */
    protected $appends = [];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'password' => 'hashed',
        ];
    }

    /**
     * Accessor para asegurar que la foto de perfil siempre sea una URL válida y absoluta.
     */
    protected function fotoPerfil(): Attribute
    {
        return Attribute::make(
            get: function ($value) {
                if (empty($value) || $value === 'default.jpg' || $value === 'avatar1.jpg') {
                    return 'https://ui-avatars.com/api/?name=' . urlencode($this->username) . '&background=1a1c2e&color=E83E8C&size=200&bold=true';
                }

                if (str_starts_with($value, 'http')) {
                    return $value;
                }

                // Si es una ruta local en storage/avatars/...
                $path = str_starts_with($value, 'storage/') ? $value : 'storage/' . $value;
                return url($path);
            }
        );
    }

    // Usuarios que me siguen
    public function followers()
    {
        return $this->hasMany(Follower::class, 'following_id');
    }

    // Usuarios a los que sigo
    public function following()
    {
        return $this->hasMany(Follower::class, 'follower_id');
    }

    // Helpers
    public function isFollowing(int $userId): bool
    {
        return $this->following()->where('following_id', $userId)->exists();
    }

    public function followersCount(): int
    {
        return $this->followers()->count();
    }

    public function followingCount(): int
    {
        return $this->following()->count();
    }
}
