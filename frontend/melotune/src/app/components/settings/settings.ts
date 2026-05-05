import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { ThemeService } from '../../services/theme.service';

@Component({
  selector: 'app-settings',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './settings.html',
  styleUrl: './settings.css'
})
export class SettingsComponent implements OnInit {
  private themeService = inject(ThemeService);

  darkMode: boolean = true;
  language: string = 'es';
  emailNotifications: boolean = true;
  newFollowerNotification: boolean = true;
  newReviewNotification: boolean = true;

  toastVisible = false;

  ngOnInit() {
    const saved = localStorage.getItem('melotune_settings');
    if (saved) {
      try {
        const prefs = JSON.parse(saved);
        this.darkMode               = prefs.darkMode               ?? true;
        this.language               = prefs.language               ?? 'es';
        this.emailNotifications     = prefs.emailNotifications     ?? true;
        this.newFollowerNotification = prefs.newFollowerNotification ?? true;
        this.newReviewNotification  = prefs.newReviewNotification  ?? true;
      } catch { /* localStorage corrupto, usa defaults */ }
    }
  }

  toggleDarkMode() {
    this.darkMode = !this.darkMode;
    this.themeService.applyTheme(this.darkMode);
    this.saveSettings();
  }

  saveSettings() {
    localStorage.setItem('melotune_settings', JSON.stringify({
      darkMode:                this.darkMode,
      language:                this.language,
      emailNotifications:      this.emailNotifications,
      newFollowerNotification: this.newFollowerNotification,
      newReviewNotification:   this.newReviewNotification,
    }));
    this.showToast();
  }

  private showToast() {
    this.toastVisible = true;
    setTimeout(() => this.toastVisible = false, 2500);
  }
}
