<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('likes_reviews_albumes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
            $table->foreignId('review_id')->constrained('reviews_albumes')->cascadeOnDelete();
            $table->timestamp('fecha')->useCurrent();

            $table->unique(['usuario_id', 'review_id'], 'unique_like');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('likes_reviews_albumes');
    }
};
