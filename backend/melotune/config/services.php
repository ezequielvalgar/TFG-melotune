<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'postmark' => [
        'key' => env('POSTMARK_API_KEY'),
    ],

    'resend' => [
        'key' => env('RESEND_API_KEY'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'slack' => [
        'notifications' => [
            'bot_user_oauth_token' => env('SLACK_BOT_USER_OAUTH_TOKEN'),
            'channel' => env('SLACK_BOT_USER_DEFAULT_CHANNEL'),
        ],
    ],

    'spotify' => [
        'client_id'     => env('SPOTIFY_CLIENT_ID'),
        'client_secret' => env('SPOTIFY_CLIENT_SECRET'),
        'auth_url'      => 'https://accounts.spotify.com/api/token',
        'api_url'       => 'https://api.spotify.com/v1',
    ],

    // ─── Last.fm ──────────────────────────────────────────────────────────────
    'lastfm' => [
        'api_key'      => env('LASTFM_API_KEY'),
        'base_url'     => env('LASTFM_BASE_URL', 'http://ws.audioscrobbler.com/2.0/'),
        'search_limit' => (int) env('LASTFM_SEARCH_LIMIT', 5),
        'cache_ttl'    => (int) env('LASTFM_CACHE_TTL', 3600),

        // Álbumes destacados de la sección "Recomendación de la semana".
        // Extraídos de aquí para no tenerlos hardcodeados en el servicio.
        'weekly_picks' => [
            ['artist' => 'Kendrick Lamar', 'album' => 'Good Kid, m.A.A.d City', 'score' => '4.8'],
            ['artist' => 'Frank Ocean',    'album' => 'Blonde',                  'score' => '4.8'],
            ['artist' => 'Tame Impala',    'album' => 'Currents',                'score' => '4.7'],
        ],

        // URLs de imagen conocidas como rotas en los CDNs de Last.fm,
        // mapeadas a su alternativa funcional.
        'broken_image_map' => [
            '17150c2fd9b34cedb7b12e367809a4d2.png'
                => 'https://upload.wikimedia.org/wikipedia/en/2/2f/Iloveyou_the_neighbourhood.jpeg',
        ],
    ],

];
