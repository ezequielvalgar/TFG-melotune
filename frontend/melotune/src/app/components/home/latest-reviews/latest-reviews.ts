import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-latest-reviews',
  imports: [CommonModule],
  templateUrl: './latest-reviews.html',
  styleUrl: './latest-reviews.css',
  standalone: true
})
export class LatestReviewsComponent {
  latestReviews = [
    {
      albumTitle: 'Currents',
      artist: 'Tame Impala',
      albumImage: 'https://placehold.co/100/222436/60658a?text=Currents',
      username: 'soundwaves_alex',
      userAvatar: 'https://placehold.co/50/222436/60658a?text=A',
      date: '15 de noviembre de 2024',
      reviewTitle: 'Una obra maestra de la psicodelia moderna',
      content: 'Currents es un disco que te envuelve completamente. Desde la obertura de Let It Happen hasta el cierre de New Person, Same Old Mistakes, Kevin Parker construye un universo sonoro que mezcla melancolía y euforia con una habilidad extraordinaria. Cada escucha revela nuevas capas.',
      likes: 42
    },
    {
      albumTitle: 'Blonde',
      artist: 'Frank Ocean',
      albumImage: 'https://placehold.co/100/222436/60658a?text=Blonde',
      username: 'vinyl_dreams',
      userAvatar: 'https://placehold.co/50/222436/60658a?text=V',
      date: '22 de octubre de 2024',
      reviewTitle: 'Intimidad en forma de álbum',
      content: 'Blonde es incómodo, fragmentado y absolutamente genial. Frank Ocean construye momentos de una vulnerabilidad aplastante. Nights es quizás el punto más alto, pero el conjunto es más grande que la suma de sus partes. Un disco que cambia según cómo te encuentres el día que lo escuchas.',
      likes: 67
    },
    {
      albumTitle: 'good kid, m.A.A.d city',
      artist: 'Kendrick Lamar',
      albumImage: 'https://placehold.co/100/222436/60658a?text=good+kid',
      username: 'crate_digger_mx',
      userAvatar: 'https://placehold.co/50/222436/60658a?text=C',
      date: '5 de septiembre de 2024',
      reviewTitle: 'El mejor álbum conceptual de rap',
      content: 'Kendrick logró algo que pocos raperos consiguen: crear una película en audio. Cada transición, cada interludio de buzón de voz, cada beat cuenta parte de la historia. Money Trees sola vale el precio de entrada.',
      likes: 89
    }
  ];
}
