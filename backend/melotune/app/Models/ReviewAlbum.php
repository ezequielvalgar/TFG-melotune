<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReviewAlbum extends Model
{
    use HasFactory;

    protected $table = 'reviews_albumes';
    public $timestamps = false;

    protected $fillable = [
        'usuario_id',
        'album_id',
        'calificacion',
        'titulo',
        'contenido',
        'fecha_creacion',
        'fecha_modificacion',
        'likes',
    ];

    public function usuario()
    {
        return $this->belongsTo(User::class, 'usuario_id');
    }

    public function album()
    {
        return $this->belongsTo(Album::class, 'album_id');
    }
}
