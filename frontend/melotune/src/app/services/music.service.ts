import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MusicService {
  private http = inject(HttpClient);
  // URL del backend Laravel (Proxy para evitar bloqueos y CORS de MusicBrainz directamente)
  private apiUrl = 'http://127.0.0.1:8000/api/music';

  searchArtists(query: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/artists/search?q=${query}`);
  }

  searchAlbums(query: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/albums/search?q=${query}`);
  }

  searchSpotify(query: string) {
    return this.http.get<any>(`${this.apiUrl}/search?q=${encodeURIComponent(query)}`);
  }

  getAlbumDetails(artist: string, album: string): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/album-info?artist=${encodeURIComponent(artist)}&album=${encodeURIComponent(album)}`);
  }

  getFeaturedAlbums(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/featured-albums`);
  }

  getPopularArtists(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/popular-artists`);
  }

  getWeeklyPromo(): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/weekly-promo`);
  }

  getReviewAlbums(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/review-albums`);
  }

  getNewReleases() {
    return this.http.get<any[]>(`${this.apiUrl}/new-releases`);
  }

  searchUsers(query: string) {
    return this.http.get<any>(`${this.apiUrl}/search-users?q=${encodeURIComponent(query)}`);
  }

  getArtistInfo(artist: string) {
    return this.http.get<any>(`${this.apiUrl}/artist-info?artist=${encodeURIComponent(artist)}`);
  }
}
