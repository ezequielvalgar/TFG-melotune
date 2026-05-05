import { Component, inject, OnInit, OnDestroy, ChangeDetectorRef, NgZone, ViewChild, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink, ActivatedRoute } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../services/auth.service';
import { MusicService } from '../../services/music.service';
import { ReviewService } from '../../services/review.service';
import { FollowerService } from '../../services/follower.service';
import { FollowButtonComponent } from '../follow-button/follow-button';
import { of, Subscription } from 'rxjs';
import { catchError, take } from 'rxjs/operators';

@Component({
  selector: 'app-profile-page',
  standalone: true,
  imports: [CommonModule, RouterLink, FormsModule, FollowButtonComponent],
  templateUrl: './profile-page.html',
  styleUrl: './profile-page.css'
})
export class ProfilePageComponent implements OnInit, OnDestroy {
  protected authService = inject(AuthService);
  private musicService = inject(MusicService);
  private reviewService = inject(ReviewService);
  private followerService = inject(FollowerService);
  private cdr = inject(ChangeDetectorRef);
  private zone = inject(NgZone);
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  private http = inject(HttpClient);
  private apiUrl = 'http://127.0.0.1:8000/api';

  private paramsSub?: Subscription;
  private authSub?: Subscription;
  private fragmentSub?: Subscription;

  profileUserId: number | null = null;
  isOwnProfile = false;

  showFollowModal = false;
  followModalType: 'followers' | 'following' = 'followers';
  followModalUsers: any[] = [];
  isLoadingModal = false;

  currentUser$ = this.authService.currentUser$;

  activeTab: 'resenas' | 'favoritos' | 'actividad' | 'estadisticas' = 'resenas';
  viewMode: 'list' | 'large' = 'list';

  user: any = null;

  isEditingProfile = false;
  isSavingProfile = false;
  editNombre = '';
  editBio = '';
  selectedAvatarFile: File | null = null;
  avatarPreviewUrl: string | null = null;

  @ViewChild('fileInput') fileInput!: ElementRef;

  ngOnInit(): void {
    this.paramsSub = this.route.params.subscribe(params => {
      window.scrollTo({ top: 0, behavior: 'smooth' });

      if (this.authSub) {
        this.authSub.unsubscribe();
      }

      const idFromUrl = params['id'] ? +params['id'] : null;
      const loggedUserId = this.authService.currentUserValue?.id ?? null;

      if (idFromUrl && idFromUrl !== loggedUserId) {
        this.profileUserId = idFromUrl;
        this.isOwnProfile = false;
        this.loadUserProfile(idFromUrl);
      } else {
        this.profileUserId = loggedUserId;
        this.isOwnProfile = true;
        this.loadOwnProfile();
      }
    });

    this.fragmentSub = this.route.fragment.subscribe(fragment => {
      if (fragment === 'favoritos') {
        this.activeTab = 'favoritos';
        setTimeout(() => {
          const el = document.getElementById('favoritos');
          if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }, 300);
      }
    });
  }

  ngOnDestroy(): void {
    if (this.paramsSub) this.paramsSub.unsubscribe();
    if (this.authSub) this.authSub.unsubscribe();
    if (this.fragmentSub) this.fragmentSub.unsubscribe();
  }

  loadUserProfile(userId: number): void {
    this.http.get<any>(`${this.apiUrl}/users/${userId}`).pipe(take(1)).subscribe({
      next: (user) => {
        this.zone.run(() => {
          this.user = user;
          this.stats.seguidores = user.followers_count ?? 0;
          this.stats.siguiendo = user.following_count ?? 0;
          this.loadUserReviews(userId);
          this.loadRealUserData(userId);
          // Saved albums are private (own auth required), hide them for other profiles
          this.savedAlbums = [];
        });
      },
      error: () => {
        this.zone.run(() => {
          this.router.navigate(['/profile']);
        });
      }
    });
  }

  loadOwnProfile(): void {
    this.authSub = this.authService.currentUser$.subscribe((user: any) => {
      if (user) {
        this.zone.run(() => {
          if (this.isOwnProfile) {
            this.user = user;
            this.followerService.getStats(user.id).pipe(take(1)).subscribe(stats => {
              this.zone.run(() => {
                this.stats.seguidores = stats.followers_count;
                this.stats.siguiendo = stats.following_count;
                this.cdr.detectChanges();
              });
            });
            this.loadUserReviews(user.id);
            this.loadRealUserData(user.id);
            this.loadSavedAlbums();
          }
        });
      }
    });
  }

  loadSavedAlbums(): void {
    this.reviewService.getSavedAlbums().pipe(take(1)).subscribe({
      next: (res: any[]) => {
        this.zone.run(() => {
          this.savedAlbums = res.map((s: any) => ({
            id: s.id,
            title: s.album_titulo,
            artist: s.album_artista,
            image: s.album_portada || 'https://placehold.co/300/1a1c2e/60658a?text=No+Cover'
          }));
          this.cdr.detectChanges();
        });
      },
      error: () => { }
    });
  }

