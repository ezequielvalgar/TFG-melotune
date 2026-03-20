<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('albumes', function (Blueprint $table) {
            $table->id();
            $table->string('titulo', 200);
            $table->foreignId('artista_id')->constrained('artistas')->cascadeOnDelete();
            $table->date('fecha_lanzamiento')->nullable();
            $table->string('genero', 100)->nullable();
            $table->string('portada', 255)->nullable();
            $table->integer('duracion')->nullable()->comment('en segundos');
            $table->string('discografica', 100)->nullable();
            $table->text('descripcion')->nullable();

            $table->index('titulo', 'idx_titulo');
            $table->index('artista_id', 'idx_artista');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('albumes');
    }
};
