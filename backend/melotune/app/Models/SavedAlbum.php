<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SavedAlbum extends Model
{
    protected $table = 'saved_albums';

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