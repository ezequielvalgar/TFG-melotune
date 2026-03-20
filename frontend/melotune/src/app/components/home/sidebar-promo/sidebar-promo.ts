import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-sidebar-promo',
  imports: [CommonModule],
  templateUrl: './sidebar-promo.html',
  styleUrl: './sidebar-promo.css',
  standalone: true
})
export class SidebarPromoComponent {
  topAlbums = [
    { title: 'Good Kid, m.A.A.d City', artist: 'Kendrick Lamar', score: '4.8', image: 'https://placehold.co/100/222436/60658a?text=Good' },
    { title: 'Blonde', artist: 'Frank Ocean', score: '4.8', image: 'https://placehold.co/100/222436/60658a?text=Blonde' },
    { title: 'Currents', artist: 'Tame Impala', score: '4.7', image: 'https://placehold.co/100/222436/60658a?text=Currents' }
  ];
}
