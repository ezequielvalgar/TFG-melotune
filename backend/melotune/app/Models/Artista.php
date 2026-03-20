<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Artista extends Model
{
    use HasFactory;

    protected $table = 'artistas';
    public $timestamps = false;

    protected $fillable = [
        'nombre',
        'biografia',
        'imagen',
        'genero',
        'pais',
        'fecha_creacion',
    ];

    public function albumes()
    {
        return $this->hasMany(Album::class, 'artista_id');
    }

    public function canciones()
    {
        return $this->hasMany(Cancion::class, 'artista_id');
    }
}
