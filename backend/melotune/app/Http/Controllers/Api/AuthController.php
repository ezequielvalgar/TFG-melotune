<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Mail;
use App\Mail\VerifyEmail;
use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request)
    {

        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        // Parche temporal para nosotros poder logearnos si las contraseñas originales estaban sin hashear 
        // o no sabemos cuál es. Asumiremos que si la contraseña enviada coincide literalmente, iniciamos.
        // Lo correcto es usar Auth::attempt().
        if (!$user) {
            return response()->json(['message' => 'Credenciales incorrectas'], 401);
        }

        // Check if hash matches
        if (!Hash::check($request->password, $user->password)) {
            // Check if plaintext matches (en caso de que hayan estado en texto plano)
            if ($user->password === $request->password) {
                // actualizamos a hash para el futuro
                $user->password = Hash::make($request->password);
                $user->save();
            } else {
                return response()->json(['message' => 'Credenciales incorrectas'], 401);
            }
        }

        // Verificación de email reactivada (MailerSend funcionando)
        if (is_null($user->email_verified_at)) {
            return response()->json(['message' => 'Por favor verifica tu correo electrónico antes de iniciar sesión. Revisa tu bandeja de entrada o spam.'], 403);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Sesión cerrada exitosamente'
        ]);
    }

    public function verifyEmail(Request $request)
    {
        $request->validate([
            'token' => 'required|string'
        ]);

        $user = User::where('verification_token', $request->token)->first();

        if (!$user) {
            return response()->json(['message' => 'Token de verificación inválido o expirado'], 400);
        }

        $user->email_verified_at = now();
        $user->verification_token = null; // Invalidate the token
        $user->save();

        return response()->json(['message' => 'Email verificado exitosamente']);
    }

    public function user(Request $request) {
        return response()->json($request->user());
    }

    public function register(Request $request)
    {
        $request->validate([
            'username' => 'required|string|max:50|unique:usuarios',
            'email' => 'required|string|email|max:100|unique:usuarios',
            'nombre' => 'nullable|string|max:100',
            'password' => 'required|string|min:6',
        ]);

        $token_verify = Str::random(60);

        $user = User::create([
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'nombre' => $request->nombre,
            'foto_perfil' => 'default.jpg',
            'verification_token' => $token_verify,
            'activo' => 1
        ]);

        // Enviar el correo de verificación apuntando al frontend Angular
        $frontendUrl = env('FRONTEND_URL', 'http://localhost:4200');
        $verifyUrl = "{$frontendUrl}/verify-email?token={$token_verify}";

        try {
            Mail::to($user->email)->send(new VerifyEmail($user, $verifyUrl));
        } catch (\Exception $e) {
            // Log o manejar si falla el correo pero el user se crea igual
        }

        return response()->json([
            'message' => 'Usuario registrado exitosamente. Por favor verifica tu correo.',
            'user' => $user
        ], 201);
    }
}

