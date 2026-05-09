import { Component, inject, OnInit, ChangeDetectorRef, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ReviewService } from '../../services/review.service';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-reviews-page',
  imports: [CommonModule, RouterModule],
  templateUrl: './reviews-page.html',
  styleUrl: './reviews-page.css',
  standalone: true
})
export class ReviewsPageComponent implements OnInit {
  private reviewService = inject(ReviewService);
  private authService = inject(AuthService);
  private cdr = inject(ChangeDetectorRef);
  private zone = inject(NgZone);
  
  reviews: any[] = [];
  isLoading = true;
  isLoadingMore = false;
  currentPage = 1;
  lastPage = 1;

  // Lógica Estado
  showFilters = false;
  sortBy = 'Recientes';
  viewMode: 'list' | 'large' = 'list';
  minScoreFilter = 'Todas';
  selectedTags: string[] = [];

  availableFilterTags = [
    'Obra maestra', 'Produccion impecable', 'Para auriculares', 'Letras profundas', 
    'Emotivo', 'Experimental', 'Album conceptual', 'Bailable', 'Nostalgico', 
    'Singles potentes', 'Para la noche'
  ];


  ngOnInit() {
    this.loadReviews();
  }

  loadReviews(page = 1) {
    if (page === 1) {
      this.isLoading = true;
    } else {
      this.isLoadingMore = true;
    }

    this.reviewService.getReviews(page).subscribe({
      next: (resp) => {
        this.zone.run(() => {
          this.currentPage = resp.current_page ?? 1;
          this.lastPage = resp.last_page ?? 1;

          const rawData = resp.data ?? resp;
          const processedData = rawData.map((r: any) => {
            // Protección contra strings doble-parseados o objetos nulos
            if (!Array.isArray(r.tags)) {
              if (typeof r.tags === 'string') {
                try { r.tags = JSON.parse(r.tags); } catch { r.tags = []; }
              } else {
                r.tags = [];
              }
            }
            if (!Array.isArray(r.tags)) r.tags = [];
            return r;
          });

          if (page === 1) {
             this.reviews = processedData;
          } else {
             this.reviews = [...this.reviews, ...processedData];
          }

          this.isLoading = false;
          this.isLoadingMore = false;
          this.cdr.detectChanges();
        });
      },
      error: () => {
        this.zone.run(() => {
          this.isLoading = false;
          this.isLoadingMore = false;
          this.cdr.detectChanges();
        });
      }
    });
  }

  loadMore() {
    if (this.currentPage < this.lastPage) {
      this.loadReviews(this.currentPage + 1);
    }
  }

  // Lógica de Filtros y Ordenación
  get filteredReviews() {
    let result = [...this.reviews];

    // Aplicar Filtro Estrellas
    if (this.minScoreFilter !== 'Todas') {
      const minStars = parseInt(this.minScoreFilter.charAt(0));
      result = result.filter(r => r.rating >= minStars);
    }

    // Aplicar Filtro Etiquetas (debe contener AL MENOS una de las selecionadas, o todas? Evaluaremos todas las seleccionadas "AND")
    if (this.selectedTags.length > 0) {
      result = result.filter(r => {
        return this.selectedTags.every(tag => r.tags.includes(tag));
      });
    }

    // Aplicar Ordenación
    if (this.sortBy === 'Mejor valoradas') {
      // Ordenar por rating descentente, y en caso de empate por likes
      result.sort((a, b) => b.rating !== a.rating ? b.rating - a.rating : b.likes - a.likes);
    } else if (this.sortBy === 'Populares') {
      // Ordenar por mayor número de Likes
      result.sort((a, b) => b.likes - a.likes);
    }
    // Si es "Recientes", el array ya viene ordenado cronológicamente por defecto desde el Backend / Datos Mocks.

    return result;
  }

  toggleTagFilter(tag: string) {
    const idx = this.selectedTags.indexOf(tag);
    if (idx > -1) this.selectedTags.splice(idx, 1);
    else this.selectedTags.push(tag);
  }

  setMinScore(score: string) {
    this.minScoreFilter = score;
  }

  setSort(sort: string) {
    this.sortBy = sort;
  }

  setViewMode(mode: 'list' | 'large') {
    this.viewMode = mode;
  }


  toggleLikeDirect(review: any, event: Event) {
    event.preventDefault();
    const user = this.authService.currentUserValue;
    if (!user) return; // Redirigir a login si no está autenticado

    // Optimista: actualizar UI inmediatamente
    if (review.likedByUser) {
      review.likes--;
      review.likedByUser = false;
    } else {
      review.likes++;
      review.likedByUser = true;
    }

    // Llamada real al API
    this.reviewService.toggleLike(review.id).subscribe({
      next: (res) => {
        this.zone.run(() => {
          review.likes = res.likes;
          review.likedByUser = res.liked;
          this.cdr.detectChanges();
        });
      },
      error: () => {
        // Revertir en caso de error
        this.zone.run(() => {
          review.likedByUser = !review.likedByUser;
          review.likes += review.likedByUser ? 1 : -1;
          this.cdr.detectChanges();
        });
      }
    });
  }

  // --- LÓGICA DE ESTRELLAS MEJORADA ---

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
}
