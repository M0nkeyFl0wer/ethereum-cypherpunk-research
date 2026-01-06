# Gemini Code Review Instructions

## How to Use This Directory

1. **Navigate to any project folder**:
   ```bash
   cd ~/gemini-code-reviews/repos/defi/beam
   # or
   cd ~/gemini-code-reviews/repos/identity/elusiv
   ```

2. **Start Gemini** in that directory:
   ```bash
   gemini
   ```

3. **Give Gemini this prompt**:
   ```
   Analyze this codebase following the CODE_REVIEW_TEMPLATE.md in the parent directory (../../CODE_REVIEW_TEMPLATE.md).
   
   CRITICAL RULES from template:
   - NO quality scores (8.5/10, percentages, confidence metrics)
   - ONLY factual observations with evidence
   - Reference actual files and line numbers
   - Base ALL findings on real code inspection
   - Follow the structure in CODE_REVIEW_TEMPLATE.md
   
   Produce a comprehensive code review (400-600 lines) covering:
   1. Codebase Overview
   2. Architecture Analysis
   3. Security Assessment
   4. Privacy Features
   5. Testing Coverage
   6. Dependencies & Supply Chain
   7. Code Quality
   8. Documentation
   9. Critical Issues
   10. Recommendations
   
   Save output as {project-name}-Gemini-Code-Review.md
   ```

## Reference Quality Standard

See the **circom** review as the gold standard:
```bash
cat ~/gemini-code-reviews/repos/identity/circom/circom-Gemini-Code-Review.md
```

**Quality markers**:
- 418 lines of factual analysis
- Specific file references (e.g., "src/execute.rs:4154")
- Accurate metrics (41,626 LOC verified)
- No quality scores
- Critical analysis (identified testing deficiency: 5 test files for 144 source files)

## Projects Ready for Review

**DeFi (8 remaining)**:
- beam, hopr, iexec, mask, penumbra, privatepool, starkex, zcash

**Identity (3 remaining)**:
- dark-forest, elusiv, iron-fish

## File Structure

```
~/gemini-code-reviews/
├── CODE_REVIEW_TEMPLATE.md      # Template to follow
├── INSTRUCTIONS.md               # This file
├── HOW_TO_RUN_GEMINI_REVIEWS.md # Detailed guide
└── repos/                        # Symlink to /tmp/code_reviews
    ├── defi/
    │   ├── beam/                 # Start here!
    │   ├── hopr/
    │   └── ...
    └── identity/
        ├── circom/               # Reference review ✅
        ├── dark-forest/
        └── ...
```

## Cost Estimate

- **Per project**: ~$0.10-0.15 (Gemini 2.0 Flash)
- **8 remaining**: ~$0.80-1.20 total
- **90% cheaper** than Claude Sonnet

## After Completing Reviews

Copy to main repository:
```bash
cd ~/gemini-code-reviews/repos/defi/beam
cp beam-Gemini-Code-Review.md ~/Ethereum-Cypherpunk-Research/defi/beam/reports/code_review.md
```

Then commit to git from the main repository.
