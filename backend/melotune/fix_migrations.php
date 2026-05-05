<?php
// Script temporal para marcar migraciones existentes como completadas
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;

// Obtener todas las migraciones pendientes (archivos .php en database/migrations)
$migrationFiles = glob(__DIR__.'/database/migrations/*.php');

foreach ($migrationFiles as $file) {
    $name = pathinfo($file, PATHINFO_FILENAME);
    $exists = DB::table('migrations')->where('migration', $name)->first();
    if (!$exists) {
        DB::table('migrations')->insert(['migration' => $name, 'batch' => 1]);
        echo "Marked: $name\n";
    } else {
        echo "Already tracked: $name\n";
    }
}
echo "Done!\n";
