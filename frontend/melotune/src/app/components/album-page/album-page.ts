import { Component, inject, OnInit, ChangeDetectorRef, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { MusicService } from '../../services/music.service';
import { ReviewService } from '../../services/review.service';
import { AuthService } from '../../services/auth.service';
import { forkJoin } from 'rxjs';

@Component({
  selector: 'app-album-page',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './album-page.html',
  styleUrl: './album-page.css'
})
export class AlbumPageComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private musicService = inject(MusicService);
  private reviewService = inject(ReviewService);
  private authService = inject(AuthService);
  private cdr = inject(ChangeDetectorRef);
  private zone = inject(NgZone);

  artistName: string = '';
  albumTitle: string = '';
  isLoading = true;
  loadingError = false;
  albumInfo: any = null;
  reviews: any[] = [];
  distribution = [
    { stars: 5, count: 0, percent: 0 },
    { stars: 4, count: 0, percent: 0 },
    { stars: 3, count: 0, percent: 0 },
    { stars: 2, count: 0, percent: 0 },
    { stars: 1, count: 0, percent: 0 }
  ];
  totalReviews = 0;
  averageRating = 0;

  isFavorite = false;
  isSaved = false;
  isTogglingFavorite = false;
  isTogglingSaved = false;

  ngOnInit() {
    this.route.paramMap.subscribe(params => {
      this.artistName = params.get('artist') || '';
      this.albumTitle = params.get('title') || '';
      if (this.artistName && this.albumTitle) {
        this.loadAlbumData();
      } else {
        this.loadingError = true;
        this.isLoading = false;
      }
    });
  }

  loadAlbumData() {
    this.isLoading = true;
    forkJoin({
      info: this.musicService.getAlbumDetails(this.artistName, this.albumTitle),
      reviews: this.reviewService.getReviewsByAlbum(this.artistName, this.albumTitle)
    }).subscribe({
      next: (res: any) => {
        this.zone.run(() => {
          this.albumInfo = res.info;
          this.reviews = res.reviews.map((r: any) => {
            if (typeof r.tags === 'string') {
              try { r.tags = JSON.parse(r.tags); } catch { r.tags = []; }
            }
            return r;
          });
          this.calculateDistribution();
          this.isLoading = false;
          if (this.authService.isLoggedIn()) {
            this.loadAlbumActions();
          }
          this.cdr.detectChanges();
        });
      },
      error: () => {
        this.zone.run(() => {
          this.loadingError = true;
          this.isLoading = false;
          this.cdr.detectChanges();
        });
      }
    });
  }

  loadAlbumActions() {
    this.reviewService.getFavoriteAlbums(this.authService.currentUserValue.id).subscribe({
      next: (favs: any[]) => {
        this.zone.run(() => {
          this.isFavorite = favs.some(f =>
            f.album_titulo === this.albumInfo.title &&
            f.album_artista === this.albumInfo.artist
          );
          this.cdr.detectChanges();
        });
      }
    });

    this.reviewService.getSavedAlbums().subscribe({
      next: (saved: any[]) => {
        this.zone.run(() => {
          this.isSaved = saved.some(s =>
            s.album_titulo === this.albumInfo.title &&
            s.album_artista === this.albumInfo.artist
          );
          this.cdr.detectChanges();
        });
      }
    });
  }

  toggleFavorite() {
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return;
    }
    this.isTogglingFavorite = true;
    this.reviewService.toggleFavoriteAlbum({
      title: this.albumInfo.title,
      artist: this.albumInfo.artist,
      image: this.albumInfo.image
    }).subscribe({
      next: (res: any) => {
        this.zone.run(() => {
          this.isFavorite = res.status === 'added';
          this.isTogglingFavorite = false;
          this.cdr.detectChanges();
        });
      },
      error: () => {
        this.zone.run(() => {
          this.isTogglingFavorite = false;
          this.cdr.detectChanges();
        });
      }
    });
  }

  toggleSave() {
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return;
    }
    this.isTogglingSaved = true;
    this.reviewService.toggleSaveAlbum({
      title: this.albumInfo.title,
      artist: this.albumInfo.artist,
      image: this.albumInfo.image
    }).subscribe({
      next: (res: any) => {
        this.zone.run(() => {
          this.isSaved = res.saved === true;
          this.isTogglingSaved = false;
          this.cdr.detectChanges();
        });
      },
      error: () => {
        this.zone.run(() => {
          this.isTogglingSaved = false;
          this.cdr.detectChanges();
        });
      }
    });
  }

  calculateDistribution() {
    this.totalReviews = this.reviews.length;
    let counts: { [k: number]: number } = { 5: 0, 4: 0, 3: 0, 2: 0, 1: 0 };
    let sum = 0;
    this.reviews.forEach((r: any) => {
      const s = Math.round(r.rating);
      if (counts[s] !== undefined) counts[s]++;
      sum += r.rating;
    });
    if (this.totalReviews > 0) {
      this.averageRating = Math.round((sum / this.totalReviews) * 10) / 10;
      this.distribution = [5, 4, 3, 2, 1].map((star: number) => ({
        stars: star,
        count: counts[star],
        percent: Math.round((counts[star] / this.totalReviews) * 100)
      }));
    }
  }

  goToCreateReview() {
    this.router.navigate(['/create-review'], {
      state: {
        album: {
          name: this.albumInfo.title || this.albumTitle,
          artist: this.albumInfo.artist || this.artistName,
          image: this.albumInfo.image || ''
        }
      }
    });
  }

  formatDuration(sec: number): string {
    if (!sec) return '';
    const m = Math.floor(sec / 60);
    const s = sec % 60;
    return `${m}:${s < 10 ? '0' : ''}${s}`;
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
