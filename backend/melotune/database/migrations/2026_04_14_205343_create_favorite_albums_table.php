<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('favorite_albums', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')->constrained('usuarios')->onDelete('cascade');
            $table->string('album_titulo', 200);
            $table->string('album_artista', 200);
            $table->string('album_portada', 500)->nullable();
            
            // Unusuario solo puede tener un álbum como favorito una vez
            $table->unique(['usuario_id', 'album_titulo', 'album_artista'], 'user_favorite_unique');
            
            $table->timestamp('created_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('favorite_albums');
    }
};
