<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LikeReview extends Model
{
    protected $table = 'likes_reviews_albumes';
    public $timestamps = false;

    protected $fillable = ['usuario_id', 'review_id', 'fecha'];

    public function review()
    {
        return $this->belongsTo(ReviewAlbum::class, 'review_id');
    }
}
