import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import {
  Album,
  Artist,
  PaginatedResponse,
  Review,
  ToggleResponse,
} from '../models/music.models';

@Injectable({ providedIn: 'root' })
export class ReviewService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:8000/api';

  /** Obtener todas las reseñas (paginadas) */
  getReviews(page = 1): Observable<PaginatedResponse<Review>> {
    const cacheBuster = new Date().getTime();
    return this.http.get<PaginatedResponse<Review>>(
      `${this.apiUrl}/reviews?page=${page}&_t=${cacheBuster}`
    );
  }

  /** Reseñas de un usuario específico */
  getReviewsByUser(userId: number): Observable<Review[]> {
    return this.http.get<Review[]>(`${this.apiUrl}/reviews/user/${userId}`);
  }

  /** Reseñas de un álbum específico */
  getReviewsByAlbum(artist: string, title: string): Observable<Review[]> {
    return this.http.get<Review[]>(
      `${this.apiUrl}/albums/${encodeURIComponent(artist)}/${encodeURIComponent(title)}/reviews`
    );
  }

  /** Crear una reseña nueva (requiere token) */
  createReview(data: Record<string, unknown>): Observable<Review> {
    return this.http.post<Review>(`${this.apiUrl}/reviews`, data);
  }

  /** Toggle like en una reseña (requiere token) */
  toggleLike(reviewId: number): Observable<ToggleResponse> {
    return this.http.post<ToggleResponse>(`${this.apiUrl}/reviews/${reviewId}/like`, {});
  }

  /** Eliminar una reseña propia (requiere token) */
  deleteReview(reviewId: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/reviews/${reviewId}`);
  }

  // --- Álbumes Guardados ---

  getSavedAlbums(): Observable<Album[]> {
    return this.http.get<Album[]>(`${this.apiUrl}/saved-albums`);
  }

  toggleSaveAlbum(albumData: Partial<Album>): Observable<ToggleResponse> {
    return this.http.post<ToggleResponse>(`${this.apiUrl}/saved-albums/toggle`, {
      album_titulo: albumData.title,
      album_artista: albumData.artist,
      album_portada: albumData.image,
    });
  }

  // --- Perfil, Estadísticas y Actividad ---

  getUserStats(userId: number): Observable<Record<string, unknown>> {
    return this.http.get<Record<string, unknown>>(`${this.apiUrl}/user/${userId}/stats`);
  }

  getUserActivity(userId: number): Observable<Record<string, unknown>[]> {
    return this.http.get<Record<string, unknown>[]>(`${this.apiUrl}/user/${userId}/activity`);
  }

  getFavoriteAlbums(userId: number): Observable<Album[]> {
    return this.http.get<Album[]>(`${this.apiUrl}/user/${userId}/favorites`);
  }

  toggleFavoriteAlbum(albumData: Partial<Album>): Observable<ToggleResponse> {
    return this.http.post<ToggleResponse>(`${this.apiUrl}/user/favorites/toggle`, {
      album_titulo: albumData.title,
      album_artista: albumData.artist,
      album_portada: albumData.image,
    });
  }

  getFavoriteArtists(userId: number): Observable<Artist[]> {
    return this.http.get<Artist[]>(`${this.apiUrl}/user/${userId}/favorite-artists`);
  }

  toggleFavoriteArtist(artistData: Partial<Artist>): Observable<ToggleResponse> {
    return this.http.post<ToggleResponse>(`${this.apiUrl}/user/favorite-artists/toggle`, {
      artist_nombre: artistData.name,
      artist_imagen: artistData.image,
    });
  }
}
