import { Component, inject, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { finalize } from 'rxjs/operators';

@Component({
  selector: 'app-login-page',
  imports: [CommonModule, FormsModule],
  templateUrl: './login-page.html',
  standalone: true
})
export class LoginPageComponent {
  private authService = inject(AuthService);
  private router = inject(Router);
  private cdr = inject(ChangeDetectorRef);

  email = '';
  password = '';
  username = '';
  nombre = '';
  
  errorMsg = '';
  isLoading = false;
  isRegisterMode = false;
  registrationSuccess = false;

  toggleMode(event: Event) {
    event.preventDefault();
    this.isRegisterMode = !this.isRegisterMode;
    this.errorMsg = '';
    this.registrationSuccess = false;
  }

  onSubmit() {
    if (!this.email || !this.password) return;
    if (this.isRegisterMode && !this.username) return;
    
    this.isLoading = true;
    this.errorMsg = '';

    if (this.isRegisterMode) {
      // Registro
      this.authService.register({
        email: this.email,
        password: this.password,
        username: this.username,
        nombre: this.nombre
      }).pipe(
        finalize(() => {
          this.isLoading = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: () => {
          this.registrationSuccess = true;
          this.isRegisterMode = false;
          this.errorMsg = '';
        },
        error: (err) => {
          console.error("Error en registro:", err);
          this.handleBackendError(err);
        }
      });
    } else {
      // Login normal
      this.authService.login({email: this.email, password: this.password}).pipe(
        finalize(() => {
          this.isLoading = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: () => {
          this.router.navigate(['/']);
        },
        error: (err) => {
          console.error("Error en login:", err);
          this.errorMsg = err.error?.message || 'Error al iniciar sesión.';
        }
      });
    }
  }

  // Parsea errores de validación de Laravel (ej: username ya tomado)
  private handleBackendError(err: any) {
    if (err.error?.errors) {
      const keys = Object.keys(err.error.errors);
      if (keys.length > 0) {
        this.errorMsg = err.error.errors[keys[0]][0];
        return;
      }
    }
    this.errorMsg = err.error?.message || 'Error al procesar la solicitud.';
  }
}
