# How to Run Gemini Code Reviews

## Setup Complete! ✅

Your workspace is at: **`~/gemini-code-reviews/`**

```bash
cd ~/gemini-code-reviews/
# or open in file browser
nautilus ~/gemini-code-reviews/
```

---

## Quick Start

### For a Single Project:

```bash
# Run the helper script
~/gemini-code-reviews/run-single-review.sh defi beam

# This will:
# 1. Create a prompt file at /tmp/prompt_beam.txt
# 2. Tell you the command to run
# 3. Save output to ~/gemini-code-reviews/repos/defi/beam/beam-Gemini-Code-Review.md
```

### Manual Gemini Run:

```bash
# Go to the project directory
cd ~/gemini-code-reviews/repos/defi/beam

# Run Gemini with the template
gemini --prompt-file /tmp/prompt_beam.txt > beam-Gemini-Code-Review.md

# Or if using a different Gemini setup:
# <your-gemini-command> < /tmp/prompt_beam.txt > beam-Gemini-Code-Review.md
```

---

## Available Projects (11 cloned so far)

### DeFi (10 projects):
- ✅ **0xbow** - Done (Claude review in Ethereum-Cypherpunk-Research repo)
- ✅ **alephim** - Done (Claude review in Ethereum-Cypherpunk-Research repo)
- ⏳ **beam** - Ready for Gemini
- ⏳ **hopr** - Ready for Gemini
- ⏳ **iexec** - Ready for Gemini
- ⏳ **mask** - Ready for Gemini
- ⏳ **penumbra** - Ready for Gemini
- ⏳ **privatepool** - Ready for Gemini
- ⏳ **starkex** - Ready for Gemini
- ⏳ **zcash** - Ready for Gemini

### Identity (4 projects):
- ✅ **circom** - Done (Gemini test - excellent quality!)
- ⏳ **dark-forest** - Ready for Gemini
- ⏳ **elusiv** - Ready for Gemini
- ⏳ **iron-fish** - Ready for Gemini

**Status**: 11 of 11 cloned projects ready for Gemini review
**Completed**: 3 reviews (2 Claude, 1 Gemini test)
**Remaining**: 8 projects need Gemini reviews

---

## Batch Processing (All 8 Remaining Projects)

### Option 1: One at a time (Recommended for testing)

```bash
# Test with one project first
~/gemini-code-reviews/run-single-review.sh defi beam
cd ~/gemini-code-reviews/repos/defi/beam
# <run your gemini command>

# If quality looks good, continue with others...
~/gemini-code-reviews/run-single-review.sh defi hopr
~/gemini-code-reviews/run-single-review.sh defi iexec
# ...etc
```

### Option 2: Loop through all (After testing quality)

```bash
# DeFi projects
for project in beam hopr iexec mask penumbra privatepool starkex zcash; do
  echo "=== Processing $project ==="
  cd ~/gemini-code-reviews/repos/defi/$project
  gemini --prompt-file /tmp/prompt_${project}.txt > ${project}-Gemini-Code-Review.md
  echo "✅ Completed: $project"
done

# Identity projects
for project in dark-forest elusiv iron-fish; do
  echo "=== Processing $project ==="
  cd ~/gemini-code-reviews/repos/identity/$project
  gemini --prompt-file /tmp/prompt_${project}.txt > ${project}-Gemini-Code-Review.md
  echo "✅ Completed: $project"
done
```

---

## Files & Templates

### Code Review Template
**Location**: `~/code_review_template_for_local_llm.md`

This template ensures:
- ✅ No quality scores or percentages
- ✅ Factual observations only
- ✅ Constitutional compliance v2.0.0
- ✅ Follows the same pattern as circom review (418 lines, excellent quality)

### Example Circom Review
**Location**: `~/gemini-code-reviews/repos/identity/circom/circom-Gemini-Code-Review.md`

This is the **gold standard** - 418 lines of excellent, factual code review:
- ✅ Accurate metrics (41,626 LOC, 144 files)
- ✅ Specific file references
- ✅ Critical analysis (identified testing deficiency)
- ✅ No quality scores
- ✅ Professional tone

**Use this as reference for what quality to expect from Gemini!**

---

## Quality Checklist

After each Gemini review, verify:

1. **✅ No Quality Scores**: No "8.5/10", percentages, or confidence metrics
2. **✅ File References**: Specific files mentioned (e.g., "src/main.rs:127")
3. **✅ Factual Only**: Observations based on actual code, not generic advice
4. **✅ Comprehensive**: All sections covered (Architecture, Security, Privacy, Testing, Dependencies)
5. **✅ Length**: Should be 400-600 lines (similar to circom)
6. **✅ Clean Output**: No garbled text or control codes

**If quality drops below standard**: Switch to Claude for that specific project.

---

## Cost Estimate

### Gemini Pricing (2.0 Flash):
- **Per Project**: ~$0.10-0.15
- **8 Remaining Projects**: $0.80 - $1.20
- **Total including circom test**: ~$1.00 - $1.50

### Comparison:
- **Claude**: Would cost $4.80 - $7.20 for 8 projects
- **Gemini Savings**: 75-85% cheaper!

---

## Next Steps

1. **Test one project**:
   ```bash
   ~/gemini-code-reviews/run-single-review.sh defi beam
   cd ~/gemini-code-reviews/repos/defi/beam
   # Run your Gemini command
   ```

2. **Check quality**: Compare beam review to circom review

3. **If good, continue**: Run Gemini on remaining 7 projects

4. **Copy reviews to main repo**:
   ```bash
   # After all reviews complete:
   cp ~/gemini-code-reviews/repos/defi/*/`*-Gemini-Code-Review.md ~/Ethereum-Cypherpunk-Research/defi/
   cp ~/gemini-code-reviews/repos/identity/*/*-Gemini-Code-Review.md ~/Ethereum-Cypherpunk-Research/identity/
   ```

5. **Commit to git**:
   ```bash
   cd ~/Ethereum-Cypherpunk-Research
   git add */*/reports/*review.md
   git commit -m "Add Gemini code reviews for 8 projects"
   git push
   ```

---

## Troubleshooting

### Can't find /tmp/code_reviews in file browser?
- Use `~/gemini-code-reviews/repos/` instead (it's a symlink to /tmp/code_reviews)
- Your file browser should show it now!

### Gemini output has control codes?
- This happened with Ollama, not Gemini
- Circom review was clean - expect same quality

### Review quality lower than expected?
- Compare to circom reference review
- If significantly worse, use Claude fallback for that project
- Cost difference: $0.15 (Gemini) vs $0.60 (Claude)

---

## Summary

**What's Ready**:
- ✅ 11 repos cloned to `~/gemini-code-reviews/repos/`
- ✅ Code review template at `~/code_review_template_for_local_llm.md`
- ✅ Helper scripts created
- ✅ Reference review (circom) shows excellent Gemini quality

**What You Need to Do**:
1. Run Gemini on each project (starting with beam)
2. Save output as `{project}-Gemini-Code-Review.md` in each repo folder
3. Copy completed reviews to main Ethereum-Cypherpunk-Research repo
4. Commit and push to GitHub

**Expected Results**:
- 8 comprehensive code reviews (400-600 lines each)
- Total cost: ~$1.00 - $1.50
- Time: 30-60 minutes for all 8
- Quality: Production-ready (as proven by circom review)

---

**Need Help?** Check the comparison document at:
`~/web3privacy-research/docs/LLM_CODE_REVIEW_COMPARISON.md`
