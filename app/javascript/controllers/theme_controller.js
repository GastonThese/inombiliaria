import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  connect() {
    let savedTheme = localStorage.getItem('theme');

    const navbar = document.getElementById('navbar');

    if (savedTheme === 'dark') {
      document.documentElement.classList.add('dark');

      if (!navbar) return;

      document.getElementById('moon').classList.add('hidden');
      document.getElementById('sun').classList.remove('hidden');
    } else {

      if (!navbar) return;

      document.getElementById('moon').classList.remove('hidden');
      document.getElementById('sun').classList.add('hidden');
    }
  }

  changeTheme() {
    let html = document.documentElement;
    html.classList.toggle('dark');

    if (html.classList.contains('dark')) {
      localStorage.setItem('theme', 'dark');
      document.getElementById('moon').classList.add('hidden');
      document.getElementById('sun').classList.remove('hidden');
     }else {
      localStorage.setItem('theme', 'light');
      document.getElementById('moon').classList.remove('hidden');
      document.getElementById('sun').classList.add('hidden');
    }
  }
}
