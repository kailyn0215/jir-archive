# Jirachi Plush Archive

An evidence-based database documenting every officially licensed Jirachi plush.

**Version:** v0.3 (Pre-v1.0)

## Overview

This archive transforms a spreadsheet-based collection tracker into a structured, maintainable Jekyll site with:

- **35 documented plushes** from manufacturers including Pokemon Center Japan, Banpresto, TOMY, Takara Tomy Arts, and more
- **Filterable archive** with grid and table views
- **Research queue** for unverified items
- **Collection statistics** with breakdowns by company, decade, and region
- **Comprehensive documentation** standards for long-term accuracy

## Quick Start

### Prerequisites

- Ruby 2.7+
- Bundler (`gem install bundler`)

### Local Development

```bash
cd jir
bundle install
bundle exec jekyll serve
```

Open http://localhost:4000 in your browser.

### GitHub Pages Deployment

This site is ready for GitHub Pages. Push to your repository and enable Pages in settings.

## Structure

```
jir/
├── _config.yml          # Jekyll configuration
├── _data/
│   ├── companies.yml    # Manufacturer reference data
│   └── product_lines.yml # Product line reference data
├── _includes/
│   └── plush-card.html  # Reusable plush card component
├── _layouts/
│   ├── default.html     # Base layout
│   └── plush.html       # Individual plush page layout
├── _plushes/            # Collection of plush entries
│   ├── JIR-0001.md
│   ├── JIR-0002.md
│   └── ...
├── assets/
│   └── css/
│       └── style.css    # Site styling
├── index.html           # Master archive page
├── research.html        # Research queue page
├── stats.html           # Statistics page
├── guide.md             # Documentation standards
└── Gemfile              # Ruby dependencies
```

## Adding a New Plush

1. Create a new file in `_plushes/` with the next available ID:

```yaml
---
archive_id: JIR-0036
company_id: PCJ-015
company: Pokemon Center Japan
year: 2024
product_line: New Collection
current_name: New Jirachi Plush
official_name: 
japanese_name: 
region: Japan
size: 
sculpt_id: 
owned: false
verification: Verified
status: Master
availability: 
sources:
  - type: catalog
    url: https://example.com
    notes: Official announcement
images:
  - front.jpg
notes: Description here
search_terms:
  - relevant
  - keywords
---
```

2. Place any images in `assets/images/plushes/JIR-0036/`

3. Commit and push

## Verification Levels

| Level | Description |
|-------|-------------|
| **Verified** | Official documentation exists or multiple independent examples with matching tags |
| **Strong** | High confidence, likely official, needs one additional reliable source |
| **Possible** | Interesting lead, needs significantly more evidence |

## Status Types

- **Master**: Confirmed entry in the main archive
- **Research**: Needs additional verification before promotion

## Archive IDs

Archive IDs are permanent and never change:
- `JIR-0001` through `JIR-0035` are currently assigned
- New entries receive the next sequential number

## Data Fields

| Field | Description |
|-------|-------------|
| `archive_id` | Permanent unique identifier (JIR-XXXX) |
| `company_id` | Manufacturer-specific ID (e.g., PCJ-001) |
| `company` | Manufacturer name |
| `year` | Release year (blank if unknown) |
| `product_line` | Product series/collection |
| `current_name` | Common collector name |
| `official_name` | Official English name (if known) |
| `japanese_name` | Official Japanese name (if known) |
| `region` | Primary release region |
| `size` | Physical dimensions |
| `sculpt_id` | Shared sculpt identifier |
| `owned` | Whether you own this plush |
| `verification` | Evidence confidence level |
| `status` | Master or Research |
| `availability` | Market rarity (1-5 scale) |
| `sources` | Evidence documentation |
| `images` | Photo filenames |
| `notes` | Additional context |
| `search_terms` | Keywords for filtering |

## Migration from Excel

This site was converted from `Jirachi Comprehensive List.xlsx`. The original file is preserved for reference but should not be used for updates. All changes should be made to the markdown files in `_plushes/`.

## Philosophy

> **If it cannot be supported by evidence, it does not belong in the Master Archive.**

The archive prioritizes accuracy over completeness. Items remain in the Research queue until sufficient evidence exists for promotion.

## License

Personal archive project. Pokemon and Jirachi are trademarks of Nintendo/The Pokemon Company.