import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class ThemeService {
  private readonly STORAGE_KEY = 'melotune_settings';

  /** Inicializa el tema al arrancar la app */
  init(): void {
    const dark = this.getDarkModePreference();
    this.applyTheme(dark);
  }

  getDarkModePreference(): boolean {
    try {
      const saved = localStorage.getItem(this.STORAGE_KEY);
      if (saved) {
        const prefs = JSON.parse(saved);
        return prefs.darkMode ?? true;
      }
    } catch { /* ignore */ }
    return true; // dark by default
  }

  applyTheme(dark: boolean): void {
    if (dark) {
      document.documentElement.removeAttribute('data-theme');
    } else {
      document.documentElement.setAttribute('data-theme', 'light');
    }
  }

  toggleDarkMode(dark: boolean): void {
    this.applyTheme(dark);
  }
}
