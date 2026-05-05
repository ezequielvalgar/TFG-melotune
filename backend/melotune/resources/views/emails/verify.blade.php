<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verifica tu cuenta en MeloTune</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #0e0f1a;
            font-family: 'Inter', 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: #ffffff;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .card {
            background-color: #1a1c2e;
            border-radius: 16px;
            padding: 40px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.05);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }
        .logo {
            font-size: 28px;
            font-weight: 900;
            letter-spacing: 3px;
            color: #ffffff;
            text-decoration: none;
            margin-bottom: 30px;
            display: inline-block;
        }
        .logo-icon {
            color: #ff3366;
            margin-right: 8px;
        }
        h1 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 16px;
            color: #ffffff;
        }
        p {
            font-size: 16px;
            line-height: 1.6;
            color: #a0a5c0;
            margin-bottom: 30px;
        }
        .btn {
            display: inline-block;
            background-color: #ff3366;
            color: #ffffff;
            text-decoration: none;
            padding: 14px 32px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #e62e5c;
        }
        .footer {
            margin-top: 40px;
            text-align: center;
            font-size: 12px;
            color: #60658a;
        }
        .link {
            color: #ff3366;
            word-break: break-all;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="logo">
                <span class="logo-icon">🎵</span> MELOTUNE
            </div>
            <h1>¡Hola, {{ $user->nombre ?? $user->username }}!</h1>
            <p>Bienvenido a MeloTune. Estamos emocionados de tenerte en nuestra comunidad de amantes de la música. Para empezar a compartir reseñas y descubrir nuevos álbumes, por favor verifica tu dirección de correo electrónico.</p>
            
            <a href="{{ $verificationUrl }}" class="btn">Verificar mi cuenta</a>
            
            <p style="margin-top: 40px; font-size: 14px;">
                Si el botón no funciona, copia y pega este enlace en tu navegador:<br>
                <a href="{{ $verificationUrl }}" class="link">{{ $verificationUrl }}</a>
            </p>
        </div>
        <div class="footer">
            &copy; {{ date('Y') }} MeloTune. Todos los derechos reservados.<br>
            Si no creaste esta cuenta, puedes ignorar este correo.
        </div>
    </div>
</body>
</html>
