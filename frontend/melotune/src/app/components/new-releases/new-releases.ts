import { Component, inject, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { MusicService } from '../../services/music.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-new-releases',
  imports: [CommonModule, RouterLink],
  templateUrl: './new-releases.html',
  styleUrl: './new-releases.css',
  standalone: true
})
export class NewReleasesComponent implements OnInit, OnDestroy {
  private musicService = inject(MusicService);
  private cdr = inject(ChangeDetectorRef);
  private subscription: Subscription | null = null;

  albums: any[] = [];
  isLoading = true;

  ngOnInit() {
    this.subscription = this.musicService.getNewReleases().subscribe({
      next: (data: any) => {
        this.albums = Array.isArray(data) ? data : (data.albums ?? []);
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.isLoading = false;
        this.cdr.detectChanges();
      }
    });
  }

  ngOnDestroy() {
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
  }
}
