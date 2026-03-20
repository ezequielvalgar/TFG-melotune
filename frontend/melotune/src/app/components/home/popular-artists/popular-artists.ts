import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-popular-artists',
  imports: [CommonModule],
  templateUrl: './popular-artists.html',
  styleUrl: './popular-artists.css',
  standalone: true
})
export class PopularArtistsComponent {
  popularArtists = [
    { name: 'MGMT', genre: 'Indie Pop / Psychedelic Rock', rating: '4.4', image: 'https://placehold.co/100/222436/60658a?text=MGMT' },
    { name: 'THE NEIGHBOURHOOD', genre: 'Indie Rock / Alternative', rating: '4', image: 'https://placehold.co/100/222436/60658a?text=The' },
    { name: 'DRAKE', genre: 'Hip-Hop / R&B', rating: '4.4', image: 'https://placehold.co/100/222436/60658a?text=Drake' },
    { name: 'TAME IMPALA', genre: 'Psychedelic Pop / Neo-psychedelia', rating: '4.7', image: 'https://placehold.co/100/222436/60658a?text=Tame+Impala' },
    { name: 'FRANK OCEAN', genre: 'R&B / Art Pop', rating: '4.8', image: 'https://placehold.co/100/222436/60658a?text=Frank+Ocean' },
    { name: 'KENDRICK LAMAR', genre: 'Hip-Hop / Conscious Rap', rating: '4.8', image: 'https://placehold.co/100/222436/60658a?text=Kendrick' },
  ];
}
