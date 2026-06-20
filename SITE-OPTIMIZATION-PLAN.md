# Site Optimization Plan — HomeKitchen Picks

**Status:** PRD — Review before implementation  
**Date:** 2026-06-17  
**Target:** Prepare site for ad network qualification (Mediavine-style quality standards)

---

## Guiding Principles

1. **GEO-compatible first** — all changes must maintain or improve AI citability (current GEO score: 73/100)
2. **CLS-zero tolerance** — any ad or dynamic element must use pre-reserved containers
3. **No breakage** — all changes reversible, no modifications to `themes/ananke/`
4. **Phased delivery** — each phase is independently deployable

---

## Current State Summary (Updated 2026-06-20)

| Dimension | Status | Key Gaps |
|-----------|--------|----------|
| Content structure | ✅ Good | Answer summary, TOC, related reviews with rich cards, Read Next module |
| Schema markup | ✅ Strong | Product/Review/Article/BreadcrumbList/FAQ/Person all present |
| Tracking | ✅ GTM + GA4 + RUM | Loaded in head-additions.html, Web Vitals via GTM |
| Design system | ✅ Custom CSS | Phase 1-3 styles: summary box, two-column grid, TOC, related cards, Read Next, ad containers, cookie consent |
| Ads.txt | ⚠️ Placeholder | No publisher ID filled — needs user action |
| Ad containers | ✅ Done | In-content, sidebar, bottom slots in review template |
| CLS protection | ✅ Done | Responsive min-height containers (280px→120px→90px) |
| Lazy loading | ✅ Done | `loading="lazy"` + `decoding="async"` in render-image.html |
| Cookie consent | ✅ Done | GDPR banner with accept/reject/dismiss, gates ad loading |
| Author pages | ✅ Done | 3 authors with bios, credentials, expertise; author list + single templates |
| How We Test page | ✅ Done | 200+ words: methodology, scoring, side-by-side, long-term follow-up, FTC/EEAT compliance |
| related-reviews | ✅ Rich cards | Hugo `.RelatedPages` with keyword fallback, Read Next spotlight |
| robots.txt | ⚠️ Duplicate entries | Allow rules correct but could be cleaner |
| Privacy policy | ✅ Done | Full cookie, affiliate, advertising disclosure with opt-out links |

---

## Phase 1: Foundation (Ad Network Readiness) ✅ DONE

**Goal:** Make the site technically ready for ad network qualification without requiring an active ad account.

**Completed:** 2026-06-20

### 1.1 CLS-Safe Ad Shortcode
- Create `layouts/shortcodes/ad-unit.html`
- Renders a `div.ad-container` with `min-height` (pre-set by viewport breakpoint)
- Outputs: `<!-- Ad placeholder: in-content -->` comment (no actual ad script until account active)
- Height tiers: mobile=280px, tablet=120px, desktop=90px (responsive)

### 1.2 Ad Placement Strategy

| Template | Positions | Notes |
|----------|-----------|-------|
| `review/single.html` | After 3rd paragraph, bottom of content | 2 slots per review page |
| `_default/list.html` | After first 3 listing items | 1 slot per list page |
| `_default/single.html` | Bottom of article (after content, before related-reviews) | 1 slot |

All containers reserved with `min-height` — ads.txt and ad script will be activated in a later step when an ad network account is ready.

### 1.3 Ads.txt (Preparation)
- Replace placeholder with real publisher ID once available
- Add records for: Google AdSense, Mediavine, any future ad partner
- Current placeholder is fine for qualification stage

### 1.4 Privacy Policy Update
- Add section: "Cookies & Advertising"
  - Types of cookies used (preferences, analytics, advertising)
  - Third-party ad partner disclosure
  - Cookie consent mechanism (GDPR/CCPA compliance)
  - Opt-out instructions
- Add link to privacy policy in site footer if not present

### 1.5 Files to Create/Modify

| File | Action | Type |
|------|--------|------|
| `layouts/shortcodes/ad-unit.html` | Create new | New |
| `layouts/review/single.html` | Insert ad shortcode after 3rd `<p>` + bottom | Edit |
| `layouts/_default/list.html` | Insert ad shortcode after 3rd item | Edit |
| `layouts/_default/single.html` | Insert ad shortcode before `related-reviews` | Edit |
| `static/css/custom.css` | Add `.ad-container` rules with `min-height` | Edit |
| `static/ads.txt` | Fill real Pub ID when ready | Edit (user action) |
| `content/privacy-policy.md` | Add ad/cookie section | Edit |

---

## Phase 2: Core Web Vitals (体验分)

**Goal:** Pass Google Core Web Vitals thresholds with ad containers active.

### 2.1 Lazy Loading
- Add `loading="lazy"` to all product images (not hero)
- Keep hero image as `eager` (above fold = immediate LCP candidate)
- Impact: reduces initial page weight, improves LCP

### 2.2 Font-Display
- Custom serif font in `custom.css`: add `font-display: swap` to any `@font-face` blocks
- If using Google Fonts: add `&display=swap` to URL

### 2.3 Ad Container Sizing
```css
.ad-container {
  min-height: 280px;  /* mobile-first */
  width: 100%;
  background: #fafafa;  /* neutral placeholder */
  display: flex;
  align-items: center;
  justify-content: center;
}
@media (min-width: 768px) {
  .ad-container { min-height: 120px; }
}
@media (min-width: 1024px) {
  .ad-container { min-height: 90px; }
}
```
- Prevents CLS when ad network serves dynamic-height creatives
- Background color prevents white flash

