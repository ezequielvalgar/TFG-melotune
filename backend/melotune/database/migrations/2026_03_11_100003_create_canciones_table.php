<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('canciones', function (Blueprint $table) {
            $table->id();
            $table->string('titulo', 200);
            $table->foreignId('album_id')->nullable()->constrained('albumes')->nullOnDelete();
            $table->foreignId('artista_id')->constrained('artistas')->cascadeOnDelete();
            $table->integer('duracion')->nullable()->comment('en segundos');
            $table->integer('numero_pista')->nullable();

            $table->index('titulo', 'idx_titulo');
            $table->index('album_id', 'idx_album');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('canciones');
    }
};
