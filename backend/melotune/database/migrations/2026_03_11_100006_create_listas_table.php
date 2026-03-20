<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('listas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
            $table->string('nombre', 200);
            $table->text('descripcion')->nullable();
            $table->boolean('publica')->default(true);
            $table->timestamp('fecha_creacion')->useCurrent();

            $table->index('usuario_id', 'idx_usuario');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('listas');
    }
};