### 2.4 RUM (Real User Monitoring)
- Add `web-vitals` library via GTM tag
- Track: LCP, INP (replaces FID), CLS
- Use GA4 events to monitor actual user experience
- Impact: data-driven optimization, required by Mediavine

### 2.5 Files to Modify

| File | Action |
|------|--------|
| `static/css/custom.css` | Add `.ad-container` + `.review-hero-image` lazy loading rule |
| `layouts/partials/head-additions.html` | Add web-vitals script via GTM dataLayer push |
| `layouts/review/single.html` | Add `loading="lazy"` to image if below-fold |

---

## Phase 3: Retention (留存指标) ✅ DEPLOYED

**Goal:** Reduce bounce rate, increase pages-per-session, build readership.

### 3.1 Answer Summary Box ✅
- `.review-summary` at top of `review/single.html` (before content)
- Pulls from `summary` frontmatter field
- Includes rating display when `.Params.rating` is set

### 3.2 Table of Contents ✅
- For reviews > 800 words: auto-generated TOC from `<h2>` headings
- Collapsible `<details>` on mobile, sticky sidebar on desktop (≥60em)
- Controlled by `WordCount` conditional

### 3.3 Upgrade Related Reviews ✅
- Uses Hugo `.Site.RegularPages.Related` with `[related]` indices from `hugo.toml`
- Fallback to keyword-group matching when `.RelatedPages` returns < 2
- Rich cards: image, summary, rating stars

### 3.4 Read Next Module ✅
- Single spotlight card above related grid
- Uses first result from `.RelatedPages`
- Shows image, title, summary, rating

### 3.5 Files Modified

| File | Action |
|------|--------|
| `layouts/review/single.html` | Summary box + conditional TOC + two-column grid layout |
| `layouts/partials/related-reviews.html` | Rewritten: `.RelatedPages` + keyword fallback + Read Next |
| `static/css/custom.css` | Added `.review-summary`, `.review-layout`, `.review-toc`, `.related-card`, `.read-next` styles |
| `hugo.toml` | Added `[related]` indices and `[markup.tableOfContents]` config |

---

## Phase 4: Authority & Backlinks (站点权重)

**Goal:** Build site authority signals for ad network qualification and organic ranking.

### 4.1 How We Test Page
- Content page at `content/how-we-test.md`
- Detailed methodology: testing criteria, duration, scoring rubric
- Photos of testing setup if possible
- High citability target for GEO
- Menu link already exists (weight 8 in `hugo.toml`)

### 4.2 Authors Section
- Create `/authors/` section with individual author pages
- Each page: bio, credentials, list of reviews by that author
- Link from `/authors/` in `Person` schema
- Link from each review byline → author page (already in template)

### 4.3 Social Profiles (sameAs)
- Populate `sameAs` in schema.html
- Add: Amazon author page (if exists), Pinterest (visual discovery for kitchen), YouTube (if video reviews planned)

### 4.4 Backlink Strategy
- Guest posts on cooking/home blogs
- HARO/Connectively for expert quotes
- Broken link building (find dead recipe/kitchen links → offer your review as replacement)

### 4.5 Files to Create/Modify

| File | Action |
|------|--------|
| `content/how-we-test.md` | Create new |
| `content/authors/_index.md` | Create new |
| `content/authors/homekitchen-picks-team.md` | Create new |
| `layouts/partials/schema.html` | Populate `sameAs` array |

---

## Implementation Order

```
Phase 1 ──────────────────────► (Foundation — deployable immediately)
  ├─ 1.1 ad-unit shortcode        ~15min
  ├─ 1.2 Wire into templates      ~20min
  ├─ 1.4 Privacy policy update    ~15min
  └─ 1.3 ads.txt (wait for Pub ID)

Phase 2 ──────────────────────► (CWV — after Phase 1)
  ├─ 2.1 Lazy loading             ~10min
  ├─ 2.2 Font-display             ~5min
  ├─ 2.3 Ad container CSS         ~10min
  └─ 2.4 RUM setup                ~15min

Phase 3 ──────────────────────► (Retention — after Phase 2)
  ├─ 3.1 Answer summary box       ~15min
  ├─ 3.2 Table of Contents        ~20min
  ├─ 3.3 Upgrade related-reviews  ~30min
  └─ 3.4 Read Next module         ~10min

Phase 4 ──────────────────────► (Authority — ongoing)
  ├─ 4.1 How We Test page         ~1-2h
  ├─ 4.2 Authors section          ~30min
  ├─ 4.3 sameAs update            ~10min
  └─ 4.4 Backlink strategy        ongoing
```

---

## Verification Gates

After each phase, verify:
1. `hugo build` exits 0
2. No CLS regression (Lighthouse test on mobile + desktop)
3. All AI crawlers still allowed (robots.txt check)
4. Schema markup validates (Rich Results Test)
5. Review pages render correctly on mobile + desktop viewports

---

## Blockers

| Blocker | Phase | Workaround |
|---------|-------|------------|
| Ad network publisher ID (AdSense/Mediavine) | 1.3 | Use placeholder; site must qualify first |
| Hugo `.Related` function may need config | 3.3 | Can pre-configure in `hugo.toml`, fallback to keyword matching |
| Custom font source unknown | 2.2 | Check `custom.css` for `@font-face` or Google Fonts URL |
