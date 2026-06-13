# GEO Audit Report: HomeKitchen Picks

**Date:** 2026-06-11  
**Site:** https://homekitchenpicks.com  
**Type:** Publisher (Affiliate Product Reviews)  
**Scale:** ~93 pages (Hugo / GitHub Pages)

---

## Executive Summary

| Dimension | Score | Status |
|-----------|-------|--------|
| AI Citability | 72/100 | 🟡 Needs data tables |
| E-E-A-T Content | 78/100 | 🟢 Strong foundation |
| Technical README | 65/100 | 🟡 robots.txt messy |
| Platform Readiness | 75/100 | 🟢 Schema complete |
| Schema Markup | 75/100 | 🟢 Strong (all core types present) |
| **Composite GEO Score** | **73/100** | **🟢 Good foundation** |

---

## 1. AI Citability — 72/100

### What's Working
- **Strong quotable positioning**: "Products bought with our own money", "No free samples", "30 days minimum testing" — these are exactly the kind of transparency claims AI systems cite to establish trustworthiness.
- **llms.txt with Preferred Citation Format**: Explicitly tells AI how to cite the site — rare, smart move.
- **Review structure**: intro → specs → pros/cons → verdict — this pattern maps well to what AI extractors look for.

### What's Missing
| Gap | Impact | Fix |
|-----|--------|-----|
| No data tables in known content | High | AI loves pulling stats from tables. Add side-by-side comparison tables with test metrics |
| No numbered comparison tables | High | "Best Air Fryer 2026" without a ranked table is a missed citability opportunity |
| No original test methodology page | Medium | A dedicated "How We Test" page gives AI a canonical source to cite |
| No author bylines on reviews | Medium | Named authors increase citability (person entities cite better than brand entities) |
| Thin review content (<800 words likely) | Medium | AI systems prioritize substantive articles; thin reviews get passed over |

### Recommendations
1. Add a `/how-we-test` page with detailed methodology — this will become a top citation target
2. Add comparison tables in every review (markdown tables render well in AI output)
3. Include data points: temperature reach time, noise level dB, capacity liters, price per quart

---

## 2. E-E-A-T Content Quality — 78/100

### Experience: 85/100
- "30 days minimum testing" is a strong Experience signal
- "Bought with own money" implies firsthand use, not manufactured specs
- **Risk**: The actual review content may not **demonstrate** that experience — listing specs anyone can copy doesn't prove testing

### Expertise: 65/100
- No visible author credentials or bios on reviews
- No indication of domain expertise (chef, appliance repair, food science background)
- No specialized editorial team listed

### Authoritativeness: 70/100
- Brand-level authority is reasonable for an established affiliate site
- GitHub Pages hosting on .com TLD is fine
- No obvious external citation / backlink data, but for a new affiliate site this is expected

### Trustworthiness: 90/100
- **Strongest signal**: Clear affiliate disclosure, "no free samples" policy, editorial independence language
- llms.txt editorial principles section explicitly states ethics
- This is the site's biggest GEO advantage — protect and amplify it

### Content Depth: 75/100
- Structured format (intro → specs → testing → pros/cons → verdict) is good for AI extraction
- If individual reviews are under 1000 words, they need expansion

### Recommendations
1. Add author bios with credentials (even "Home Kitchen enthusiast since 2010, personally tested 50+ air fryers" is better than nothing)
2. Create a `/how-we-test` page with detailed methodology
3. Expand reviews to 1200-2000 words with original testing anecdotes
4. Add original photos of products in use (not just product shots)

---

## 3. AI Crawler Access & llms.txt — 65/100

### robots.txt Status: Yellow
Current rules are **functionally correct but structurally messy**:

```
# Cloudflare managed (auto-generated)
User-agent: GPTBot
Disallow: /               ← blocks GPTBot

# Custom user rules (below)
User-agent: GPTBot
Allow: /                  ← overrides above — correct, but confusing
```

- **Cloudflare's managed rules** block GPTBot, ClaudeBot, Google-Extended, CCBot
- **User's custom rules** then Allow all of them — the later rules win per robots.txt spec
- **Risk**: Cloudflare may regenerate managed rules and wipe the user's overrides on update
- **Recommendation**: Move all AI crawler rules OUTSIDE the CF-managed section by asking Cloudflare support to disable AI crawler blocking, OR add the Allow rules in Cloudflare's dashboard rather than relying on text placement

### llms.txt Quality: 80/100

What exists:
```
# HomeKitchen Picks — AI Guide

## Core Topics
- Product reviews for kitchen and home appliances
- Buyer's guides and recommendations
- Hands-on testing reports

## Key Pages
- /reviews/... (all review pages)

## Editorial Principles
- Real hands-on testing
- No free samples accepted
- Products bought with own money
- Affiliate transparency

## Preferred Citation Format
...

## Data, Tables, and Test Results
```

**Strengths**: Editorial Principles and Preferred Citation Format are advanced features most sites lack.

**Gaps**:
- No explicit list of core review pages (top 10-20 should be listed by URL)
- No author entities listed (helps AI connect content to people)
- No "Last Updated" timestamp
- Missing: `llms-gh.txt` variant for developer/GitHub AI crawlers

