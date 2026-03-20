<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('artistas', function (Blueprint $table) {
            $table->id();
            $table->string('nombre', 200);
            $table->text('biografia')->nullable();
            $table->string('imagen', 255)->nullable();
            $table->string('genero', 100)->nullable();
            $table->string('pais', 100)->nullable();
            $table->date('fecha_creacion')->nullable();

            $table->index('nombre', 'idx_nombre');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('artistas');
    }
};
