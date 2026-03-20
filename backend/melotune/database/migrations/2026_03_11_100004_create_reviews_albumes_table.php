<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reviews_albumes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
            $table->foreignId('album_id')->constrained('albumes')->cascadeOnDelete();
            $table->decimal('calificacion', 2, 1)->nullable();
            $table->string('titulo', 200)->nullable();
            $table->text('contenido')->nullable();
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->timestamp('fecha_modificacion')->useCurrent()->useCurrentOnUpdate();
            $table->integer('likes')->default(0);

            $table->unique(['usuario_id', 'album_id'], 'unique_user_album');
            $table->index('usuario_id', 'idx_usuario');
            $table->index('album_id', 'idx_album');
            $table->index('calificacion', 'idx_calificacion');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reviews_albumes');
    }
};
