import { Routes } from '@angular/router';
import { HomeComponent } from './components/home/home';
import { ReviewsPageComponent } from './components/reviews-page/reviews-page';
import { CreateReviewComponent } from './components/create-review/create-review';
import { LoginPageComponent } from './components/login-page/login-page';
import { ProfilePageComponent } from './components/profile-page/profile-page';
import { VerifyEmailComponent } from './components/verify-email/verify-email';
import { AlbumPageComponent } from './components/album-page/album-page';
import { NewReleasesComponent } from './components/new-releases/new-releases';
import { AboutUsComponent } from './components/about-us/about-us';
import { PrivacyComponent } from './components/privacy/privacy';
import { CookiesComponent } from './components/cookies/cookies';
import { SettingsComponent } from './components/settings/settings';
import { ArtistPageComponent } from './components/artist-page/artist-page';
import { FriendsPageComponent } from './components/friends-page/friends-page';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'login', component: LoginPageComponent },
  { path: 'profile', component: ProfilePageComponent },
  { path: 'profile/:id', component: ProfilePageComponent },
  { path: 'reviews', component: ReviewsPageComponent },
  { path: 'create-review', component: CreateReviewComponent },
  { path: 'verify-email', component: VerifyEmailComponent },
  { path: 'album/:artist/:title', component: AlbumPageComponent },
  { path: 'new-releases', component: NewReleasesComponent },
  { path: 'about', component: AboutUsComponent },
  { path: 'privacidad', component: PrivacyComponent },
  { path: 'cookies', component: CookiesComponent },
  { path: 'ajustes', component: SettingsComponent },
  { path: 'artist/:name', component: ArtistPageComponent },
  { path: 'friends', component: FriendsPageComponent }
];

