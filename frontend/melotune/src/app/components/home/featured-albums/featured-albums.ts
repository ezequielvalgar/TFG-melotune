import { Component, inject, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { MusicService } from '../../../services/music.service';

@Component({
  selector: 'app-featured-albums',
  imports: [CommonModule, RouterLink],
  templateUrl: './featured-albums.html',
  styleUrl: './featured-albums.css',
  standalone: true
})
export class FeaturedAlbumsComponent implements OnInit {
  private musicService = inject(MusicService);
  private cdr = inject(ChangeDetectorRef);

  featuredAlbums: any[] = [];
  isLoading = true;
  isPaused = false;

  ngOnInit() {
    this.musicService.getFeaturedAlbums().subscribe({
      next: (albums: any) => {
        this.featuredAlbums = (Array.isArray(albums) ? albums : albums.albums) || [];
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.isLoading = false;
        this.cdr.detectChanges();
      }
    });
  }

  pauseMarquee() { this.isPaused = true; }
  resumeMarquee() { this.isPaused = false; }

  formatPlays(val: number): string {
    if (val >= 1000000) return (val / 1000000).toFixed(1) + 'M';
    if (val >= 1000) return (val / 1000).toFixed(1) + 'K';
    return val.toString();
  }

  fullStars(rating: number): number[] {
    return Array(Math.floor(rating || 0)).fill(0);
  }

  hasHalfStar(rating: number): boolean {
    return (rating || 0) % 1 >= 0.5;
  }

  emptyStars(rating: number): number[] {
    const full = Math.floor(rating || 0);
    const half = this.hasHalfStar(rating) ? 1 : 0;
    return Array(Math.max(0, 5 - full - half)).fill(0);
  }
}