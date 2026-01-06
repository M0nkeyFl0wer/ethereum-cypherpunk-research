# Gemini Code Review Workspace

This directory contains everything needed to run Gemini code reviews on Web3 privacy projects.

## Quick Start

1. **Open any project directory** in your file browser or terminal:
   ```bash
   cd ~/gemini-code-reviews/repos/defi/beam
   ```

2. **Start Gemini** from that directory:
   ```bash
   gemini
   ```

3. **Tell Gemini**: "Review this codebase following the CODE_REVIEW_TEMPLATE.md in ../../CODE_REVIEW_TEMPLATE.md"

## Files in This Directory

- **[CODE_REVIEW_TEMPLATE.md](CODE_REVIEW_TEMPLATE.md)** - Template showing the exact format and structure to follow
- **[INSTRUCTIONS.md](INSTRUCTIONS.md)** - Detailed step-by-step instructions for running reviews
- **[HOW_TO_RUN_GEMINI_REVIEWS.md](HOW_TO_RUN_GEMINI_REVIEWS.md)** - Complete guide with examples and cost estimates
- **repos/** - Symlink to `/tmp/code_reviews` containing all cloned repositories

## Reference Quality Standard

The **circom** review is the gold standard (418 lines, excellent quality):
```bash
cat repos/identity/circom/circom-Gemini-Code-Review.md
```

## Projects Ready (11 total)

**Already Reviewed (3)**:
- ✅ 0xbow (Claude)
- ✅ alephim (Claude)
- ✅ circom (Gemini test)

**Need Reviews (8)**:
- ⏳ beam, hopr, iexec, mask, penumbra, privatepool, starkex, zcash (DeFi)
- ⏳ dark-forest, elusiv, iron-fish (Identity)

## Cost: ~$1.00-1.50 for all 8 remaining projects
