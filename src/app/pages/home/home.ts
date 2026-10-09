import { Component, HostListener, OnDestroy, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import AOS from 'aos';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, MatIconModule],
  templateUrl: './home.html',
  styleUrl: './home.scss',
})
export class Home implements OnInit, OnDestroy {
  currentYear = new Date().getFullYear();
  counter = 1;
  menuOpen = false;

  private slideTimer: ReturnType<typeof setInterval> | null = null;

  ngOnInit(): void {
    AOS.init({
      duration: 800,
      once: true,
      offset: 80,
    });

    this.slideTimer = setInterval(() => {
      this.counter = this.counter === 5 ? 1 : this.counter + 1;
    }, 7000);
  }

  ngOnDestroy(): void {
    if (this.slideTimer) {
      clearInterval(this.slideTimer);
    }
  }

  @HostListener('window:scroll')
  onWindowScroll(): void {
    const menuBar = document.getElementById('menu-bar');
    if (!menuBar) return;
    if (window.pageYOffset > 200) {
      menuBar.classList.add('sticky');
    } else {
      menuBar.classList.remove('sticky');
    }
  }

  scroll(sectionId: string): void {
    this.menuOpen = false;
    const el = document.getElementById(sectionId);
    if (!el) return;
    const menuBar = document.getElementById('menu-bar');
    const offset = menuBar ? menuBar.offsetHeight : 0;
    const top = el.getBoundingClientRect().top + window.pageYOffset - offset;
    window.scrollTo({ top, behavior: 'smooth' });
  }

  toggleMenu(): void {
    this.menuOpen = !this.menuOpen;
  }
}