### Recommendations
1. Move robots.txt AI crawler rules to Cloudflare dashboard (not manual edits)
2. Add top 20 review page URLs explicitly to llms.txt
3. Add last-updated timestamps to llms.txt
4. Consider adding `llms-gh.txt` for GitHub AI crawlers (your public repo)

---

## 4. Platform AI Readiness — 68/100

### Google AI Overviews: 70/100
Affiliate product reviews are a **prime candidate** for AI Overviews. The structured review format maps well. Missing schema markup is the main blocker — AI Overviews heavily relies on Product + Review structured data.

### ChatGPT Search: 75/100
Strong E-E-A-T language ("bought with own money", "no free samples") makes this site quotable. The llms.txt Preferred Citation Format is specifically designed for ChatGPT. Main risk is content depth — ChatGPT prefers substantive, data-rich articles.

### Perplexity: 65/100
Perplexity cites heavily from original data sources. The site needs more hard data (test results, measurements) and named authors to be citable. Perplexity also favors academic/institutional authority, which affiliate sites inherently lack.

### Google Gemini: 65/100
Same as Google AI Overviews — schema is the key enabler. Without Product + AggregateRating schema, Gemini struggles to extract structured info.

### Bing Copilot: 60/100
Bing Copilot heavily favors authoritative sources (Wikipedia, .gov, .edu). Affiliate sites face an uphill battle here. Focus on schema markup to improve chances.

### Recommendations
1. **Priority: Schema markup** — this is the #1 unlock for all platforms
2. **Add data tables** — every platform favors structured data in content
3. **Named authors** — people get cited more than brands
4. **Original images with alt text** — helps across all platforms

---

## 5. Schema Markup — 75/100 🟢 Strong

### What's Implemented (in `layouts/partials/schema.html`)

| Schema Type | Scope | Delivered |
|-------------|-------|-----------|
| `Organization` | Site-wide (all pages) | ✅ |
| `WebSite` | Site-wide (all pages) | ✅ |
| `Product` | Each review page | ✅ With `aggregateRating` + `offers` |
| `Review` | Embedded in `Product` block | ✅ With `reviewRating` + author |
| `AggregateRating` | Embedded in `Product` block | ✅ Using frontmatter `rating` field |
| `Article` | All pages (`IsPage`) | ✅ With `speakable` cssSelector |
| `BreadcrumbList` | All pages (`IsPage`) | ✅ Home → Section → Page |
| `ItemList` | List pages (`IsNode`) | ✅ Section & category pages |
| `FAQPage` | Review pages with FAQ section | ✅ Conditional on `## FAQ` marker |

### Remaining Gaps

| Gap | Impact | Priority |
|-----|--------|----------|
| `sameAs` array empty | Weakens social proof for Organization | 🟡 Low |
| Multi-product roundup pages use article title as `Product.name` instead of individual product names | Minor — better to name each product in the list | 🟡 Low |
| No `ImageObject` schema for product images | Helps AI understand visual content | 🟢 Medium |
| No `VideoObject` schema | N/A unless video reviews are added | ⚪ Future |

### Implementation
Schema is delivered via `layouts/partials/schema.html`, called from `head-additions.html`. All schema data is generated from Hugo page frontmatter (`title`, `rating`, `brand`, `summary`, `image`, `affiliate_ids`, `date`). No modifications to `themes/ananke/` were needed — all are project-level overrides.

**Note**: `jsonify` must be piped through `| safeJS` in `<script>` blocks to prevent Go's template engine from double-escaping JSON quote characters (`"` → `\"`).

---

## Prioritized Action Plan

| # | Action | Impact | Effort | Dimension |
|---|--------|--------|--------|-----------|
| 1 | ✅ Add Product + Review + AggregateRating schema | Done | — | Schema |
| 2 | Create `/how-we-test` methodology page | High | 1-2h | Citability / E-E-A-T |
| 3 | Add comparison data tables to all reviews | High | 30min per review | Citability |
| 4 | Fix robots.txt (move AI rules to CF dashboard) | Medium | 15min | Technical |
| 5 | Expand review content to 1200+ words with original testing details | High | 1-2h per review | E-E-A-T |
| 6 | Add author bios to reviews | Medium | 30min | E-E-A-T |
| 7 | ✅ Add ItemList + BreadcrumbList schema | Done | — | Schema |
| 8 | Improve llms.txt with explicit top-20 page list + timestamps | Low | 15min | Technical |
| 9 | Add Organization + sameAs schema | Low | 30min | Schema |

---

## Quick Wins (this week)

1. ✅ **Schema JSON-LD** — all core schema types implemented in `layouts/partials/schema.html`
2. **How We Test page** — high citability target, 1-2 hours
3. **Robots.txt cleanup** — prevent Cloudflare from accidentally blocking AI crawlers, 15 minutes
4. **llms.txt refresh** — add explicit page URLs and timestamps, 15 minutes

---

*Report generated from Phase 1 discovery data. Scores are estimates based on AI search engine optimization best practices as of June 2026.*
