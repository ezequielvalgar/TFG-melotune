import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-header',
  imports: [CommonModule, RouterModule],
  templateUrl: './header.html',
  styleUrl: './header.css',
  standalone: true
})
export class HeaderComponent {
  private authService = inject(AuthService);
  private router = inject(Router);

  // Observable que la vista suscribirá asíncronamente
  currentUser$ = this.authService.currentUser$;
  isDropdownOpen = false;

  toggleDropdown() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  logout() {
    this.authService.logout();
    this.isDropdownOpen = false;
    this.router.navigate(['/']);
  }

  openSearch(event?: Event): void {
    if (event) {
      event.preventDefault();
    }
    this.isDropdownOpen = false;
    this.router.navigate(['/'], { fragment: 'buscador' }).then(() => {
      setTimeout(() => {
        const input = document.querySelector('#buscador input') as HTMLInputElement;
        if (input) {
          input.focus();
          input.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
      }, 300);
    });
  }
}
