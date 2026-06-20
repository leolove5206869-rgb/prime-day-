# Fix Speakable Schema CSS Selectors

## TL;DR
> Fix broken `speakable` CSS selectors in JSON-LD schema so AI search engines can correctly identify summary content on review pages.

---

## Context
The site's JSON-LD schema (`layouts/partials/schema.html`) has a `speakable` property on the Article schema that references non-existent CSS selectors:
- `.article-summary` → should be `.review-summary`
- `#quick-verdict` → should be `.review-summary-text`

These selectors tell AI search engines (Google, ChatGPT, Perplexity, etc.) which parts of the page contain the key summary content suitable for citation and voice. Broken selectors = AI can't find the summary.

## Work Objectives
- Fix the broken selector references in schema.html

## Verification Strategy
- Run `hugo server` and verify the schema JSON-LD output on a review page contains the corrected CSS selectors

---

## TODOs

- [ ] 1. Fix speakable CSS selectors in schema.html

  **What to do**:
  - Open `layouts/partials/schema.html`
  - Line 109: Change `"cssSelector": [".article-summary", "#quick-verdict"]` to `"cssSelector": [".review-summary", ".review-summary-text"]`
  - Save the file

  **Must NOT do**:
  - Don't modify any other part of schema.html
  - Don't edit themes/ananke/

  **Recommended Agent Profile**:
  > `quick` — trivial single-line change
  - **Category**: `quick`
    - Reason: Single file, one-line change, no logic
  - **Skills**: `[]`
    - Reason: No specialized skills needed

  **Parallelization**:
  - **Can Run In Parallel**: NO (single task)
  - **Blocks**: None
  - **Blocked By**: None

  **References**:
  - `layouts/partials/schema.html:109` — The line to change
  - `layouts/review/single.html:33-43` — The actual `.review-summary` element that should be targeted

  **Acceptance Criteria**:
  - [ ] File edit applied to schema.html

  **QA Scenarios**:
  ```
  Scenario: Verify schema contains correct CSS selectors
    Tool: Bash (grep)
    Preconditions: File edited and saved
    Steps:
      1. Run: grep 'cssSelector' layouts/partials/schema.html
      2. Verify output shows: "cssSelector": [".review-summary", ".review-summary-text"]
    Expected Result: Correct CSS selectors reference existing template classes
    Evidence: .omo/evidence/task-1-verify-selectors.txt
  ```

  **Commit**: NO (batch with other GEO fixes later)

---

## Success Criteria
- [ ] `grep 'cssSelector' layouts/partials/schema.html` outputs `.review-summary` and `.review-summary-text`
- [ ] Hugo build passes without errors
