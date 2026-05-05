<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Follower extends Model
{
    use HasFactory;

    protected $fillable = ['follower_id', 'following_id'];

    // Relación: usuario que sigue
    public function follower(): BelongsTo
    {
        return $this->belongsTo(User::class, 'follower_id');
    }

    // Relación: usuario seguido
    public function following(): BelongsTo
    {
        return $this->belongsTo(User::class, 'following_id');
    }
}
