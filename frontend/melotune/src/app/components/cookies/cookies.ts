import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-cookies',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './cookies.html',
  styleUrl: './cookies.css'
})
export class CookiesComponent {
  functionalEnabled = signal(true);
  analyticsEnabled = signal(false);
  marketingEnabled = signal(false);

  toggleFunctional() {
    this.functionalEnabled.set(!this.functionalEnabled());
  }

  toggleAnalytics() {
    this.analyticsEnabled.set(!this.analyticsEnabled());
  }

  toggleMarketing() {
    this.marketingEnabled.set(!this.marketingEnabled());
  }

  acceptAll() {
    this.functionalEnabled.set(true);
    this.analyticsEnabled.set(true);
    this.marketingEnabled.set(true);
  }

  rejectOptional() {
    this.functionalEnabled.set(false);
    this.analyticsEnabled.set(false);
    this.marketingEnabled.set(false);
  }
}
