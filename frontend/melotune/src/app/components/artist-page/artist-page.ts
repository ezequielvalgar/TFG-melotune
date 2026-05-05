import { Component, inject, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink, ActivatedRoute, Router } from '@angular/router';
import { MusicService } from '../../services/music.service';
import { ReviewService } from '../../services/review.service';
import { AuthService } from '../../services/auth.service';

@Component({
    selector: 'app-artist-page',
    standalone: true,
    imports: [CommonModule, RouterLink],
    templateUrl: './artist-page.html',
    styleUrl: './artist-page.css'
})
export class ArtistPageComponent implements OnInit {
    private route = inject(ActivatedRoute);
    private router = inject(Router);
    private musicService = inject(MusicService);
    private reviewService = inject(ReviewService);
    private authService = inject(AuthService);
    private cdr = inject(ChangeDetectorRef);

    artist: any = null;
    isLoading = true;
    artistName = '';
    isFavoriteArtist = false;
    isTogglingFavoriteArtist = false;

    ngOnInit() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
        this.route.params.subscribe(params => {
            this.artistName = decodeURIComponent(params['name'] ?? '');
            if (!this.artistName) {
                this.router.navigate(['/']);
                return;
            }
            this.loadArtist();
        });
    }

    loadArtist() {
        this.isLoading = true;
        this.musicService.getArtistInfo(this.artistName).subscribe({
            next: (data) => {
                this.artist = data;
                this.isLoading = false;
                this.cdr.detectChanges();
            },
            error: () => {
                this.isLoading = false;
                this.cdr.detectChanges();
                this.router.navigate(['/']);
            }
        });
    }

    formatListeners(val: number): string {
        if (val >= 1000000) return (val / 1000000).toFixed(1) + 'M';
        if (val >= 1000) return (val / 1000).toFixed(1) + 'K';
        return val.toString();
    }

    toggleFavoriteArtist() {
        if (!this.authService.isLoggedIn()) {
            this.router.navigate(['/login']);
            return;
        }
        this.isTogglingFavoriteArtist = true;
        this.reviewService.toggleFavoriteAlbum({
            title: this.artist.name,
            artist: this.artist.name,
            image: this.artist.image
        }).subscribe({
            next: (res: any) => {
                this.isFavoriteArtist = res.status === 'added';
                this.isTogglingFavoriteArtist = false;
                this.cdr.detectChanges();
            },
            error: () => {
                this.isTogglingFavoriteArtist = false;
                this.cdr.detectChanges();
            }
        });
    }
}