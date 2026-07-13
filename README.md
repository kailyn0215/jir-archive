# Jirachi Plush Archive

A comprehensive catalog documenting every Jirachi Pokémon plush ever manufactured.

🌐 **Live Site**: [Coming Soon]

## Overview

The Jirachi Plush Archive is the definitive reference for collectors and researchers documenting Jirachi plush toys from all manufacturers worldwide.

### Features

- **Master Archive**: Verified plushes with complete documentation
- **Research Queue**: Items awaiting verification
- **Personal Collection**: Track owned/wanted/for-trade (stored locally)
- **Advanced Search**: Fuzzy search with multi-select filters
- **Dark Mode**: Automatic system preference detection
- **Mobile-First**: Fully responsive design

## Tech Stack

- **Static Site Generator**: [Jekyll](https://jekyllrb.com/)
- **Hosting**: GitHub Pages (or any static host)
- **Styling**: Custom CSS with design tokens (no frameworks)
- **JavaScript**: Vanilla JS + Fuse.js for search
- **Data**: YAML front matter in Markdown files

## Getting Started

### Prerequisites

- Ruby 2.7+ with Bundler
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/jirachi-archive.git
cd jirachi-archive

# Install dependencies
bundle install

# Start development server
bundle exec jekyll serve --livereload
```

Visit `http://localhost:4000` to view the site.

### Build for Production

```bash
bundle exec jekyll build
```

Output goes to `_site/` directory.

## Project Structure

```
jir-archive/
├── _config.yml          # Jekyll configuration
├── _data/
│   ├── companies.yml    # Company/manufacturer definitions
│   ├── product_lines.yml # Product line definitions
│   └── tags.yml         # Tag taxonomy
├── _includes/
│   └── plush-card.html  # Reusable card component
├── _layouts/
│   ├── default.html     # Base layout
│   └── plush.html       # Individual plush detail page
├── _plushes/            # Plush data files (one per item)
│   ├── JIR-TOMY-0001.md
│   └── ...
├── assets/
│   ├── css/style.css    # All styles
│   └── images/
│       └── plushes/     # Plush images organized by ID
├── scripts/
│   └── new_plush.rb     # Helper script for adding plushes
├── index.html           # Master Archive page
├── research.html        # Research Queue page
├── stats.html           # Statistics page
├── guide.md             # User guide
├── SCHEMA.md            # Data schema documentation
└── README.md            # This file
```

## Data Model

See [SCHEMA.md](SCHEMA.md) for complete schema documentation.

### Quick Reference

Each plush is a Markdown file in `_plushes/` with YAML front matter:

```yaml
---
layout: plush
archive_id: JIR-TOMY-0001
name: "Jirachi Plush"
name_jp: "ジラーチ ぬいぐるみ"
company: Tomy
product_line: Pokémon Plush Collection
year: 2003
region: Japan
status: Master          # Master, Research, or Missing
verification: Verified  # Verified, Strong, or Possible
availability: 3         # 1-5 scale

images:
  primary: /assets/images/plushes/JIR-TOMY-0001/front.jpg
  gallery:
    - url: /assets/images/plushes/JIR-TOMY-0001/side.jpg
      alt: Side view
    - url: /assets/images/plushes/JIR-TOMY-0001/tush-tag.jpg
      alt: Tush tag

price:
  amount: 1200
  currency: JPY

dimensions:
  height_cm: 15

sources:
  - type: MFC
    description: "Tomy 2003 Product Catalog"
    url: https://example.com
    tier: S

tags:
  - standing
  - open-eyes
---

Optional notes about this plush go here as Markdown content.
```

## Adding a New Plush

### Option 1: Use the Helper Script

```bash
ruby scripts/new_plush.rb
```

Follow the prompts to generate a new plush file.

### Option 2: Manual Creation

1. Create a new file: `_plushes/JIR-[COMPANY]-[NNNN].md`
2. Copy the template from another plush or SCHEMA.md
3. Fill in all required fields
4. Add images to `assets/images/plushes/[ID]/`
5. Commit and push

### ID Format

```
JIR-[COMPANY]-[NUMBER]
```

- `JIR` - Jirachi prefix (always)
- `COMPANY` - Company code (see below)
- `NUMBER` - 4-digit sequential number

**Company Codes:**

| Code | Company |
|------|---------|
| TOMY | Tomy / Takara Tomy |
| BAN | Banpresto |
| JPPC | Pokémon Center Japan |
| USPC | Pokémon Center US/International |
| SAN | San-ei / All-Star Collection |
| BNS | Build-A-Bear / Other specialty |
| UNK | Unknown manufacturer |

## Verification Levels

| Level | Description | Location |
|-------|-------------|----------|
| **Verified** | Complete documentation, multiple sources | Master Archive |
| **Strong** | High confidence, minor gaps | Research Queue |
| **Possible** | Needs corroboration | Research Queue |

## Image Guidelines

- **Format**: WebP preferred, JPEG/PNG acceptable
- **Size**: 800px minimum width, optimize for web
- **Structure**: Each plush has its own folder:
  ```
  assets/images/plushes/JIR-TOMY-0001/
  ├── front.jpg      # Primary image
  ├── side.jpg
  ├── back.jpg
  ├── tush-tag.jpg   # Critical for verification
  └── hang-tag.jpg
  ```

### Required Photos for Verified Status

1. Front view (clear, well-lit)
2. Tush tag (legible manufacturer info)

### Recommended Additional Photos

- Side view
- Back view
- Hang tag (if present)
- Size reference (ruler/coin)

## Contributing

We welcome contributions! See the [Guide](/guide#contributing) for details.

### Quick Contribution Steps

1. Fork the repository
2. Create a feature branch
3. Add or update plush data
4. Ensure images are optimized
5. Submit a pull request

### Reporting Issues

- Use GitHub Issues for bugs and feature requests
- Use the Research page submission form for new plush reports

## Design System

### CSS Variables

The site uses CSS custom properties for theming:

```css
--c-bg          /* Background */
--c-surface     /* Card/panel background */
--c-text        /* Primary text */
--c-accent      /* Brand accent color */
--c-border      /* Border color */
--sp-1 to --sp-12  /* Spacing scale */
--text-xs to --text-2xl  /* Type scale */
```

### Color Modes

- Light mode: Default
- Dark mode: Automatic via `prefers-color-scheme` or manual toggle

## Browser Support

- Chrome/Edge 90+
- Firefox 90+
- Safari 14+
- Mobile browsers (iOS Safari, Chrome Android)

## Performance

Target Lighthouse scores: 95+ across all categories

Key optimizations:
- Lazy loading images
- Minimal CSS (no frameworks)
- Vanilla JavaScript
- Static site (no server rendering)

## License

Content: Creative Commons Attribution (CC BY 4.0)
Code: MIT License

## Credits

- Maintained by [Your Name]
- Built with Jekyll
- Search powered by Fuse.js
- Images sourced with attribution

---

*This is a fan project and is not affiliated with The Pokémon Company, Nintendo, or any plush manufacturers.*