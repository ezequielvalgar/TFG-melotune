// ─── Interfaces de dominio para MeloTune ───────────────────────────────────
// Úsalas para tipar los retornos de servicios en lugar de `any`.

export interface Track {
  name: string;
  duration: number;
}

export interface Album {
  name?: string;
  title?: string;
  artist: string;
  image: string | null;
  score: number | null;
  year?: string;
  plays?: number;
  listeners?: number;
  tracks?: Track[];
  description?: string;
  tags?: string[];
  release_date?: string;
}

export interface Artist {
  name: string;
  image: string | null;
  listeners: number;
  bio?: string;
  genres?: string[];
  albums?: Album[];
}

export interface Review {
  id: number;
  userId: number;
  username: string;
  userAvatar: string;
  albumTitle: string;
  artist: string;
  albumImage: string;
  rating: number;
  reviewTitle: string;
  content: string;
  likes: number;
  likedByUser: boolean;
  tags: string[];
  date: string;
  favoriteSong?: string;
  listenCount?: number;
  vibeIcon?: string;
  vibeColor?: string;
  vibeMood?: string;
  comments?: number;
}

export interface UserProfile {
  id: number;
  username: string;
  nombre: string;
  email?: string;
  foto_perfil: string;
  bio?: string;
  fecha_registro?: string;
  followers_count?: number;
  following_count?: number;
}

export interface FollowStats {
  followers_count: number;
  following_count: number;
  is_following: boolean;
}

// Tipo de respuesta paginada de Laravel
export interface PaginatedResponse<T> {
  data: T[];
  current_page: number;
  last_page: number;
  total: number;
  per_page: number;
}

// Toggle responses
export interface ToggleResponse {
  status: 'added' | 'removed';
  liked: boolean;
  likes: number;
  favorited?: boolean;
}
