import { Component, inject, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { ReviewService } from '../../../services/review.service';
import { AuthService } from '../../../services/auth.service';

@Component({
  selector: 'app-latest-reviews',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './latest-reviews.html',
  styleUrl: './latest-reviews.css'
})
export class LatestReviewsComponent implements OnInit {
  private reviewService = inject(ReviewService);
  private authService = inject(AuthService);
  private router = inject(Router);
  private cdr = inject(ChangeDetectorRef);
  
  latestReviews: any[] = [];
  isLoading = true;

  ngOnInit() {
    this.reviewService.getReviews().subscribe({
      next: (res: any) => {
        this.latestReviews = (res.data || []).slice(0, 5);
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.isLoading = false;
        this.cdr.detectChanges();
      }
    });
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
    review.likes += wasLiked ? -1 : 1;

    this.reviewService.toggleLike(review.id).subscribe({
      next: (res: any) => {
        review.likedByUser = res.liked;
        review.likes = res.likes;
        this.cdr.detectChanges();
      },
      error: () => {
        review.likedByUser = wasLiked;
        review.likes += wasLiked ? 1 : -1;
        this.cdr.detectChanges();
      }
    });
  }
}
