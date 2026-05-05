import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { of } from 'rxjs';
import { catchError } from 'rxjs/operators';


@Injectable({
  providedIn: 'root'
})
export class FollowerService {
  private http = inject(HttpClient);
  private apiUrl = 'http://127.0.0.1:8000/api';

  follow(userId: number) {
    return this.http.post(`${this.apiUrl}/users/${userId}/follow`, {});
  }

  unfollow(userId: number) {
    return this.http.delete(`${this.apiUrl}/users/${userId}/unfollow`);
  }

  getFollowers(userId: number) {
    return this.http.get<any[]>(`${this.apiUrl}/users/${userId}/followers`).pipe(
      catchError(() => of([]))
    );
  }

  getFollowing(userId: number) {
    return this.http.get<any[]>(`${this.apiUrl}/users/${userId}/following`).pipe(
      catchError(() => of([]))
    );
  }

  getStats(userId: number) {
    return this.http.get<any>(`${this.apiUrl}/users/${userId}/follow-stats`);
  }
}
