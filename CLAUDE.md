# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a **static assets repository** — a read-only public mirror of Pokémon images and banners served via Docker/Apache for [pokénin.fr](https://pokénin.fr). There is no application code; the actual image sources and generation scripts live in the private `pokenini-icon` repository.

## Repository layout

| Path | Content |
|------|---------|
| `big/regular/` | Full-size Pokémon images (PNG + WebP) |
| `big/shiny/` | Full-size shiny Pokémon images |
| `small/regular/` | Thumbnail Pokémon images |
| `small/shiny/` | Thumbnail shiny Pokémon images |
| `banner/` | Dex/filter banner images (PNG + WebP) |
| `types/` | Pokémon type icons (WebP) |
| `resources/metadata/version` | Written by CI at release time with the version string |

## Image naming convention

Files are named `<pokemon-name>[<-suffix>].(png|webp)`. Suffixes encode form variants:
- `-f` — female form
- `-mega` — Mega evolution
- `-mega-z` — Mega form from Pokémon Legends: Z-A
- `-blade`, `-alola`, `-galar`, etc. — regional/battle forms

Both `.png` and `.webp` exist for every image.

## Key commands

```bash
make copy        # Sync images from ../pokenini-icon/images/ into this repo
make host        # Serve locally at http://localhost:8083 via Docker/Apache
make unhost      # Stop the local server
make img-build   # Build and push Docker image to ghcr.io (requires auth)
```

## Deployment

A GitHub Actions workflow (`.github/workflows/push.yml`) triggers on GitHub releases. It builds and pushes a multi-arch Docker image (`linux/amd64` + `linux/arm64`) to `ghcr.io/douzeensemble/pokenini-resources`, tagging stable releases as `*-release` and prereleases as `*-prerelease`. The version string is injected into `resources/metadata/version` at build time.

The Docker image is a plain `httpd:2.4-alpine` container with the entire repo copied into the Apache document root.
