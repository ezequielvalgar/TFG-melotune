import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class ReviewService {
  private http = inject(HttpClient);
  private apiUrl = 'http://127.0.0.1:8000/api';

  /** Obtener todas las reseñas (paginadas) */
  getReviews(page = 1): Observable<any> {
    const cacheBuster = new Date().getTime();
    return this.http.get<any>(`${this.apiUrl}/reviews?page=${page}&_t=${cacheBuster}`);
  }

  /** Reseñas de un usuario específico */
  getReviewsByUser(userId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/reviews/user/${userId}`);
  }

  /** Reseñas de un álbum específico */
  getReviewsByAlbum(artist: string, title: string): Observable<any[]> {
    // Es vital codificar la URI para no romper los slashes si el álbum se llama "A/B"
    return this.http.get<any[]>(`${this.apiUrl}/albums/${encodeURIComponent(artist)}/${encodeURIComponent(title)}/reviews`);
  }

  /** Crear una reseña nueva (requiere token) */
  createReview(data: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/reviews`, data);
  }

  /** Toggle like en una reseña (requiere token) */
  toggleLike(reviewId: number): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/reviews/${reviewId}/like`, {});
  }

  /** Eliminar una reseña propia (requiere token) */
  deleteReview(reviewId: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/reviews/${reviewId}`);
  }

  // --- Álbumes Guardados ---

  getSavedAlbums(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/saved-albums`);
  }

  toggleSaveAlbum(albumData: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/saved-albums/toggle`, {
      album_titulo: albumData.title,
      album_artista: albumData.artist,
      album_portada: albumData.image
    });
  }

  // --- Perfil, Estadísticas y Actividad ---

  getUserStats(userId: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/user/${userId}/stats`);
  }

  getUserActivity(userId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/user/${userId}/activity`);
  }

  getFavoriteAlbums(userId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/user/${userId}/favorites`);
  }

  toggleFavoriteAlbum(albumData: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/user/favorites/toggle`, {
      album_titulo: albumData.title,
      album_artista: albumData.artist,
      album_portada: albumData.image
    });
  }
}