  loadUserReviews(userId: number): void {
    this.reviewService.getReviewsByUser(userId).pipe(take(1)).subscribe({
      next: (reviews: any[]) => {
        this.zone.run(() => {
          if (reviews.length > 0) {
            this.userReviews = reviews.map((r: any) => {
              if (!Array.isArray(r.tags)) {
                if (typeof r.tags === 'string') {
                  try { r.tags = JSON.parse(r.tags); } catch { r.tags = []; }
                } else {
                  r.tags = [];
                }
              }
              return r;
            });
            this.stats.resenas = reviews.length;
            this.updateRatingDistribution(this.userReviews);
          }
          this.cdr.detectChanges();
        });
      },
      error: () => { }
    });
  }

  loadRealUserData(userId: number) {
    this.reviewService.getUserStats(userId).pipe(take(1)).subscribe({
      next: (stats: any) => {
        this.zone.run(() => {
          this.stats.resenas = stats.total_reviews;
          this.globalStats = [
            { icon: 'fa-solid fa-record-vinyl', value: stats.unique_albums.toString(), label: 'Albums escuchados' },
            { icon: 'fa-solid fa-users', value: stats.unique_artists.toString(), label: 'Artistas' },
            { icon: 'fa-regular fa-clock', value: stats.hours_listened.toString(), label: 'Horas escuchadas' },
            { icon: 'fa-solid fa-star-half-stroke', value: stats.average_rating.toString(), label: 'Puntuación media' },
            { icon: 'fa-solid fa-music', value: stats.favorite_genre, label: 'Género favorito' },
            { icon: 'fa-regular fa-comment', value: stats.total_reviews.toString(), label: 'Total reseñas' }
          ];
          this.cdr.detectChanges();
        });
      }
    });

    this.reviewService.getUserActivity(userId).pipe(take(1)).subscribe({
      next: (activity: any) => {
        this.zone.run(() => {
          this.activityFeed = activity.map((a: any) => {
            const d = new Date(a.date || a.created_at);
            return {
              ...a,
              albumTitle: a.title,
              date: d.toLocaleString('es-ES', { day: 'numeric', month: 'short' })
            };
          });
          this.recentlyPlayed = this.activityFeed
            .filter((a: any) => a.type === 'Reseña')
            .map((a: any) => ({ title: a.title, artist: a.artist, image: a.image }))
            .slice(0, 5);
          this.cdr.detectChanges();
        });
      }
    });

    this.reviewService.getFavoriteAlbums(userId).pipe(take(1)).subscribe({
      next: (favs: any) => {
        this.zone.run(() => {
          this.favoriteAlbums = favs.map((f: any) => ({
            id: f.id,
            title: f.album_titulo,
            artist: f.album_artista,
            image: f.album_portada || 'https://placehold.co/300/1a1c2e/60658a?text=No+Cover'
          }));
          this.cdr.detectChanges();
          this.loadReviewAlbumsImages();
        });
      }
    });
  }

  loadReviewAlbumsImages(): void {
    this.musicService.getReviewAlbums().pipe(take(1)).subscribe({
      next: (albums) => {
        const imageMap: { [key: string]: string } = {};
        albums.forEach((a: any) => {
          if (a?.artist && a?.title && a?.image) {
            imageMap[`${a.artist}|${a.title}`] = a.image;
          }
        });
        this.musicService.getAlbumDetails('The Neighbourhood', 'I Love You.').pipe(
          take(1),
          catchError(() => of(null))
        ).subscribe(res => {
          this.zone.run(() => {
            if (res?.image) imageMap['The Neighbourhood|I Love You.'] = res.image;
            const applyImages = (list: any[]) =>
              list.map(item => ({ ...item, image: imageMap[`${item.artist}|${item.title}`] || item.image }));
            this.favoriteAlbums = applyImages(this.favoriteAlbums);
            this.recentlyPlayed = applyImages(this.recentlyPlayed);
            this.cdr.detectChanges();
          });
        });
      },
      error: () => { }
    });
  }

  updateRatingDistribution(reviews: any[]) {
    const counts: { [k: number]: number } = { 5: 0, 4: 0, 3: 0, 2: 0, 1: 0 };
    reviews.forEach(r => {
      const stars = Math.round(r.rating);
      if (counts[stars] !== undefined) counts[stars]++;
    });
    const total = reviews.length || 1;
    this.ratingDistribution = [5, 4, 3, 2, 1].map((s: any) => ({
      stars: s,
      count: counts[s],
      percent: Math.round((counts[s] / total) * 100)
    }));
  }

