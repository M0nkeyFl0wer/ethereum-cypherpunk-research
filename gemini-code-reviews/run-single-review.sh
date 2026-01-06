#!/bin/bash
# Run Gemini review on a single project

if [ $# -lt 2 ]; then
    echo "Usage: $0 <category> <project-name>"
    echo "Example: $0 defi beam"
    echo ""
    echo "Available projects:"
    echo "  defi: beam, hopr, iexec, mask, penumbra, privatepool, starkex, zcash"
    echo "  identity: dark-forest, elusiv, iron-fish"
    exit 1
fi

CATEGORY=$1
PROJECT=$2
REPO_PATH="$HOME/gemini-code-reviews/repos/$CATEGORY/$PROJECT"
OUTPUT_DIR="$HOME/gemini-code-reviews/output"
TEMPLATE="$HOME/code_review_template_for_local_llm.md"

mkdir -p "$OUTPUT_DIR"

if [ ! -d "$REPO_PATH" ]; then
    echo "❌ Error: Repository not found at $REPO_PATH"
    exit 1
fi

echo "========================================="
echo "Project: $PROJECT ($CATEGORY)"
echo "Repository: $REPO_PATH"
echo "Template: $TEMPLATE"
echo "========================================="

# Save review in the repo directory (so you can access it easily)
OUTPUT_FILE="$REPO_PATH/${PROJECT}-Gemini-Code-Review.md"

cat > "/tmp/prompt_${PROJECT}.txt" << PROMPT
Analyze the $PROJECT codebase at $REPO_PATH

Follow the code review template at $TEMPLATE

**Repository**: Find the GitHub URL in README.md or .git/config
**Project**: $PROJECT
**Analysis Date**: $(date +%Y-%m-%d)
**Constitutional Compliance**: v2.0.0 - Real data only

CRITICAL RULES:
1. NO quality scores (8.5/10, percentages, confidence metrics)
2. ONLY factual observations with evidence
3. Reference actual files and line numbers
4. Base ALL findings on real code inspection

Create a comprehensive code review with these sections:
1. Executive Summary
2. Architecture Assessment
3. Security Analysis
4. Privacy Features (if applicable)
5. Code Quality
6. Testing Infrastructure
7. Dependencies
8. Findings Summary
9. Recommendations

Focus on factual observations from actual code.
PROMPT

echo ""
echo "Prompt saved to: /tmp/prompt_${PROJECT}.txt"
echo "Output will be saved to: $OUTPUT_FILE"
echo ""
echo "To run Gemini:"
echo "  cd $REPO_PATH"
echo "  gemini --prompt-file /tmp/prompt_${PROJECT}.txt > ${PROJECT}-Gemini-Code-Review.md"
echo ""
echo "Or run your Gemini command here manually..."
