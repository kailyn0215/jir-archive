---
layout: default
title: Guide
---

# Database Guide & Research Standards

**Version:** v0.3 (Pre-v1.0)

---

## Purpose

The Jirachi Plush Archive is intended to become the most comprehensive, evidence-based database of every officially licensed Jirachi plush ever released.

This project is not simply a checklist. It is a historical archive that documents every known official Jirachi plush release, its manufacturer, product line, release information, rarity, and supporting evidence.

The archive prioritizes **accuracy over completeness**. It is acceptable for an item to remain in the Research queue until sufficient evidence exists.

---

## Philosophy

The archive follows one simple rule:

> **If it cannot be supported by evidence, it does not belong in the Master Archive.**

Evidence is more important than assumptions. Whenever new information becomes available, the archive should be updated using the standards below.

---

## Database Structure

### Master Archive

This is the primary database. Every entry represents one official plush release.

- No duplicates
- No bootlegs
- No fan-made customs
- Only officially licensed products belong here

### Research Queue

Contains items that may exist but are not yet sufficiently documented.

An item should remain here until enough evidence exists to promote it to the Master Archive.

Possible reasons include:
- Unknown manufacturer
- Unknown year
- Only one known listing
- Missing official product name
- Missing tag photos

Nothing in Research should be considered confirmed.

---

## Archive IDs

Every plush receives one permanent Archive ID.

```
JIR-0001
JIR-0002
JIR-0003
```

Archive IDs **never change**. Even if new plushes are discovered later, existing IDs remain permanent.

---

## Company IDs

Each manufacturer maintains its own numbering.

| Prefix | Company |
|--------|---------|
| PCJ | Pokemon Center Japan |
| PCUS | Pokemon Center US |
| PCTW | Top Insight Taiwan |
| TOMY | TOMY |
| TTA | Takara Tomy Arts |
| BAN | Banpresto |
| BANDAI | Bandai |
| OTH | Unknown |

These IDs help organize releases by manufacturer. If additional companies are discovered, new prefixes may be added.

---

## Sculpt IDs

Sculpt IDs represent unique physical plush designs. Multiple releases may share one sculpt.

**Example:**
- Pokemon Fit (Japan) → `SC-002`
- Sitting Cuties (North America) → `SC-002`

Both are separate releases. Both use the same sculpt.

This allows the archive to answer two different questions:
1. How many unique plush designs exist?
2. How many official releases exist?

Those numbers are not always the same.

---

## What Counts As A Separate Entry

A new archive entry should be created when:

- Different sculpt
- Different size
- Different product line
- Different manufacturer
- Different region (if officially released as a separate retail product)
- Different promotional release
- Different prize release
- Different seasonal collection

---

## What Does NOT Count

Do NOT create new entries for:

- Different hang tag revisions
- Different tush tag revisions
- Factory changes
- Minor embroidery differences
- Manufacturing defects
- Price stickers
- Barcode stickers
- Packaging revisions

These should instead be documented inside the Notes field.

---

## Verification Standards

Every plush receives one verification level.

### Verified
Official manufacturer documentation exists, OR multiple independent examples with matching tags and metadata exist.

These belong in the Master Archive.

### Strong
High confidence. Likely official. Needs one additional reliable source.

Usually belongs in the Master Archive with a note.

### Possible
Interesting lead. Needs significantly more evidence.

Remains in Research.

### Unverified
Insufficient documentation. Should not enter the Master Archive.

---

## Research Methodology

The archive should never rely solely on search engines.

Instead, research should proceed by manufacturer:

```
Banpresto
    ↓
Every yearly catalog
    ↓
Every Pokemon release
    ↓
Was Jirachi included?
    ↓
Document evidence
```

Repeat for each manufacturer. This approach minimizes missing obscure releases.

---

## Source Reliability

### Tier S (Primary)
- Official manufacturer catalogs
- Official retailer pages
- Official Pokemon Center pages
- Original advertisements

### Tier A
- Archived retailer pages
- Mandarake
- Suruga-ya
- Official scans

### Tier B
- Yahoo Auctions
- Mercari
- Rakuten

### Tier C
- Collector websites
- Blogs
- Reddit
- Flickr

Lower tiers are excellent for discovering items but should not be the sole source used for verification.

---

## Naming Convention

Whenever possible, every plush should contain:

- **Official English Name**
- **Official Japanese Name**
- **Common Collector Name**

Many plushes are better known by unofficial names. Both should be preserved.

---

## Availability Rating

Instead of subjective rarity, the archive tracks availability:

| Rating | Meaning |
|--------|---------|
| ★★★★★ | Frequently available |
| ★★★★☆ | Available with patience |
| ★★★☆☆ | Uncommon |
| ★★☆☆☆ | Difficult to obtain |
| ★☆☆☆☆ | Extremely difficult to find |

Availability is based on observed market frequency, not opinion.

---

## Research Rules

1. Never assume
2. Never estimate
3. Never merge two plushes without evidence
4. Never split one plush into multiple entries without evidence
5. When uncertain, place the item in Research instead of Master

---

## Long-Term Goal

The objective is to create a permanent historical record of every officially licensed Jirachi plush.

Every release should eventually include:
- Official name
- Japanese name
- Manufacturer
- Release year
- Product line
- Region
- Size
- Product number
- JAN code
- Original MSRP
- Images
- Search terms
- Verification sources
- Collector notes

The archive should be accurate enough that another collector can independently verify every entry using the included evidence.

If future official releases occur, they should be added without changing any existing Archive IDs.

The archive should remain **stable, expandable, and evidence-based** for many years to come.

---

## Adding New Entries

To add a new plush, create a new file in `_plushes/`:

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

Optional extended notes in markdown format.
```

Save as `JIR-0036.md` and commit to the repository.