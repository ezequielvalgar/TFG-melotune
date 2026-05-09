import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Album, Artist } from '../models/music.models';

@Injectable({ providedIn: 'root' })
export class MusicService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:8000/api/music';

  searchArtists(query: string): Observable<{ artists: Artist[] }> {
    return this.http.get<{ artists: Artist[] }>(`${this.apiUrl}/artists/search?q=${query}`);
  }

  searchAlbums(query: string): Observable<{ albums: Album[] }> {
    return this.http.get<{ albums: Album[] }>(`${this.apiUrl}/albums/search?q=${query}`);
  }

  searchSpotify(query: string): Observable<{ albums: Album[]; artists: Artist[] }> {
    return this.http.get<{ albums: Album[]; artists: Artist[] }>(
      `${this.apiUrl}/search?q=${encodeURIComponent(query)}`
    );
  }

  getAlbumDetails(artist: string, album: string): Observable<Album> {
    return this.http.get<Album>(
      `${this.apiUrl}/album-info?artist=${encodeURIComponent(artist)}&album=${encodeURIComponent(album)}`
    );
  }

  getFeaturedAlbums(): Observable<Album[]> {
    return this.http.get<Album[]>(`${this.apiUrl}/featured-albums`);
  }

  getPopularArtists(): Observable<Artist[]> {
    return this.http.get<Artist[]>(`${this.apiUrl}/popular-artists`);
  }

  getWeeklyPromo(): Observable<Album[]> {
    return this.http.get<Album[]>(`${this.apiUrl}/weekly-promo`);
  }

  getReviewAlbums(): Observable<Album[]> {
    return this.http.get<Album[]>(`${this.apiUrl}/review-albums`);
  }

  getNewReleases(): Observable<Album[]> {
    return this.http.get<Album[]>(`${this.apiUrl}/new-releases`);
  }

  searchUsers(query: string): Observable<{ users: { id: number; username: string; nombre: string; foto_perfil: string; followers_count: number }[] }> {
    return this.http.get<{ users: { id: number; username: string; nombre: string; foto_perfil: string; followers_count: number }[] }>(
      `${this.apiUrl}/search-users?q=${encodeURIComponent(query)}`
    );
  }

  getArtistInfo(artist: string): Observable<Artist> {
    return this.http.get<Artist>(`${this.apiUrl}/artist-info?artist=${encodeURIComponent(artist)}`);
  }
}
