<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Album extends Model
{
    use HasFactory;

    protected $table = 'albumes';
    public $timestamps = false;

    protected $fillable = [
        'titulo',
        'artista_id',
        'fecha_lanzamiento',
        'genero',
        'portada',
        'duracion',
        'discografica',
        'descripcion',
    ];

    public function artista()
    {
        return $this->belongsTo(Artista::class, 'artista_id');
    }

    public function canciones()
    {
        return $this->hasMany(Cancion::class, 'album_id');
    }

    public function reviews()
    {
        return $this->hasMany(ReviewAlbum::class, 'album_id');
    }
}
