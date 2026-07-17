# Jirachi Plush Archive — Data Schema v1.0

This document defines the canonical data model for all plush entries in the archive. It serves as the contract between data files, templates, and documentation.

---

## Entry Statuses

| Status | Description |
|--------|-------------|
| `Master` | Verified, documented, and photographed. Lives in the main archive. |
| `Research` | Needs additional verification before promotion to Master. |
| `Missing` | Known to exist but not yet photographed or fully documented. |

---

## Verification Levels (Master Archive only)

| Level | Description |
|-------|-------------|
| `Verified` | Official manufacturer documentation exists, OR multiple independent examples with matching tags. |
| `Strong` | High confidence, likely official, needs one additional reliable source. |
| `Unverified` | Insufficient documentation. Should not appear in Master without upgrade. |

---

## Confidence Levels (Research Queue only)

| Level | Description |
|-------|-------------|
| `Strong` | High confidence this item exists as described. Promotion likely with one more source. |
| `Possible` | Interesting lead. Needs significantly more evidence before promotion. |

---

## Availability Rating (Market Rarity)

| Rating | Meaning |
|--------|---------|
| `5` | Frequently available |
| `4` | Available with patience |
| `3` | Uncommon |
| `2` | Difficult to obtain |
| `1` | Extremely rare |

---

## Controlled Vocabulary: Tags

Tags use a `category:value` format for filtering and faceted search.

### Size Tags
- `size:mini` — Under 4" / 10cm
- `size:small` — 4-8" / 10-20cm
- `size:medium` — 8-14" / 20-35cm
- `size:large` — 14-24" / 35-60cm
- `size:jumbo` — Over 24" / 60cm
- `size:life-size` — Life-sized (20+ inches)

### Material Tags
- `material:minky`
- `material:velboa`
- `material:polyester`
- `material:cotton`
- `material:felt`
- `material:plush`

### Type Tags
- `type:standard` — Standard retail plush
- `type:prize` — Arcade/crane game prize
- `type:lottery` — Ichiban kuji / lottery prize
- `type:keychain` — Keychain/mascot size
- `type:cushion` — Pillow/cushion style
- `type:puppet` — Hand puppet
- `type:pokedoll` — Poké Doll line

### Event Tags
- `event:promo` — Promotional/limited release
- `event:movie` — Movie tie-in
- `event:anniversary` — Anniversary collection
- `event:holiday` — Holiday/seasonal release
- `event:regional` — Regional exclusive

### Variant Tags
- `variant:rerelease` — Re-release of existing sculpt
- `variant:color` — Color variant
- `variant:size` — Size variant of same sculpt
- `variant:regional` — Regional variant (same sculpt, different market)

### Special Tags
- `special:sleeping` — Sleeping pose
- `special:sitting` — Sitting pose
- `special:standing` — Standing pose
- `special:ditto` — Ditto transformation variant
- `special:shiny` — Shiny coloring

---

## Source Reliability Tiers

| Tier | Description | Examples |
|------|-------------|----------|
| `S` | Primary official sources | Official catalogs, retailer pages, Pokemon Center announcements |
| `A` | Archived official / major resellers | Mandarake, Suruga-ya, official scans |
| `B` | Marketplace listings | Yahoo Auctions, Mercari, Rakuten |
| `C` | Community sources | Collector blogs, Reddit, Flickr |

---

## Plush Entry Frontmatter Schema

