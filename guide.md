---
layout: default
title: Guide
description: How to use the Jirachi Plush Archive, understand verification levels, and contribute to the project.
---

<div class="page-header">
  <h1>Archive Guide</h1>
  <p class="subtitle">Understanding the archive, verification system, and how to contribute</p>
</div>

<nav class="guide-toc">
  <h2>Contents</h2>
  <ul>
    <li><a href="#overview">Overview</a></li>
    <li><a href="#id-system">ID System</a></li>
    <li><a href="#verification">Verification Levels</a></li>
    <li><a href="#availability">Availability Scale</a></li>
    <li><a href="#sources">Source Tiers</a></li>
    <li><a href="#collection">Personal Collection</a></li>
    <li><a href="/research#contribute-to-the-archive">How to Contribute</a></li>
    <li><a href="#faq">FAQ</a></li>
  </ul>
</nav>

---

<section markdown="1" id="overview">
## Overview

The **Jirachi Plush Archive** is a comprehensive, evidence-based catalog documenting every Jirachi Pokémon plush ever manufactured. Our goal is to create the definitive reference for collectors and researchers.

### Key Principles

1. **Evidence-Based**: Every entry requires verifiable sources
2. **Complete**: All plushes—common to ultra-rare—are included
3. **Open**: Anyone can contribute with proper evidence
</section>

---

<section markdown="1" id="id-system">
## ID System

Each plush receives a unique **Archive ID** following this format:

```
JIR-[COMPANY]-[NUMBER]
```

### Examples

| ID | Meaning |
|---|---|
| `JIR-TOMY-0001` | First Tomy plush cataloged |
| `JIR-BAN-0005` | Fifth Banpresto plush |
| `JIR-JPPC-0012` | Twelfth Japanese Pokémon Center plush |
| `JIR-USPC-0003` | Third US Pokémon Center plush |

### Company Codes

(Defined in `_data/companies.yml` — add new companies there as needed.)

| Code | Company |
|---|---|
| `BAN` | Banpresto |
| `BNS` | Bandai Spirits |
| `JPPC` | Pokémon Center Japan |
| `TOMY` | TOMY (includes Takara Tomy, Takara Tomy A.R.T.S) |
| `USPC` | Pokémon Center US |

### Variants

Variants of the same base plush share a parent ID:
- Parent: `JIR-TOMY-0001`
- Re-release: `JIR-TOMY-0001a`
- Color variant: `JIR-TOMY-0001b`
</section>

---

<section markdown="1" id="verification">
## Verification Levels

Every item in the archive has a verification status indicating how confident we are in its documentation.

<div class="verification-grid">
  <div class="verification-item">
    <span class="badge badge-verification badge-verification-verified">Verified</span>
    <h4>Verified</h4>
    <p>Highest confidence. Meets ALL criteria:</p>
    <ul>
      <li>Official source (catalog, press release, retailer listing)</li>
      <li>Clear photos of the physical item</li>
      <li>Visible, legible tush tag</li>
      <li>Multiple independent examples documented</li>
    </ul>
    <p><em>These are in the Master Archive.</em></p>
  </div>
  
  <div class="verification-item">
    <span class="badge badge-verification badge-verification-strong">Strong</span>
    <h4>Strong Confidence</h4>
    <p>High confidence, minor gaps:</p>
    <ul>
      <li>Multiple reliable sources confirm existence</li>
      <li>May be missing: official images, precise dimensions, or catalog scans</li>
      <li>Physical examples exist but tags are unclear</li>
    </ul>
    <p><em>In Research, close to promotion.</em></p>
  </div>
  
  <div class="verification-item">
    <span class="badge badge-verification badge-verification-possible">Possible</span>
    <h4>Possible</h4>
    <p>Existence likely but unconfirmed:</p>
    <ul>
      <li>Single source only</li>
      <li>May be misidentified variant</li>
      <li>Could be bootleg or custom</li>
      <li>Requires corroboration</li>
    </ul>
    <p><em>In Research, needs investigation.</em></p>
  </div>
</div>

### Promotion Path

