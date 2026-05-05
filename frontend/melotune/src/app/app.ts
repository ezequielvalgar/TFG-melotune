import { Component, inject, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { HeaderComponent } from './components/header/header';
import { FooterComponent } from './components/footer/footer';
import { ThemeService } from './services/theme.service';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, HeaderComponent, FooterComponent],
  templateUrl: './app.html',
  styleUrl: './app.css',
  standalone: true
})
export class App {
  protected readonly title = signal('melotune');
  private themeService = inject(ThemeService);

  constructor() {
    this.themeService.init();
  }
}
