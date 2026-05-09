<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FavoriteArtist extends Model
{
    protected $table = 'favorite_artists';

    public $timestamps = false;

    protected $fillable = [
        'usuario_id',
        'artist_nombre',
        'artist_imagen',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'usuario_id');
    }
}