  setTab(tab: 'resenas' | 'favoritos' | 'actividad' | 'estadisticas') {
    this.activeTab = tab;
  }

  stats = { resenas: 0, seguidores: 0, siguiendo: 0 };
  userReviews: any[] = [];
  favoriteAlbums: any[] = [];
  savedAlbums: any[] = [];
  recentlyPlayed: any[] = [];
  activityFeed: any[] = [];
  globalStats: any[] = [];
  ratingDistribution = [
    { stars: 5, count: 0, percent: 0 },
    { stars: 4, count: 0, percent: 0 },
    { stars: 3, count: 0, percent: 0 },
    { stars: 2, count: 0, percent: 0 },
    { stars: 1, count: 0, percent: 0 }
  ];

  topGenres = ['Alternative', 'Indie', 'Hip-Hop', 'Electronic', 'R&B', 'Rock', 'Pop'];

  get avatarUrl(): string {
    if (this.isOwnProfile) {
      const live = this.authService.currentUserValue;
      return live?.foto_perfil || this.user?.foto_perfil || '';
    }
    return this.user?.foto_perfil || '';
  }

  get formattedRegistrationDate(): string {
    if (!this.user?.fecha_registro) return 'Hoy';
    const d = new Date(this.user.fecha_registro);
    if (isNaN(d.getTime())) return this.user.fecha_registro;
    const str = d.toLocaleString('es-ES', { month: 'long', year: 'numeric' });
    return str.charAt(0).toUpperCase() + str.slice(1);
  }

  toggleEditProfile() {
    this.isEditingProfile = !this.isEditingProfile;
    if (this.isEditingProfile) {
      this.editNombre = this.user?.nombre || '';
      this.editBio = this.user?.bio || '';
      this.selectedAvatarFile = null;
      this.avatarPreviewUrl = null;
    }
  }

  cancelEdit() {
    this.isEditingProfile = false;
  }

  triggerFileInput() {
    if (this.fileInput) this.fileInput.nativeElement.click();
  }

  onFileSelected(event: any) {
    const file: File = event.target.files[0];
    if (file) {
      if (file.size > 2 * 1024 * 1024) {
        alert('La imagen no puede pesar más de 2MB');
        return;
      }
      this.selectedAvatarFile = file;
      const reader = new FileReader();
      reader.onload = (e: any) => {
        this.zone.run(() => {
          this.avatarPreviewUrl = e.target.result;
          this.cdr.detectChanges();
        });
      };
      reader.readAsDataURL(file);
    }
  }

  saveProfile() {
    if (!this.editNombre.trim()) return;
    this.isSavingProfile = true;
    const formData = new FormData();
    formData.append('nombre', this.editNombre);
    formData.append('bio', this.editBio);
    if (this.selectedAvatarFile) formData.append('foto_perfil', this.selectedAvatarFile);

    this.authService.updateProfile(formData).pipe(take(1)).subscribe({
      next: () => {
        this.zone.run(() => {
          const freshUser = this.authService.currentUserValue;
          if (freshUser) {
            this.user = { ...freshUser };
          }
          this.selectedAvatarFile = null;
          this.avatarPreviewUrl = null;
          this.isSavingProfile = false;
          this.isEditingProfile = false;
          this.cdr.detectChanges();
        });
      },
      error: () => {
        this.zone.run(() => {
          this.isSavingProfile = false;
          alert('Error al actualizar perfil. Intenta de nuevo.');
          this.cdr.detectChanges();
        });
      }
    });
  }

  onAvatarError(event: any) {
    const username = this.user?.username || 'U';
    event.target.src = `https://ui-avatars.com/api/?name=${encodeURIComponent(username)}&background=1a1c2e&color=E83E8C&size=200&bold=true`;
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

    this.reviewService.toggleLike(review.id).pipe(take(1)).subscribe({
      next: (res) => {
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

  openFollowModal(type: 'followers' | 'following'): void {
    this.followModalType = type;
    this.showFollowModal = true;
    this.isLoadingModal = true;
    this.followModalUsers = [];

    const userId = this.profileUserId;
    if (!userId) return;

    const call$ = type === 'followers'
      ? this.followerService.getFollowers(userId)
      : this.followerService.getFollowing(userId);

    call$.pipe(take(1)).subscribe({
      next: (users: any[]) => {
        this.followModalUsers = users ?? [];
        this.isLoadingModal = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.followModalUsers = [];
        this.isLoadingModal = false;
        this.cdr.detectChanges();
      }
    });
  }

  closeFollowModal(): void {
    this.showFollowModal = false;
    this.followModalUsers = [];
  }

  onFollowChanged(isNowFollowing: boolean): void {
    this.stats.seguidores += isNowFollowing ? 1 : -1;
    this.cdr.detectChanges();
  }
}
