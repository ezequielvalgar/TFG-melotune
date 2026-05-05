import { Component, inject, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-verify-email',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './verify-email.html',
  styleUrl: './verify-email.css'
})
export class VerifyEmailComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private http = inject(HttpClient);
  private cdr = inject(ChangeDetectorRef);
  
  status: 'loading' | 'success' | 'error' = 'loading';
  message: string = 'Verificando tu cuenta...';

  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      const token = params['token'];
      if (!token) {
        this.status = 'error';
        this.message = 'Token de verificación no proporcionado.';
        this.cdr.detectChanges();
        return;
      }

      this.http.post('http://127.0.0.1:8000/api/verify-email', { token }).subscribe({
        next: (res: any) => {
          this.status = 'success';
          this.message = '¡Tu correo ha sido verificado con éxito! Ya puedes iniciar sesión.';
          this.cdr.detectChanges();
        },
        error: (err) => {
          this.status = 'error';
          this.message = err.error?.message || 'El enlace de verificación es inválido o ha expirado.';
          this.cdr.detectChanges();
        }
      });
    });
  }
}
