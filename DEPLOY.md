# Deploy to GitHub Pages (Metal Drafting — Angular 20)

The **built** app (from `dist/metaldrafting-website/browser`) is pushed to the `gh-pages` branch. GitHub Pages must serve **that branch**, not `main`/`master`.

## Local development

```bash
npm install
npm start
```

Open `http://localhost:4200`.

## Deploy

```bash
./deploy-gh-pages.sh
```

## One-time Pages setup

1. Open `https://github.com/metaldrafting/mdraft-website`
2. **Settings → Pages**
3. **Source:** Deploy from a branch
4. **Branch:** `gh-pages` → `/ (root)` → Save

## Live URL

- Project Pages: `https://metaldrafting.github.io/mdraft-website/`
- Custom domain (if configured): `https://metaldrafting.com`
