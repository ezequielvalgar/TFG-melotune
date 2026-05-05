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

  // Datos del álbum (inyectados por el buscador)
  album: any = null;

  // Formulario de Texto
  title: string = '';
  text: string = '';

  // Etiquetas
  availableTags = [
    'Producción increíble', 'Letras profundas', 'Para llorar', 'Buenas vibras', 
    'Obra maestra', 'Experimental', 'Nostálgico', 'Bailable', 'Relajante', 'Energético'
  ];
  selectedTags: string[] = [];

  // Preguntas Guía
  qFavSong: string = '';
  qEmotions: string = '';
  qRecommend: string = '';

  // Canciones Puntuables (Accordion)
  trackRatings: any[] = [];
  showTracks: boolean = true;

  // Interacción General (Estrellas del Álbum)
  rating: number = 0;
  hoverRating: number = 0;
  isAlbumFavorite: boolean = false;
  isAlbumSaved: boolean = false;
  
  // Contextos y Escuchas
  listenContextDevice: string = 'Altavoces'; // Auriculares | Altavoces | Coche
  listenContextTime: string = 'Día';         // Día | Noche

  // Encuesta
  lyricsLiked: boolean | null = null;
  listenAgain: boolean | null = null;
  recommendSurvey: boolean | null = null;
  vibeFactor: number = 50; // Slider de caras 0 a 100
  
  // Vista Previa
  hidePreview: boolean = false;

  constructor() {
    const nav = this.router.getCurrentNavigation();
    if (nav?.extras.state?.['album']) {
      this.album = nav.extras.state['album'];
    }
  }

  ngOnInit() {
    if (!this.album) {
      this.album = {
        name: 'Blonde',
        artist: 'Frank Ocean',
        image: 'https://lastfm.freetls.fastly.net/i/u/300x300/aae3b99eb4e3415c898c117b9b1ac00e.png',
        year: '2016'
      };
    } else {
      this.album.year = 'Buscando...';
      
      this.musicService.getAlbumDetails(this.album.artist, this.album.name).subscribe({
        next: (details: any) => {
          this.album.year = details.year || 'Desc.';
          
          // Construir array de puntuación de canciones
          if (details.tracks && details.tracks.length > 0) {
            this.trackRatings = details.tracks.map((t: any) => ({
              name: t.name,
              rating: 0,
              hoverRating: 0,
              favorite: false
            }));
          } else {
             // Mockup tracks if Last.fm fails to deliver
             this.trackRatings = [
                {name: 'Nikes', rating: 0, hoverRating: 0, favorite: false},
                {name: 'Ivy', rating: 0, hoverRating: 0, favorite: false},
                {name: 'Pink + White', rating: 0, hoverRating: 0, favorite: false},
                {name: 'Be Yourself', rating: 0, hoverRating: 0, favorite: false},
                {name: 'Solo', rating: 0, hoverRating: 0, favorite: false},
                {name: 'Skyline To', rating: 0, hoverRating: 0, favorite: false},
                {name: 'Self Control', rating: 0, hoverRating: 0, favorite: false},
                {name: 'Good Guy', rating: 0, hoverRating: 0, favorite: false}
             ];
          }

          this.cdr.detectChanges();
        },
        error: () => {
          this.album.year = '2024';
          // Mockup tracks if fail
          this.trackRatings = [
             {name: 'Track 1', rating: 0, hoverRating: 0, favorite: false},
             {name: 'Track 2', rating: 0, hoverRating: 0, favorite: false},
             {name: 'Track 3', rating: 0, hoverRating: 0, favorite: false}
          ];
          this.cdr.detectChanges();
        }
      });
    }
  }

  // Lógica de Etiquetas
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

  // Progreso general
  get progress(): number {
    let score = 0;
    if (this.title.length > 0) score += 10;
    if (this.text.length > 20) score += 20;
    if (this.selectedTags.length > 0) score += 10;
    if (this.qFavSong.length > 0) score += 5;
    if (this.qEmotions.length > 0) score += 5;
    if (this.qRecommend.length > 0) score += 5;
    if (this.rating > 0) score += 15;
    if (this.lyricsLiked !== null) score += 10;
    if (this.listenAgain !== null) score += 10;
    if (this.recommendSurvey !== null) score += 10;
    return Math.min(score, 100);
  }

  // Título dinámico para la preview
  get displayTitle(): string {
    return this.title.trim().length > 0 ? this.title : 'Sin título';
  }

  // Rating Álbum General
  setRating(val: number) { this.rating = val; }
  setHoverRating(val: number) { this.hoverRating = val; }
  clearHover() { this.hoverRating = 0; }
  
  // Track Ratings
  setTrackRating(index: number, val: number) { this.trackRatings[index].rating = val; }
  setTrackHover(index: number, val: number) { this.trackRatings[index].hoverRating = val; }
  clearTrackHover(index: number) { this.trackRatings[index].hoverRating = 0; }
  toggleTrackFav(index: number) { this.trackRatings[index].favorite = !this.trackRatings[index].favorite; }

  // Encuesta
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
        favSong:   this.qFavSong,
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
      cancion_favorita: this.qFavSong,
      vibe_factor:     this.vibeFactor
    };

    this.reviewService.createReview(payload).subscribe({
      next: () => {
        // 1. Si el usuario marcó "Guardar", lo mandamos a la tabla de guardados
        if (this.isAlbumSaved) {
          this.reviewService.toggleSaveAlbum({
            title: this.album?.name,
            artist: this.album?.artist,
            image: this.album?.image
          }).subscribe(() => { /* Guardado silencioso */ });
        }

        // 2. Si el usuario marcó "Favorito", lo mandamos a la tabla de favoritos
        if (this.isAlbumFavorite) {
          this.reviewService.toggleFavoriteAlbum({
            title: this.album?.name,
            artist: this.album?.artist,
            image: this.album?.image
          }).subscribe(() => { /* Favorito silencioso */ });
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
