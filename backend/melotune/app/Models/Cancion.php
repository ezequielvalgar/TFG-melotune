<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cancion extends Model
{
    use HasFactory;

    protected $table = 'canciones';
    public $timestamps = false;

    protected $fillable = [
        'titulo',
        'album_id',
        'artista_id',
        'duracion',
        'numero_pista',
    ];

    public function album()
    {
        return $this->belongsTo(Album::class, 'album_id');
    }

    public function artista()
    {
        return $this->belongsTo(Artista::class, 'artista_id');
    }

    public function reviews()
    {
        return $this->hasMany(ReviewCancion::class, 'cancion_id');
    }
}
