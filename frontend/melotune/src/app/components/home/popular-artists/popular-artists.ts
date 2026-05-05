import { Component, inject, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { MusicService } from '../../../services/music.service';

@Component({
  selector: 'app-popular-artists',
  imports: [CommonModule, RouterLink],
  templateUrl: './popular-artists.html',
  styleUrl: './popular-artists.css',
  standalone: true
})
export class PopularArtistsComponent implements OnInit {
  private musicService = inject(MusicService);
  private cdr = inject(ChangeDetectorRef);
  
  popularArtists: any[] = [];
  isLoading = true;

  fallbackArtists = [
    { name: 'MGMT', genre: 'Indie Pop / Psychedelic Rock', listeners: 14500000, image: 'https://placehold.co/100/222436/60658a?text=MGMT' },
    { name: 'THE NEIGHBOURHOOD', genre: 'Indie Rock / Alternative', listeners: 23100000, image: 'https://placehold.co/100/222436/60658a?text=The' },
    { name: 'DRAKE', genre: 'Hip-Hop / R&B', listeners: 68400000, image: 'https://placehold.co/100/222436/60658a?text=Drake' },
    { name: 'TAME IMPALA', genre: 'Psychedelic Pop', listeners: 28900000, image: 'https://placehold.co/100/222436/60658a?text=Tame+Impala' },
    { name: 'FRANK OCEAN', genre: 'R&B / Art Pop', listeners: 32500000, image: 'https://placehold.co/100/222436/60658a?text=Frank+Ocean' },
    { name: 'KENDRICK LAMAR', genre: 'Hip-Hop', listeners: 45200000, image: 'https://placehold.co/100/222436/60658a?text=Kendrick' },
  ];

  ngOnInit() {
    this.musicService.getPopularArtists().subscribe({
      next: (artists) => {
        this.popularArtists = artists.map((apiArtist: any) => {
          return {
            name: apiArtist.name,
            listeners: apiArtist.listeners || 0,
            image: apiArtist.image || 'https://placehold.co/100/222436/60658a?text=' + apiArtist.name
          };
        });
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.popularArtists = this.fallbackArtists;
        this.isLoading = false;
        this.cdr.detectChanges();
      }
    });
  }

  formatListeners(val: number): string {
    if (val >= 1000000) return (val / 1000000).toFixed(1) + 'M oyentes';
    if (val >= 1000) return (val / 1000).toFixed(1) + 'K oyentes';
    return val + ' oyentes';
  }
}
