import { Component, inject, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { MusicService } from '../../../services/music.service';

@Component({
  selector: 'app-sidebar-promo',
  imports: [CommonModule, RouterLink],
  templateUrl: './sidebar-promo.html',
  styleUrl: './sidebar-promo.css',
  standalone: true
})
export class SidebarPromoComponent implements OnInit {
  private musicService = inject(MusicService);
  private cdr = inject(ChangeDetectorRef);
  
  topAlbums: any[] = [];
  isLoading = true;

  fallbackAlbums = [
    { title: 'Good Kid, m.A.A.d City', artist: 'Kendrick Lamar', score: '4.8', image: 'https://placehold.co/100/222436/60658a?text=Good' },
    { title: 'Blonde', artist: 'Frank Ocean', score: '4.8', image: 'https://placehold.co/100/222436/60658a?text=Blonde' },
    { title: 'Currents', artist: 'Tame Impala', score: '4.7', image: 'https://placehold.co/100/222436/60658a?text=Currents' },
    { title: 'Take Care', artist: 'Drake', score: '4.7', image: 'https://placehold.co/100/222436/60658a?text=Take+Care' },
    { title: 'Channel Orange', artist: 'Frank Ocean', score: '4.6', image: 'https://placehold.co/100/222436/60658a?text=Channel' },
  ];

  ngOnInit() {
    this.musicService.getWeeklyPromo().subscribe({
      next: (albums) => {
        this.topAlbums = albums;
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.topAlbums = this.fallbackAlbums;
        this.isLoading = false;
        this.cdr.detectChanges();
      }
    });
  }

  // --- LÓGICA DE ESTRELLAS MEJORADA ---

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
