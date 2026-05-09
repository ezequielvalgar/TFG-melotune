import { Component, Input, OnInit, ViewChild, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FollowerService } from '../../services/follower.service';
import { FollowListModalComponent } from '../follow-list-modal/follow-list-modal';

@Component({
  selector: 'app-follow-stats',
  standalone: true,
  imports: [CommonModule, FollowListModalComponent],
  template: `
    <div class="d-flex align-items-center gap-4 my-3 text-secondary">
      <span class="stat-link" data-bs-toggle="modal" [attr.data-bs-target]="'#followModal_followers_' + userId" (click)="loadModalData('followers')">
        <strong class="text-white fs-5">{{ stats.followers_count }}</strong> Seguidores
      </span>
      <span class="stat-link" data-bs-toggle="modal" [attr.data-bs-target]="'#followModal_following_' + userId" (click)="loadModalData('following')">
        <strong class="text-white fs-5">{{ stats.following_count }}</strong> Siguiendo
      </span>
    </div>

    <!-- Modales -->
    <app-follow-list-modal #followersModal [userId]="userId" type="followers"></app-follow-list-modal>
    <app-follow-list-modal #followingModal [userId]="userId" type="following"></app-follow-list-modal>
  `,
  styles: [`
    .stat-link { cursor: pointer; transition: opacity 0.2s; }
    .stat-link:hover { opacity: 0.8; }
  `]
})
export class FollowStatsComponent implements OnInit {
  @Input() userId!: number;
  
  private followerService = inject(FollowerService);
  
  @ViewChild('followersModal') followersModal!: FollowListModalComponent;
  @ViewChild('followingModal') followingModal!: FollowListModalComponent;

  stats = { followers_count: 0, following_count: 0 };

  ngOnInit() {
    if (this.userId) {
      this.loadStats();
    }
  }

  loadStats() {
    this.followerService.getStats(this.userId).subscribe({
      next: (data) => this.stats = data,
      error: () => { }
    });
  }

  loadModalData(type: 'followers' | 'following') {
    if (type === 'followers') {
      this.followersModal.loadUsers();
    } else {
      this.followingModal.loadUsers();
    }
  }
}
