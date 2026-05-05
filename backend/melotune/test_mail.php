<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\Mail;

echo "Enviando email de prueba a ezequiel740511@gmail.com...\n";

try {
    Mail::raw('¡Hola! Este es un email de prueba de MeloTune enviado con Mailtrap.', function ($message) {
        $message->to('ezequiel740511@gmail.com')
            ->subject('MeloTune - Prueba de Email');
    });
    echo "Email enviado correctamente!\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