```
Possible → Strong → Verified
   ↓         ↓         ↓
Research  Research  Master Archive
```

An item moves to the Master Archive when it achieves **Verified** status.
</section>

---

<section markdown="1" id="availability">
## Availability Scale

We rate each plush's current market availability on a 1-5 scale:

<div class="availability-guide">
  <div class="availability-item">
    <span class="rarity-meter">
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot"></span>
      <span class="rarity-dot"></span>
      <span class="rarity-dot"></span>
      <span class="rarity-dot"></span>
    </span>
    <strong>Level 1: Common</strong>
    <p>Easily found at retail or secondary market. Current production or abundant supply.</p>
  </div>
  
  <div class="availability-item">
    <span class="rarity-meter">
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot"></span>
      <span class="rarity-dot"></span>
      <span class="rarity-dot"></span>
    </span>
    <strong>Level 2: Uncommon</strong>
    <p>Regularly appears on auction sites. May require patience to find at good price.</p>
  </div>
  
  <div class="availability-item">
    <span class="rarity-meter">
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot"></span>
      <span class="rarity-dot"></span>
    </span>
    <strong>Level 3: Scarce</strong>
    <p>Appears occasionally. Limited production run or older release. Moderate collector demand.</p>
  </div>
  
  <div class="availability-item">
    <span class="rarity-meter">
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot"></span>
    </span>
    <strong>Level 4: Rare</strong>
    <p>Seldom appears. Event exclusives, old releases, or very limited production.</p>
  </div>
  
  <div class="availability-item">
    <span class="rarity-meter">
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
      <span class="rarity-dot filled"></span>
    </span>
    <strong>Level 5: Ultra-Rare</strong>
    <p>Extremely difficult to find. May appear once a year or less. High collector value.</p>
  </div>
</div>

*Note: Availability is subjective and changes over time. We update ratings based on market observations.*
</section>

---

<section markdown="1" id="sources">
## Source Tiers

We evaluate sources by reliability tier:

| Tier | Type | Reliability |
|---|---|---|
| **S** | Official manufacturer catalog, press release, or product page | Highest—direct confirmation |
| **A** | Physical item with clear, legible tags | Strong—verifiable details |
| **B** | Major retailer listing, archived web pages (Wayback Machine) | Good—requires corroboration |
| **C** | Social media posts, forum threads, auction listings | Helpful but needs verification |

### Citing Sources

Every claim should cite evidence. Our entries include:
- **Primary Source**: Most authoritative evidence
- **Additional Sources**: Corroborating evidence
- **Archive URLs**: Wayback Machine links for web sources
- **Access Dates**: When sources were last verified
</section>

---

<section markdown="1" id="collection">
## Personal Collection

The archive includes personal collection tracking, stored locally in your browser.

### Collection States

- **Owned**: You have this plush in your collection
- **Wanted**: You're looking for this plush
- **For Trade**: You have this and would consider trading

### Features

- **Track your collection** directly on plush cards and detail pages
- **Export your data** as JSON or CSV for backup
- **Import data** to restore or transfer your collection
- **Stats page** shows your completion progress

### Privacy

All collection data is stored in your browser's localStorage. We do not collect or transmit your collection information.
</section>

---

<section markdown="1" id="contributing">
## How to Contribute

We welcome contributions from the collector community!

### Ways to Help

1. **Submit Evidence** for existing Research items
2. **Report New Finds** we haven't documented
3. **Provide Corrections** to existing entries
4. **Share Photos** especially tush tags and hang tags

### What We Need

For a new entry or promotion to Verified:

| Required | Helpful |
|---|---|
| Clear front photo | Multiple angles |
| Tush tag photo | Hang tag photo |
| Manufacturer name | Exact dimensions |
| Approximate date | Original price |
| Source citation | Context/provenance |

### Submission Process

