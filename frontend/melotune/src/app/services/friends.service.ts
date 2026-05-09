import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError, of } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class FriendsService {
    private http = inject(HttpClient);
    private apiUrl = 'http://localhost:8000/api';

    getFriendsReviews() {
        return this.http.get<any>(`${this.apiUrl}/friends/reviews`)
            .pipe(catchError(() => of({ data: [] })));
    }

    getFriendsSavedAlbums() {
        return this.http.get<any>(`${this.apiUrl}/friends/saved-albums`)
            .pipe(catchError(() => of({ data: [] })));
    }

    getFriendsFavoriteAlbums() {
        return this.http.get<any>(`${this.apiUrl}/friends/favorite-albums`)
            .pipe(catchError(() => of({ data: [] })));
    }
}
