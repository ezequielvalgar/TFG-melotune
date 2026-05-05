import { Component, Input, OnInit, inject, ChangeDetectorRef, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FollowerService } from '../../services/follower.service';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-follow-button',
  standalone: true,
  imports: [CommonModule],
  template: `
    <button 
      class="btn rounded-pill px-4 fw-bold shadow-sm"
      [ngClass]="{'bg-accent-red text-white': !isFollowing, 'btn-secondary text-white': isFollowing}"
      [disabled]="isLoading"
      (click)="toggleFollow()">
      <span *ngIf="isLoading" class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
      {{ isFollowing ? followingLabel : 'Seguir' }}
    </button>
  `,
  styles: [`
    .btn { transition: all 0.2s ease; }
    .bg-accent-red:hover { opacity: 0.9; }
    .btn-secondary { background-color: #3b3f58; border: none; }
    .btn-secondary:hover { background-color: #4a4f6d; }
  `]
})
export class FollowButtonComponent implements OnInit {
  @Input() userId!: number;
  @Input() followingLabel: string = 'Siguiendo';
  @Input() unfollowLabel: string = 'Dejar de seguir';
  @Output() followChanged = new EventEmitter<boolean>();
  
  private followerService = inject(FollowerService);
  private authService = inject(AuthService);
  private router = inject(Router);
  private cdr = inject(ChangeDetectorRef);

  isFollowing = false;
  isLoading = false;

  ngOnInit() {
    if (this.userId) {
      this.checkStatus();
    }
  }

  checkStatus() {
    this.followerService.getStats(this.userId).subscribe({
      next: (stats) => {
        this.isFollowing = stats.is_following;
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Error al obtener estado de seguimiento', err)
    });
  }

  toggleFollow() {
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return;
    }

    if (this.isLoading || !this.userId) return;
    
    this.isLoading = true;

    if (this.isFollowing) {
      this.followerService.unfollow(this.userId).subscribe({
        next: () => {
          this.isFollowing = false;
          this.isLoading = false;
          this.followChanged.emit(false);
          this.cdr.detectChanges();
        },
        error: (err) => {
          console.error('Error unfollowing', err);
          this.isLoading = false;
          this.cdr.detectChanges();
        }
      });
    } else {
      this.followerService.follow(this.userId).subscribe({
        next: () => {
          this.isFollowing = true;
          this.isLoading = false;
          this.followChanged.emit(true);
          this.cdr.detectChanges();
        },
        error: (err) => {
          console.error('Error following', err);
          this.isLoading = false;
          this.cdr.detectChanges();
        }
      });
    }
  }
}
