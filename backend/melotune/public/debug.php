<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);
$response = $kernel->handle(
    $request = Illuminate\Http\Request::capture()
);

$users = \App\Models\User::all(['id', 'username', 'foto_perfil']);
file_put_contents('debug.json', json_encode($users, JSON_PRETTY_PRINT));
echo "Done";
