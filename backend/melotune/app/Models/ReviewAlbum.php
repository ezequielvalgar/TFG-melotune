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
        'etiquetas',
        'encuesta',
        'preguntas_guia',
        'contexto_escucha',
        'cancion_favorita',
        'vibe_factor',
        'likes',
        'evolucion',
        'primera_mencion'
    ];

    protected $casts = [
        'etiquetas' => 'array',
        'encuesta' => 'array',
        'preguntas_guia' => 'array',
        'calificacion' => 'float',
        'likes' => 'integer',
    ];

    public function usuario()
    {
        return $this->belongsTo(User::class, 'usuario_id');
    }

    public function album()
    {
        return $this->belongsTo(Album::class, 'album_id');
    }

    public function likesPorUsuario()
    {
        return $this->hasMany(LikeReview::class, 'review_id');
    }
}