1. Go to the [Research page](/research#contribute-to-the-archive)
2. Fill out the contribution form
3. Generate a structured submission
4. Submit via:
   - **GitHub Issue** (preferred for tracking)
   - **Discord** @kardashi

### Photo Guidelines

- **Lighting**: Natural light preferred, avoid harsh flash
- **Focus**: Tush tag text must be legible
- **Background**: Neutral, uncluttered
- **Size Reference**: Include ruler or common object for scale
- **Multiple Angles**: Front, side, back, and tag close-ups
</section>

---

<section markdown="1" id="faq">
## Frequently Asked Questions

### Is this an official Pokémon project?

No. This is a fan-made documentation project. We are not affiliated with The Pokémon Company, Nintendo, or any manufacturers.

### Can I use these images?

Images are sourced from various places with attribution. Please respect original photographers' rights. Our own documentation photos may be used with credit.

### Why isn't my plush listed?

Either we haven't documented it yet, or it may be a bootleg/custom. Check the Research page or submit it for review.

### How do I know if my plush is authentic?

Look for official tush tags with manufacturer info, proper licensing text, and consistent construction. When in doubt, compare to verified entries or reach out for help on the PokePlush subreddit/discord server.

### Do you buy/sell/trade plushes?

No. We are a documentation project only. We don't facilitate transactions.

### How can I contact the maintainers?

Open a GitHub issue or use the contribution form on the Research page.
</section>

<style>
.guide-toc {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius);
  padding: var(--sp-4);
  margin-bottom: var(--sp-6);
}

.guide-toc h2 {
  font-family: var(--font-serif);
  font-size: var(--text-base);
  margin-bottom: var(--sp-2);
}

.guide-toc ul {
  display: flex;
  flex-wrap: wrap;
  gap: var(--sp-2) var(--sp-4);
  list-style: none;
  margin: 0;
  padding: 0;
}

.guide-toc a {
  color: var(--c-accent);
  text-decoration: none;
  font-size: var(--text-sm);
}

.guide-toc a:hover {
  text-decoration: underline;
}

section {
  margin-bottom: var(--sp-8);
}

section h2 {
  font-family: var(--font-serif);
  font-size: var(--text-xl);
  margin-bottom: var(--sp-4);
}

section h3 {
  font-size: var(--text-base);
  margin-top: var(--sp-4);
  margin-bottom: var(--sp-2);
}

section h4 {
  font-size: var(--text-sm);
  margin-bottom: var(--sp-1);
}

section p, section li {
  font-size: var(--text-sm);
  line-height: 1.6;
}

section ul {
  margin-left: var(--sp-4);
  margin-bottom: var(--sp-3);
}

section table {
  width: 100%;
  margin: var(--sp-3) 0;
  border-collapse: collapse;
}

section th, section td {
  padding: var(--sp-2) var(--sp-3);
  text-align: left;
  border: 1px solid var(--c-border);
  font-size: var(--text-sm);
}

section th {
  background: var(--c-surface);
  font-weight: 600;
}

section code {
  font-family: var(--font-mono);
  font-size: var(--text-xs);
  background: var(--c-surface);
  padding: 0.1em 0.3em;
  border-radius: var(--radius-sm);
}

section pre {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius);
  padding: var(--sp-3);
  overflow-x: auto;
  font-size: var(--text-sm);
}

section pre code {
  background: none;
  padding: 0;
}

.verification-grid {
  display: grid;
  gap: var(--sp-4);
}

.verification-item {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius);
  padding: var(--sp-4);
}

.verification-item .badge {
  margin-bottom: var(--sp-2);
}

.verification-item ul {
  margin: var(--sp-2) 0 var(--sp-2) var(--sp-4);
}

.availability-guide {
  display: flex;
  flex-direction: column;
  gap: var(--sp-3);
}

.availability-item {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--sp-2) var(--sp-3);
  padding: var(--sp-3);
  background: var(--c-surface);
  border-radius: var(--radius);
}

.availability-item strong {
  min-width: 140px;
}

.availability-item p {
  flex: 1;
  min-width: 200px;
  margin: 0;
  color: var(--c-text-secondary);
}

hr {
  border: none;
  border-top: 1px solid var(--c-border);
  margin: var(--sp-8) 0;
}
</style>
