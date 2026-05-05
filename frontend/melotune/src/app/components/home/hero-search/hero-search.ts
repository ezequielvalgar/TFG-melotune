import { Component, inject, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Subject, EMPTY, forkJoin, of } from 'rxjs';
import { Router, RouterLink } from '@angular/router';
import { debounceTime, switchMap, catchError } from 'rxjs/operators';
import { MusicService } from '../../../services/music.service';
import { AuthService } from '../../../services/auth.service';

@Component({
  selector: 'app-hero-search',
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './hero-search.html',
  styleUrl: './hero-search.css',
  standalone: true
})
export class HeroSearchComponent {
  private musicService = inject(MusicService);
  protected authService = inject(AuthService);
  private cdr = inject(ChangeDetectorRef);
  private router = inject(Router);
  private searchSubject = new Subject<string>();

  query = '';
  results: any[] = [];
  artistResults: any[] = [];
  searchUsers: any[] = [];
  isSearching = false;

  constructor() {
    this.searchSubject.pipe(
      debounceTime(300),
      switchMap(term => {
        if (!term.trim() || term.trim().length < 2) {
          this.results = [];
          this.artistResults = [];
          this.searchUsers = [];
          this.isSearching = false;
          return EMPTY;
        }
        this.isSearching = true;
        return forkJoin({
            spotify: this.musicService.searchSpotify(term).pipe(catchError(() => of({ albums: [], artists: [] }))),
            users:   this.musicService.searchUsers(term).pipe(catchError(() => of({ users: [] })))
        });
      })
    ).subscribe({
      next: (response: any) => {
          this.results       = response.spotify?.albums  ?? [];
          this.artistResults = response.spotify?.artists ?? [];
          this.searchUsers   = response.users?.users     ?? [];
          this.isSearching   = false;
          this.cdr.detectChanges();
      },
      error: () => {
          this.results       = [];
          this.artistResults = [];
          this.searchUsers   = [];
          this.isSearching   = false;
          this.cdr.detectChanges();
      }
    });
  }

  onSearchChange() {
    this.searchSubject.next(this.query);
  }

  onAlbumSelect(album: any) {
    this.clearSearch();
    const title  = album.name  || album.title;
    const artist = album.artist || 'Artista Desconocido';
    this.router.navigate(['/album', artist, title]);
  }

  clearSearch(): void {
      this.query         = '';
      this.results       = [];
      this.artistResults = [];
      this.searchUsers   = [];
  }

  onArtistSelect(artist: any) {
      this.clearSearch();
      this.router.navigate(['/artist', artist.name]);
  }


  // --- LÓGICA DE ESTRELLAS ---

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
