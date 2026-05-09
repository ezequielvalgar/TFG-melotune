import { Component, inject, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink, Router } from '@angular/router';
import { FriendsService } from '../../services/friends.service';
import { AuthService } from '../../services/auth.service';
import { ReviewService } from '../../services/review.service';

@Component({
    selector: 'app-friends-page',
    standalone: true,
    imports: [CommonModule, RouterLink],
    templateUrl: './friends-page.html',
    styleUrl: './friends-page.css'
})
export class FriendsPageComponent implements OnInit {
    private friendsService = inject(FriendsService);
    private reviewService = inject(ReviewService);
    private authService = inject(AuthService);
    private router = inject(Router);
    private cdr = inject(ChangeDetectorRef);

    activeTab: 'reviews' | 'saved' | 'favorites' = 'reviews';

    reviews: any[] = [];
    savedAlbums: any[] = [];
    favoriteAlbums: any[] = [];

    isLoadingReviews = true;
    isLoadingSaved = true;
    isLoadingFavorites = true;

    isEmpty = false;

    ngOnInit() {
        window.scrollTo({ top: 0, behavior: 'smooth' });

        // Redirigir si no está logueado
        if (!this.authService.isLoggedIn()) {
            this.router.navigate(['/login']);
            return;
        }

        this.loadAll();
    }

    loadAll() {
        this.friendsService.getFriendsReviews().subscribe({
            next: (res) => {
                this.reviews = res.data ?? [];
                this.isEmpty = res.empty ?? false;
                this.isLoadingReviews = false;
                this.cdr.detectChanges();
            }
        });

        this.friendsService.getFriendsSavedAlbums().subscribe({
            next: (res) => {
                this.savedAlbums = res.data ?? [];
                this.isLoadingSaved = false;
                this.cdr.detectChanges();
            }
        });

        this.friendsService.getFriendsFavoriteAlbums().subscribe({
            next: (res) => {
                this.favoriteAlbums = res.data ?? [];
                this.isLoadingFavorites = false;
                this.cdr.detectChanges();
            }
        });
    }

    setTab(tab: 'reviews' | 'saved' | 'favorites') {
        this.activeTab = tab;
    }

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

    onToggleLike(review: any) {
        if (!this.authService.isLoggedIn()) {
            this.router.navigate(['/login']);
            return;
        }
        const wasLiked = review.likedByUser;
        review.likedByUser = !wasLiked;
        review.likes = (review.likes || 0) + (wasLiked ? -1 : 1);

        this.reviewService.toggleLike(review.id).subscribe({
            next: (res: any) => {
                review.likedByUser = res.liked;
                review.likes = res.likes;
                this.cdr.detectChanges();
            },
            error: () => {
                review.likedByUser = wasLiked;
                review.likes = (review.likes || 0) + (wasLiked ? 1 : -1);
                this.cdr.detectChanges();
            }
        });
    }
}
