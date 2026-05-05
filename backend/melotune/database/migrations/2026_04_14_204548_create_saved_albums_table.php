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
        Schema::create('saved_albums', function (Blueprint $table) {
            $table->id();
            $table->integer('usuario_id');
            $table->foreign('usuario_id')->references('id')->on('usuarios')->onDelete('cascade');
            $table->string('album_titulo', 200);
            $table->string('album_artista', 200);
            $table->string('album_portada', 500)->nullable();
            
            // Unconstrained album uniqueness per user
            $table->unique(['usuario_id', 'album_titulo', 'album_artista'], 'user_album_unique');
            
            $table->timestamp('created_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('saved_albums');
    }
};