```yaml
# === IDENTITY ===
archive_id: JIR-JPPC-0001        # Required. Permanent ID: JIR-{COMPANY}-{NNNN}
company_id: JPPC                  # Required. Company prefix (BAN, BNS, JPPC, TOMY, USPC, etc.)
company: Pokémon Center Japan     # Required. Human-readable company name

# === NAMES ===
current_name: Poké Doll           # Required. Common collector name
official_name:                    # Optional. Official English name
japanese_name:                    # Optional. Official Japanese name (日本語)
romaji_name:                      # Optional. Romanized Japanese name

# === CLASSIFICATION ===
product_line: Poké Doll           # Required. Product series/collection name
product_line_id: poke-doll        # Required. Slug for filtering (matches _data/product_lines.yml)
manufacturer:                     # Optional. Sub-brand if different from company (e.g., "Takara Tomy A.R.T.S")

# === RELEASE INFO ===
year:                             # Optional. Release year (integer)
release_date:                     # Optional. Specific release date (YYYY-MM-DD)
region: Japan                     # Required. Primary release region

# === PHYSICAL ATTRIBUTES ===
size:                             # Optional. Freeform size string (e.g., "6 inches", "15cm")
dimensions:                       # Optional. Structured dimensions
  height:                         # e.g., "15cm"
  width:                          # e.g., "12cm"
  depth:                          # e.g., "10cm"
materials: []                     # Optional. Array of material strings

# === PRICING ===
price:                            # Optional. Structured price object
  amount:                         # Numeric amount (e.g., 1320)
  currency: JPY                   # ISO currency code (JPY, USD, etc.)
price_display:                    # Optional. Freeform display string (e.g., "¥1,320", "Prize")

# === TAXONOMY ===
tags: []                          # Optional. Array of controlled vocabulary tags (category:value)
search_terms: []                  # Optional. Freeform search keywords


# Category	  What it classifies	    Examples
# size:	      Physical size	            size:mini, size:small, size:medium, size:large, size:jumbo, size:life-size
# type:	      Distribution/product type	type:standard, type:prize, type:lottery, type:keychain, type:cushion, type:pokedoll
# material:	  Fabric/material	        material:minky, material:velboa, material:polyester
# event:	  Release context	        event:promo, event:movie, event:anniversary, event:holiday, event:regional
# special:	  Pose or unique features	special:sleeping, special:sitting, special:standing, special:glow-in-the-dark, special:ditto
# variant:	  Variant relationship	    variant:rerelease, variant:color, variant:size, variant:regional

# === VARIANTS & RELATIONSHIPS ===
sculpt_id:                        # Optional. Shared sculpt identifier (e.g., "SC-002")
variant_of:                       # Optional. Archive ID of parent item (e.g., "JIR-JPPC-0001")
variant_type:                     # Optional. Type of variant: rerelease | size | color | regional

# === STATUS & VERIFICATION ===
status: Master                    # Required. Master | Research | Missing
verification: Verified            # Required for Master. Verified | Strong | Unverified
confidence:                       # Required for Research. Strong | Possible
availability:                     # Optional. 1-5 rarity rating

# === PROVENANCE ===
sources:                          # Optional. Array of evidence sources
  - type: catalog                 # Source type: catalog | listing | archive | photo | article
    tier: S                       # Reliability tier: S | A | B | C
    url:                          # URL to source
    accessed:                     # Date accessed (YYYY-MM-DD)
    notes:                        # Description of what this source proves

# Backward compatibility: 'links' is deprecated, use 'sources'
links: []                         # Deprecated. Will be migrated to 'sources'.

# === DOCUMENTATION ===
notes:                            # Optional. Freeform notes/description
images:                           # Optional. Override auto-discovered images
  main:                           # Primary thumbnail image path
  gallery: []                     # Additional image paths

# === COLLECTION TRACKING ===
# Note: 'owned' is deprecated in frontmatter. Collection state is managed client-side.
owned:                            # Deprecated. Ignored by site.
```

---

## ID Conventions

### Archive ID Format
```
JIR-{COMPANY}-{NNNN}
```
- `JIR` — Jirachi prefix (all entries)
- `{COMPANY}` — Company code from `_data/companies.yml`
- `{NNNN}` — 4-digit sequential number, zero-padded

### Company Codes
| Code | Company |
|------|---------|
| `BAN` | Banpresto |
| `BNS` | Bandai Spirits |
| `JPPC` | Pokémon Center Japan |
| `TOMY` | TOMY (includes Takara Tomy, Takara Tomy A.R.T.S) |
| `USPC` | Pokémon Center US |

New companies may be added to `_data/companies.yml` as needed.

### Sculpt ID Format
```
SC-{NNN}
```
Used to group entries that share the same physical mold/design across different releases.

---

## Migration Notes

### From v0.3 to v1.0

1. **`links` → `sources`**: The `links` array is deprecated. Migrate to `sources` with added `tier` and `accessed` fields.

2. **`verification` scope**: Now only applies to `status: Master` entries. Research entries use `confidence` instead.

3. **`confidence` field**: New field for Research Queue entries. Replaces overloaded use of `verification`.

4. **`status: Missing`**: New status for known-but-unphotographed items.

5. **`price` structure**: Changed from freeform string to structured `{amount, currency}` object. Use `price_display` for legacy display strings.

6. **`tags` controlled vocabulary**: New field using `category:value` format. Distinct from freeform `search_terms`.

7. **`variant_of` / `variant_type`**: New fields for parent-child relationships.

8. **`dimensions`**: New structured object for precise measurements.

9. **`romaji_name`**: New field to separate romanized Japanese from localized English.

10. **`owned` deprecated**: Collection tracking is client-side only. Frontmatter `owned` field is ignored.

---

## File Naming Convention

Plush entry files are named after their Archive ID:
```
_plushes/JIR-JPPC-0001.md
_plushes/JIR-BAN-0009.md
```

Image folders follow the same convention:
```
assets/images/plushes/JIR-JPPC-0001/
assets/images/plushes/JIR-BAN-0009/
```

---

## Example Entry

```yaml
---
archive_id: JIR-JPPC-0005
company_id: JPPC
company: Pokémon Center Japan
current_name: Pokémon Fit Jirachi
official_name: Pokémon Fit Jirachi
japanese_name: ポケモンフィット ジラーチ
romaji_name: Pokemon Fitto Jiraachi
product_line: Pokémon Fit
product_line_id: pokemon-fit
year: 2019
release_date: 2019-11-15
region: Japan
size: 13cm
dimensions:
  height: 13cm
  width: 10cm
price:
  amount: 1320
  currency: JPY
price_display: ¥1,320
tags:
  - size:small
  - type:standard
  - special:sitting
sculpt_id: SC-002
status: Master
verification: Verified
availability: 4
sources:
  - type: catalog
    tier: S
    url: https://www.pokemoncenter-online.com/...
    accessed: 2024-01-15
    notes: Official Pokemon Center Japan product page
notes: |
  Part of the Pokémon Fit series covering all 890+ Pokémon.
  Same sculpt as Sitting Cuties (JIR-USPC-0001).
search_terms:
  - fit
  - palm size
  - 2019
---