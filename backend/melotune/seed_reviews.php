<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Artista;
use App\Models\Album;
use App\Models\ReviewAlbum;
use App\Models\User;

$seedData = [
    [
        'artista' => 'Tame Impala',
        'album' => ['titulo' => 'Currents', 'portada' => 'https://lastfm.freetls.fastly.net/i/u/300x300/dd45b0438a315aed98b5830aa2fc43c5.png'],
        'review' => [
            'usuario_email' => 'testuser@example.com',
            'calificacion' => 5.0, 'titulo' => 'Una obra maestra de la psicodelia moderna',
            'contenido' => 'Currents es un disco que te envuelve completamente. Desde la obertura de Let It Happen hasta el cierre de New Person, Same Old Mistakes, Kevin Parker construye un universo sonoro que mezcla melancolía y euforia con una habilidad extraordinaria. Cada escucha revela nuevas capas.',
            'etiquetas' => ['Obra maestra', 'Produccion impecable', 'Para auriculares'],
            'cancion_favorita' => 'Let It Happen', 'vibe_factor' => 80, 'likes' => 42,
            'contexto_escucha' => 'Auriculares / Noche',
            'encuesta' => ['lyricsLiked' => true, 'listenAgain' => true, 'recommend' => true],
        ]
    ],
    [
        'artista' => 'Frank Ocean',
        'album' => ['titulo' => 'Blonde', 'portada' => 'https://lastfm.freetls.fastly.net/i/u/300x300/82c92f044b27db86328ed6be3f8a735a.png'],
        'review' => [
            'usuario_email' => 'testuser@example.com',
            'calificacion' => 5.0, 'titulo' => 'Intimidad en forma de álbum',
            'contenido' => 'Blonde es incómodo, fragmentado y absolutamente genial. Frank Ocean construye momentos de una vulnerabilidad aplastante. Nights es quizás el punto más alto, pero el conjunto es más grande que la suma de sus partes.',
            'etiquetas' => ['Letras profundas', 'Emotivo', 'Experimental'],
            'cancion_favorita' => 'Nights', 'vibe_factor' => 30, 'likes' => 67,
            'contexto_escucha' => 'Auriculares / Noche',
            'encuesta' => ['lyricsLiked' => true, 'listenAgain' => true, 'recommend' => true],
        ]
    ],
    [
        'artista' => 'Kendrick Lamar',
        'album' => ['titulo' => 'good kid, m.A.A.d city', 'portada' => 'https://lastfm.freetls.fastly.net/i/u/300x300/48628c6af67db437b0b9ff156b2c1085.png'],
        'review' => [
            'usuario_email' => 'testuser@example.com',
            'calificacion' => 5.0, 'titulo' => 'El mejor álbum conceptual de rap',
            'contenido' => 'Kendrick logró algo que pocos raperos consiguen: crear una película en audio. Cada transición, cada interludio de buzón de voz, cada beat cuenta parte de la historia. Money Trees sola vale el precio de entrada.',
            'etiquetas' => ['Obra maestra', 'Letras profundas', 'Album conceptual'],
            'cancion_favorita' => 'Money Trees', 'vibe_factor' => 50, 'likes' => 89,
            'contexto_escucha' => 'Altavoces / Día',
            'encuesta' => ['lyricsLiked' => true, 'listenAgain' => true, 'recommend' => true],
        ]
    ],
    [
        'artista' => 'MGMT',
        'album' => ['titulo' => 'Oracular Spectacular', 'portada' => 'https://lastfm.freetls.fastly.net/i/u/300x300/32774a8d1143a4a7087f4a18d5e2ede2.png'],
        'review' => [
            'usuario_email' => 'testuser@example.com',
            'calificacion' => 4.0, 'titulo' => 'El sonido de una generación',
            'contenido' => 'Kids y Electric Feel son canciones perfectas. El álbum en general tiene algunas caídas de ritmo pero el nivel de los singles es inalcanzable. MGMT capturó algo mágico en este debut.',
            'etiquetas' => ['Bailable', 'Nostalgico', 'Singles potentes'],
            'cancion_favorita' => 'Kids', 'vibe_factor' => 75, 'likes' => 31,
            'contexto_escucha' => 'Altavoces / Día',
            'encuesta' => ['lyricsLiked' => true, 'listenAgain' => true, 'recommend' => true],
        ]
    ],
    [
        'artista' => 'Drake',
        'album' => ['titulo' => 'Take Care', 'portada' => 'https://lastfm.freetls.fastly.net/i/u/300x300/87079d08fe90541db827b7ddd08a30c7.png'],
        'review' => [
            'usuario_email' => 'testuser@example.com',
            'calificacion' => 4.0, 'titulo' => 'El rap emocional en su punto más alto',
            'contenido' => 'Take Care fue un punto de inflexión. Drake mostró que el hip-hop podía ser vulnerable sin perder fuerza. La producción es fría y etérea. Marvins Room sigue siendo perturbadora.',
            'etiquetas' => ['Emotivo', 'Para la noche'],
            'cancion_favorita' => 'Marvins Room', 'vibe_factor' => 25, 'likes' => 45,
            'contexto_escucha' => 'Auriculares / Noche',
            'encuesta' => ['lyricsLiked' => true, 'listenAgain' => false, 'recommend' => true],
        ]
    ],
];

// Buscar un usuario existente para asignarle las reseñas
$user = User::first();
if (!$user) {
    echo "ERROR: No hay usuarios en la BD. Regístrate primero.\n";
    exit(1);
}
echo "Usando usuario: {$user->username} (ID: {$user->id})\n\n";

foreach ($seedData as $seed) {
    $artista = Artista::firstOrCreate(
        ['nombre' => $seed['artista']],
        ['nombre' => $seed['artista']]
    );

    $album = Album::firstOrCreate(
        ['titulo' => $seed['album']['titulo'], 'artista_id' => $artista->id],
        [
            'titulo' => $seed['album']['titulo'],
            'artista_id' => $artista->id,
            'artista_nombre' => $seed['artista'],
            'portada' => $seed['album']['portada'],
            'imagen_url' => $seed['album']['portada'],
        ]
    );

    $exists = ReviewAlbum::where('usuario_id', $user->id)->where('album_id', $album->id)->exists();
    if ($exists) {
        echo "Ya existe reseña de {$seed['artista']} - {$seed['album']['titulo']}, saltando...\n";
        continue;
    }

    $r = $seed['review'];
    ReviewAlbum::create([
        'usuario_id'     => $user->id,
        'album_id'       => $album->id,
        'calificacion'   => $r['calificacion'],
        'titulo'         => $r['titulo'],
        'contenido'      => $r['contenido'],
        'etiquetas'      => json_encode($r['etiquetas']),
        'encuesta'       => json_encode($r['encuesta']),
        'cancion_favorita' => $r['cancion_favorita'],
        'vibe_factor'    => $r['vibe_factor'],
        'likes'          => $r['likes'],
        'contexto_escucha' => $r['contexto_escucha'],
    ]);
    echo "✓ Creada: {$seed['artista']} - {$seed['album']['titulo']} ({$r['calificacion']}★)\n";
}
echo "\n¡Seed completo!\n";
