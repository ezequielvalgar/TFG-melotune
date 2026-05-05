<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FavoriteAlbum extends Model
{
    protected $table = 'favorite_albums';

    public $timestamps = false;

    protected $fillable = [
        'usuario_id',
        'album_titulo',
        'album_artista',
        'album_portada',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'usuario_id');
    }
}