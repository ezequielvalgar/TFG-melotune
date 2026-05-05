<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Album extends Model
{
    protected $table = 'albumes';
    public $timestamps = false;

    protected $fillable = [
        'titulo', 'artista_id', 'artista_nombre', 'fecha_lanzamiento',
        'genero', 'portada', 'imagen_url', 'duracion', 'discografica', 'descripcion'
    ];

    public function artista()
    {
        return $this->belongsTo(Artista::class, 'artista_id');
    }

    public function reviews()
    {
        return $this->hasMany(ReviewAlbum::class, 'album_id');
    }
}
