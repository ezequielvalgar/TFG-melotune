import { Pipe, PipeTransform } from '@angular/core';

@Pipe({ name: 'formatNumber', standalone: true })
export class FormatNumberPipe implements PipeTransform {
  transform(val: number, suffix: string = ''): string {
    if (!val) return '0';
    if (val >= 1_000_000) return (val / 1_000_000).toFixed(1) + 'M' + (suffix ? ' ' + suffix : '');
    if (val >= 1_000)     return (val / 1_000).toFixed(1)     + 'K' + (suffix ? ' ' + suffix : '');
    return val.toString();
  }
}
