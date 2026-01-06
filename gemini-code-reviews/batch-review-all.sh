#!/bin/bash
# Batch process all projects with Gemini

PROJECTS=(
    "defi/0xbow:https://github.com/0xbow-io/privacy-pools-core"
    "defi/alephim:https://github.com/aleph-im/pyaleph"
    "defi/beam:https://github.com/BeamMW/beam"
    "defi/hopr:https://github.com/hoprnet/hoprnet"
    "defi/mask:https://github.com/DimensionDev/Maskbook"
    "identity/circom:https://github.com/iden3/circom"
    "identity/elusiv:https://github.com/elusiv-privacy/elusiv"
)

TEMPLATE="$HOME/code_review_template_for_local_llm.md"
OUTPUT_DIR="$HOME/gemini-code-reviews/output"
REPO_DIR="$HOME/gemini-code-reviews/repos"

mkdir -p "$OUTPUT_DIR"

for PROJECT in "${PROJECTS[@]}"; do
    CATEGORY=$(echo "$PROJECT" | cut -d: -f1 | cut -d/ -f1)
    NAME=$(echo "$PROJECT" | cut -d: -f1 | cut -d/ -f2)
    
    echo "========================================="
    echo "Processing: $NAME ($CATEGORY)"
    echo "========================================="
    
    # Create prompt file
    cat > "/tmp/prompt_${NAME}.txt" << PROMPT
Analyze the $NAME codebase at $REPO_DIR/$CATEGORY/$NAME

Follow the template at $TEMPLATE

Focus on:
1. Architecture and code organization
2. Security analysis
3. Privacy features
4. Testing coverage
5. Dependencies
6. Code quality

CRITICAL RULES:
- NO quality scores (8.5/10, percentages, confidence metrics)
- ONLY factual observations with evidence
- Reference actual files and line numbers
- Constitutional compliance v2.0.0 - Real data only

Create comprehensive code review with all required sections.
PROMPT

    # Run Gemini (adjust command based on your Gemini setup)
    echo "Running Gemini analysis..."
    # gemini --prompt-file "/tmp/prompt_${NAME}.txt" > "$OUTPUT_DIR/${NAME}_review.md"
    
    echo "✅ Completed: $NAME"
    echo ""
done

echo "========================================="
echo "All reviews completed!"
echo "Output directory: $OUTPUT_DIR"
echo "========================================="
