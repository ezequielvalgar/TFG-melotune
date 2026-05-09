import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { FollowStats, UserProfile } from '../models/music.models';

@Injectable({ providedIn: 'root' })
export class FollowerService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:8000/api';

  follow(userId: number): Observable<unknown> {
    return this.http.post(`${this.apiUrl}/users/${userId}/follow`, {});
  }

  unfollow(userId: number): Observable<unknown> {
    return this.http.delete(`${this.apiUrl}/users/${userId}/unfollow`);
  }

  getFollowers(userId: number): Observable<UserProfile[]> {
    return this.http.get<UserProfile[]>(`${this.apiUrl}/users/${userId}/followers`).pipe(
      catchError(() => of([]))
    );
  }

  getFollowing(userId: number): Observable<UserProfile[]> {
    return this.http.get<UserProfile[]>(`${this.apiUrl}/users/${userId}/following`).pipe(
      catchError(() => of([]))
    );
  }

  getStats(userId: number): Observable<FollowStats> {
    return this.http.get<FollowStats>(`${this.apiUrl}/users/${userId}/follow-stats`);
  }
}
