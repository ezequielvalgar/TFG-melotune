import { Component, inject, OnInit } from '@angular/core';
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
export class HeaderComponent implements OnInit {
  private authService = inject(AuthService);
  private router = inject(Router);

  // Observable que la vista suscribirá asíncronamente
  currentUser$ = this.authService.currentUser$;
  isDropdownOpen = false;
  isDarkMode = true;

  ngOnInit() {
    const savedTheme = localStorage.getItem('theme');
    if (savedTheme === 'light') {
        this.isDarkMode = false;
        document.documentElement.setAttribute('data-theme', 'light');
    }
  }

  toggleTheme(): void {
      this.isDarkMode = !this.isDarkMode;
      const theme = this.isDarkMode ? 'dark' : 'light';
      localStorage.setItem('theme', theme);
      document.documentElement.setAttribute('data-theme', this.isDarkMode ? '' : 'light');
  }

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
