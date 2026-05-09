import { Component, Input, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FollowerService } from '../../services/follower.service';
import { FollowButtonComponent } from '../follow-button/follow-button';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-follow-list-modal',
  standalone: true,
  imports: [CommonModule, FollowButtonComponent, RouterLink],
  template: `
    <div class="modal fade" [id]="modalId" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content mt-card text-white">
          <div class="modal-header border-bottom border-secondary">
            <h5 class="modal-title fw-bold">{{ type === 'followers' ? 'Seguidores' : 'Siguiendo' }}</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body p-0">
            <!-- Skeleton Loader -->
            <div *ngIf="isLoading" class="p-3">
              <div *ngFor="let i of [1,2,3,4,5]" class="d-flex align-items-center mb-3">
                <div class="skeleton-pulse rounded-circle me-3" style="width: 50px; height: 50px;"></div>
                <div class="skeleton-pulse rounded" style="width: 150px; height: 16px;"></div>
                <div class="skeleton-pulse rounded ms-auto" style="width: 90px; height: 35px; border-radius: 50px;"></div>
              </div>
            </div>

            <!-- Empty State -->
            <div *ngIf="!isLoading && users.length === 0" class="text-center p-5 text-secondary">
              No hay usuarios para mostrar.
            </div>

            <!-- Lista de Usuarios -->
            <div class="list-group list-group-flush rounded-0" *ngIf="!isLoading && users.length > 0">
              <div *ngFor="let user of users" class="list-group-item bg-transparent border-bottom border-secondary p-3 d-flex align-items-center">
                <a [routerLink]="['/user', user.username]" class="d-flex align-items-center text-decoration-none flex-grow-1" data-bs-dismiss="modal">
                  <img [src]="user.foto_perfil" class="rounded-circle me-3 object-fit-cover shadow-sm" width="50" height="50" alt="Avatar">
                  <div>
                    <h6 class="mb-0 text-white fw-bold">{{ user.nombre || user.username }}</h6>
                    <small class="text-secondary">&#64;{{ user.username }}</small>
                  </div>
                </a>
                <div class="ms-3">
                  <app-follow-button [userId]="user.id"></app-follow-button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .modal-content { background-color: #222436; }
    .border-secondary { border-color: #3b3f58 !important; }
    .list-group-item:hover { background-color: rgba(255,255,255,0.02) !important; }
  `]
})
export class FollowListModalComponent implements OnInit {
  @Input() userId!: number;
  @Input() type: 'followers' | 'following' = 'followers';
  
  private followerService = inject(FollowerService);
  
  modalId = 'followModal';
  users: any[] = [];
  isLoading = true;

  ngOnInit() {
    this.modalId = `followModal_${this.type}_${this.userId}`;
  }

  // Se debe llamar cuando se abre el modal
  loadUsers() {
    this.isLoading = true;
    const request = this.type === 'followers' 
      ? this.followerService.getFollowers(this.userId)
      : this.followerService.getFollowing(this.userId);

    request.subscribe({
      next: (data) => {
        this.users = data;
        this.isLoading = false;
      },
      error: () => {
        this.isLoading = false;
      }
    });
  }
}
