<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reviews_canciones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
            $table->foreignId('cancion_id')->constrained('canciones')->cascadeOnDelete();
            $table->decimal('calificacion', 2, 1)->nullable();
            $table->text('comentario')->nullable();
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->integer('likes')->default(0);

            $table->unique(['usuario_id', 'cancion_id'], 'unique_user_cancion');
            $table->index('usuario_id', 'idx_usuario');
            $table->index('cancion_id', 'idx_cancion');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reviews_canciones');
    }
};
