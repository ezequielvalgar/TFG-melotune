import { Component, inject, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { MusicService } from '../../services/music.service';
import { ReviewService } from '../../services/review.service';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-create-review',
  imports: [CommonModule, FormsModule],
  templateUrl: './create-review.html',
  styleUrl: './create-review.css',
  standalone: true
})
export class CreateReviewComponent implements OnInit {
  private router = inject(Router);
  private musicService = inject(MusicService);
  private reviewService = inject(ReviewService);
  private authService = inject(AuthService);
  private cdr = inject(ChangeDetectorRef);

  isSaving = false;
  saveSuccess = false;
  saveError = '';

  album: any = null;

  title: string = '';
  text: string = '';

  availableTags = [
    // Calidad y producción
    'Obra maestra', 'Producción impecable', 'Producción minimalista',
    'Muy producido', 'Lo-fi', 'Experimental',
    // Emoción y estado de ánimo
    'Emotivo', 'Eufórico', 'Melancólico', 'Nostálgico', 'Oscuro',
    'Relajante', 'Enérgico', 'Romántico', 'Angustioso',
    // Escucha
    'Para auriculares', 'Para la noche', 'Para el coche',
    'Para estudiar', 'Para entrenar', 'Bailable', 'Para llorar',
    // Estructura y formato
    'Álbum conceptual', 'Singles potentes', 'Mejor en orden',
    'Intro y outro perfectos', 'Sin relleno', 'Demasiado largo',
    // Impacto
    'Cambia con el tiempo', 'Amor a primera escucha',
    'Infravalorado', 'Sobrevalorado', 'Obra de culto',
    // Letras
    'Letras profundas', 'Letras poéticas', 'Sin letras destacables',
    'Storytelling', 'Letras cotidianas',
  ];
  selectedTags: string[] = [];

  qEmotions: string = '';
  qRecommend: string = '';

  selectedFavoriteSong = '';
  favoriteSongText = '';

  evolucion: '' | 'crece' | 'inmediato' = '';
  primeraMention = '';

  rating: number = 0;
  hoverRating: number = 0;
  isAlbumFavorite: boolean = false;
  isAlbumSaved: boolean = false;

  listenContextDevice: string = 'Altavoces';
  listenContextTime: string = 'Día';

  lyricsLiked: boolean | null = null;
  listenAgain: boolean | null = null;
  recommendSurvey: boolean | null = null;
  vibeFactor: number = 50;

  hidePreview: boolean = false;

  constructor() {
    const nav = this.router.getCurrentNavigation();
    if (nav?.extras.state?.['album']) {
      this.album = nav.extras.state['album'];
    }
  }

  ngOnInit() {
    if (!this.album) {
      this.router.navigate(['/']);
      return;
    }
    
    this.album.year = 'Buscando...';

    this.musicService.getAlbumDetails(this.album.artist, this.album.name).subscribe({
      next: (details: any) => {
        this.album.year = details.year || 'Desc.';
        this.album.tracks = details.tracks || [];
        this.cdr.detectChanges();
      },
      error: () => {
        this.album.year = '2024';
        this.album.tracks = [];
        this.cdr.detectChanges();
      }
    });
  }

  get hasTracks(): boolean {
    return this.album?.tracks && this.album.tracks.length > 0;
  }

  toggleTag(tag: string) {
    const idx = this.selectedTags.indexOf(tag);
    if (idx > -1) {
      this.selectedTags.splice(idx, 1);
    } else {
      if (this.selectedTags.length < 5) {
        this.selectedTags.push(tag);
      }
    }
  }

  get progress(): number {
    let score = 0;
    if (this.title.length > 0) score += 10;
    if (this.text.length > 20) score += 20;
    if (this.selectedTags.length > 0) score += 10;
    if (this.selectedFavoriteSong.length > 0 || this.favoriteSongText.length > 0) score += 5;
    if (this.qEmotions.length > 0) score += 5;
    if (this.qRecommend.length > 0) score += 5;
    if (this.rating > 0) score += 15;
    if (this.lyricsLiked !== null) score += 10;
    if (this.listenAgain !== null) score += 10;
    if (this.recommendSurvey !== null) score += 10;
    return Math.min(score, 100);
  }

  get displayTitle(): string {
    return this.title.trim().length > 0 ? this.title : 'Sin título';
  }

  setRating(val: number) { this.rating = val; }
  setHoverRating(val: number) { this.hoverRating = val; }
  clearHover() { this.hoverRating = 0; }

  setLyrics(val: boolean) { this.lyricsLiked = val; }
  setListenAgain(val: boolean) { this.listenAgain = val; }
  setRecommend(val: boolean) { this.recommendSurvey = val; }

  saveReview() {
    if (!this.rating) {
      this.saveError = 'Por favor puntúa el álbum antes de publicar.';
      return;
    }
    const user = this.authService.currentUserValue;
    if (!user) {
      this.router.navigate(['/login']);
      return;
    }

    this.isSaving = true;
    this.saveError = '';

    const payload = {
      album_titulo:   this.album?.name,
      album_artista:  this.album?.artist,
      album_portada:  this.album?.image,
      calificacion:   this.rating,
      titulo:         this.title,
      contenido:      this.text,
      etiquetas:      this.selectedTags,
      preguntas_guia: {
        emotions:  this.qEmotions,
        recommend: this.qRecommend
      },
      encuesta: {
        lyricsLiked:   this.lyricsLiked,
        listenAgain:   this.listenAgain,
        recommend:     this.recommendSurvey,
        vibeFactor:    this.vibeFactor
      },
      contexto_escucha: `${this.listenContextDevice} / ${this.listenContextTime}`,
      cancion_favorita: this.hasTracks ? this.selectedFavoriteSong : this.favoriteSongText,
      vibe_factor:     this.vibeFactor,
      evolucion:       this.evolucion || null,
      primera_mencion: this.primeraMention || null,
    };

    this.reviewService.createReview(payload).subscribe({
      next: () => {
        if (this.isAlbumSaved) {
          this.reviewService.toggleSaveAlbum({
            title: this.album?.name,
            artist: this.album?.artist,
            image: this.album?.image
          }).subscribe(() => { });
        }

        if (this.isAlbumFavorite) {
          this.reviewService.toggleFavoriteAlbum({
            title: this.album?.name,
            artist: this.album?.artist,
            image: this.album?.image
          }).subscribe(() => { });
        }

        this.isSaving = false;
        this.saveSuccess = true;
        this.cdr.detectChanges();
        setTimeout(() => this.router.navigate(['/reviews']), 1200);
      },
      error: (err) => {
        this.isSaving = false;
        this.saveError = err.error?.message || 'Error al guardar la reseña.';
        this.cdr.detectChanges();
      }
    });
  }
}
