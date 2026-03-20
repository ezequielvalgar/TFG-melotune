<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('listas_albumes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('lista_id')->constrained('listas')->cascadeOnDelete();
            $table->foreignId('album_id')->constrained('albumes')->cascadeOnDelete();
            $table->integer('orden')->default(0);
            $table->timestamp('fecha_agregado')->useCurrent();

            $table->unique(['lista_id', 'album_id'], 'unique_lista_album');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('listas_albumes');
    }
};
