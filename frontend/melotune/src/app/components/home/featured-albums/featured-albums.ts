import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-featured-albums',
  imports: [CommonModule],
  templateUrl: './featured-albums.html',
  styleUrl: './featured-albums.css',
  standalone: true
})
export class FeaturedAlbumsComponent {
  featuredAlbums = [
    { title: 'Oracular Spectacular', artist: 'MGMT', image: 'https://placehold.co/400x400/222436/60658a?text=Oracular+Spectacular+por+MGMT' },
    { title: 'I Love You.', artist: 'The Neighbourhood', image: 'https://placehold.co/400x400/222436/60658a?text=I+Love+You.+por+The+Neighbourhood' },
    { title: 'Take Care', artist: 'Drake', image: 'https://placehold.co/400x400/222436/60658a?text=Take+Care+por+Drake' },
    { title: 'Currents', artist: 'Tame Impala', image: 'https://placehold.co/400x400/222436/60658a?text=Currents' }
  ];
}
