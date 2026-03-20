<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lista extends Model
{
    use HasFactory;

    protected $table = 'listas';
    public $timestamps = false;

    protected $fillable = [
        'usuario_id',
        'nombre',
        'descripcion',
        'publica',
        'fecha_creacion',
    ];

    public function usuario()
    {
        return $this->belongsTo(User::class, 'usuario_id');
    }

    public function albumes()
    {
        return $this->belongsToMany(Album::class, 'listas_albumes', 'lista_id', 'album_id')
            ->withPivot('orden', 'fecha_agregado');
    }
}
