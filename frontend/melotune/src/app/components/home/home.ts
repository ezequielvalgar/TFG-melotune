import { Component } from '@angular/core';
import { HeroSearchComponent } from './hero-search/hero-search';
import { FeaturedAlbumsComponent } from './featured-albums/featured-albums';
import { PopularArtistsComponent } from './popular-artists/popular-artists';
import { LatestReviewsComponent } from './latest-reviews/latest-reviews';
import { SidebarPromoComponent } from './sidebar-promo/sidebar-promo';

@Component({
  selector: 'app-home',
  imports: [
    HeroSearchComponent,
    FeaturedAlbumsComponent,
    PopularArtistsComponent,
    LatestReviewsComponent,
    SidebarPromoComponent
  ],
  templateUrl: './home.html',
  styleUrl: './home.css',
  standalone: true
})
export class HomeComponent {

}
