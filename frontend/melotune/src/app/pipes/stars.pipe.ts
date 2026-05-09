import { Pipe, PipeTransform } from '@angular/core';

@Pipe({ name: 'stars', standalone: true })
export class StarsPipe implements PipeTransform {
  transform(rating: number, type: 'full' | 'half' | 'empty'): number[] {
    const r = rating || 0;
    if (type === 'full') return Array(Math.floor(r)).fill(0);
    if (type === 'half') return r % 1 >= 0.5 ? [1] : [];
    const full = Math.floor(r);
    const half = r % 1 >= 0.5 ? 1 : 0;
    return Array(Math.max(0, 5 - full - half)).fill(0);
  }
}
