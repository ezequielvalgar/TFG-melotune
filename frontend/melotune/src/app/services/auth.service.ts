import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, tap, Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private http = inject(HttpClient);
  private apiUrl = 'http://127.0.0.1:8000/api';

  // BehaviorSubject que mantiene el estado global del usuario logeado
  private currentUserSubject = new BehaviorSubject<any>(null);
  
  // Observable público para que el Navbar se suscriba
  public currentUser$ = this.currentUserSubject.asObservable();

  constructor() {
    // Al iniciar, intentar cargar de LocalStorage si cerró el navegador estando logeado.
    this.loadUserFromStorage();
  }

  // Método temporal para cargar un usuario mockeado directamente si no queremos pasar por pantalla login aún
  mockLogin() {
    const fakeUser = {
      id: 1,
      username: 'soundwaves_alex',
      nombre: 'Alex Rivera',
      foto_perfil: 'https://ui-avatars.com/api/?name=Alex&background=1a1c2e&color=E83E8C&size=200&bold=true'
    };
    this.currentUserSubject.next(fakeUser);
    localStorage.setItem('user', JSON.stringify(fakeUser));
    localStorage.setItem('token', 'fake-token-1234');
  }

  login(credentials: {email: string, password: string}): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/login`, credentials).pipe(
      tap(response => {
        if (response && response.access_token) {
          // El backend asocia una "foto_perfil", en caso de ser "avatar1.jpg" mapearemos a un avatar rico.
          // O asume que "foto_perfil" puede ser un link absoluto.
          let user = response.user;
          // Pequeño parche estético:
          if (user.foto_perfil === 'avatar1.jpg' || user.foto_perfil === 'default.jpg' || !user.foto_perfil) {
             user.foto_perfil = `https://ui-avatars.com/api/?name=${user.username}&background=1a1c2e&color=E83E8C&size=200&bold=true`;
          }

          localStorage.setItem('token', response.access_token);
          localStorage.setItem('user', JSON.stringify(user));
          
          this.currentUserSubject.next(user);
        }
      })
    );
  }

  register(userData: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/register`, userData);
  }

  verifyEmail(token: string): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/verify-email`, { token });
  }

  // Permite actualizar el perfil del usuario activo enviando FormData
  updateProfile(formData: FormData): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/profile`, formData).pipe(
      tap(response => {
        if (response.user) {
          const current = this.currentUserSubject.value;
          let updatedUser = { ...current, ...response.user };

          if (updatedUser.foto_perfil === 'avatar1.jpg' || updatedUser.foto_perfil === 'default.jpg' || !updatedUser.foto_perfil) {
             updatedUser.foto_perfil = `https://ui-avatars.com/api/?name=${updatedUser.username}&background=1a1c2e&color=E83E8C&size=200&bold=true`;
          }

          this.currentUserSubject.next(updatedUser);
          localStorage.setItem('user', JSON.stringify(updatedUser));
        }
      })
    );
  }

  logout() {
    // Intenta cerrar en backend también si estuviera conectado
    const token = localStorage.getItem('token');
    if (token && token !== 'fake-token-1234') {
      this.http.post(`${this.apiUrl}/logout`, {}, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      }).subscribe({
        next: () => {},
        error: () => {}
      });
    }

    // Cerramos en Front
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    this.currentUserSubject.next(null);
  }

  private loadUserFromStorage() {
    const userStr = localStorage.getItem('user');
    if (userStr) {
      try {
        let user = JSON.parse(userStr);
        if (user.foto_perfil === 'avatar1.jpg' || user.foto_perfil === 'default.jpg' || !user.foto_perfil) {
             user.foto_perfil = `https://ui-avatars.com/api/?name=${user.username}&background=1a1c2e&color=E83E8C&size=200&bold=true`;
        }
        this.currentUserSubject.next(user);
      } catch (e) {
        // failed to parse
      }
    }
  }

  get currentUserValue() {
    return this.currentUserSubject.value;
  }

  isLoggedIn(): boolean {
    return !!this.currentUserSubject.value;
  }
}
