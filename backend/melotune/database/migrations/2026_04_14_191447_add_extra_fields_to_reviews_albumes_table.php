<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('reviews_albumes', function (Blueprint $table) {
            $table->json('etiquetas')->nullable()->after('contenido');
            $table->json('encuesta')->nullable()->after('etiquetas');
            $table->json('preguntas_guia')->nullable()->after('encuesta');
            $table->string('contexto_escucha', 100)->nullable()->after('preguntas_guia');
            $table->string('cancion_favorita', 200)->nullable()->after('contexto_escucha');
            $table->tinyInteger('vibe_factor')->nullable()->after('cancion_favorita');
        });

        // Añadir artista_nombre e imagen a albumes para denormalizar y simplificar inserción desde Last.fm
        Schema::table('albumes', function (Blueprint $table) {
            $table->string('artista_nombre', 200)->nullable()->after('titulo');
            $table->string('imagen_url', 500)->nullable()->after('portada');
        });
    }

    public function down(): void
    {
        Schema::table('reviews_albumes', function (Blueprint $table) {
            $table->dropColumn(['etiquetas', 'encuesta', 'preguntas_guia', 'contexto_escucha', 'cancion_favorita', 'vibe_factor']);
        });
        Schema::table('albumes', function (Blueprint $table) {
            $table->dropColumn(['artista_nombre', 'imagen_url']);
        });
    }
};
