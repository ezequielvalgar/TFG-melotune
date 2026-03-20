<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReviewCancion extends Model
{
    use HasFactory;

    protected $table = 'reviews_canciones';
    public $timestamps = false;

    protected $fillable = [
        'usuario_id',
        'cancion_id',
        'calificacion',
        'comentario',
        'fecha_creacion',
        'likes',
    ];

    public function usuario()
    {
        return $this->belongsTo(User::class, 'usuario_id');
    }

    public function cancion()
    {
        return $this->belongsTo(Cancion::class, 'cancion_id');
    }
}
