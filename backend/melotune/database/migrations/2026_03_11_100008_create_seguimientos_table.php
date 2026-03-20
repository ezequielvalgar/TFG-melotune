<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('seguimientos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('seguidor_id')->constrained('usuarios')->cascadeOnDelete();
            $table->foreignId('seguido_id')->constrained('usuarios')->cascadeOnDelete();
            $table->timestamp('fecha_seguimiento')->useCurrent();

            $table->unique(['seguidor_id', 'seguido_id'], 'unique_seguimiento');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('seguimientos');
    }
};
