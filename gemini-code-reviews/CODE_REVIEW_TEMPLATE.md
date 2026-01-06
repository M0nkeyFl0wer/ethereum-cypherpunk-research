# Code Review Template for Local LLM

**Use this template with Code Llama or Gemini CLI for token-efficient code reviews**

---

## Instructions for LLM

You are reviewing the codebase at `/tmp/code_reviews/{sector}/{project}/`.

Write a comprehensive code review following this EXACT structure.

**CRITICAL RULES:**
1. NO quality scores (8.5/10, etc.)
2. NO completeness percentages
3. NO confidence scores on the analysis itself
4. ONLY factual, verifiable observations
5. Follow the Aztec code review pattern (see example below)

---

## Output Format

```markdown
# Code Quality Analysis Report: {PROJECT_NAME}

**Repository**: {GITHUB_URL}
**Analysis Date**: {TODAY}
**Analysis Method**: Static code analysis, architectural review, security assessment
**Constitutional Compliance**: v2.0.0 - Real data only, no synthetic generation

---

## Executive Summary

{2-3 paragraph summary of the codebase quality, key findings, and overall assessment}

### Key Findings
- **Files Analyzed**: {NUMBER} source files across {NUMBER} languages
- **Total Lines of Code**: ~{NUMBER} LOC
- **Issues Found**: {NUMBER} TODO/FIXME markers, {NUMBER} large files, etc.
- **Test Coverage**: {NUMBER} test files
- **Technical Debt Estimate**: {LOW/MEDIUM/HIGH with explanation}

### Repository Structure
{Describe the organization - monorepo, packages, directory structure}

---

## 1. Architecture Assessment

**Strengths**:
- {List architectural strengths with evidence}
- {Example: "Excellent monorepo organization with clear separation of concerns"}
- {Example: "Clean interfaces between components"}

**Structure**:
```
project/
├── src/             # {Description}
├── tests/           # {Description}
├── contracts/       # {Description if applicable}
└── docs/            # {Description}
```

**Areas for Improvement**:
- {List specific issues}
- {Example: "Some large files exceed recommended limits"}

---

## 2. Code Quality Metrics

#### Lines of Code by Language
| Language | Files | Lines of Code | Purpose |
|----------|-------|---------------|---------|
| {LANG} | {NUM} | ~{NUM} | {PURPOSE} |
| {LANG} | {NUM} | ~{NUM} | {PURPOSE} |
| **Total** | **{NUM}** | **~{NUM}** | |

#### Complexity Analysis

**Largest Files** (potential complexity hotspots):
- `{filename}`: {NUM} LOC {✅/❌} {Reason}
- `{filename}`: {NUM} LOC {✅/❌} {Reason}

**Code Smell Detection**:
- {✅/⚠️/❌} {Observation}
- {Example: "✅ No obvious god objects detected"}
- {Example: "⚠️ 614 TODO/FIXME/XXX comments"}

#### Technical Debt Markers
```
TODO/FIXME/HACK occurrences: {NUMBER}
```
{Interpretation of what this means}

---

## 3. Testing & Quality Assurance

#### Test Coverage
- **{Language} Tests**: {NUMBER} files
- **{Language} Tests**: {NUMBER} files
- **Total Test Files**: {NUMBER}

**Test-to-Code Ratio**: Approximately {RATIO} ({ASSESSMENT})

#### Testing Infrastructure
- {✅/❌} {Test framework used}
- {✅/❌} {Test types: unit, integration, e2e}
- {✅/❌} {Code coverage tools}

**Test Quality Indicators**:
- {Observations about test quality}

---

## 4. Security Assessment

**Security Infrastructure**:

**Vulnerability Tracking**:
- {✅/❌} Documented security issues
- {✅/❌} Bug bounty program
- {✅/❌} Security audit reports

**Security Mechanisms**:
1. **{Mechanism Name}**: {Description}
2. **{Mechanism Name}**: {Description}

**Smart Contract Security** (if applicable):
- {✅/❌} OpenZeppelin patterns
- {✅/❌} Access control
- {✅/❌} Reentrancy guards
- {✅/❌} Gas optimization

**Cryptography Security** (if applicable):
- {✅/❌} Proper use of crypto primitives
- {✅/❌} Key management
- {✅/❌} Side-channel protections

**Historical Security Issues** (if documented):
- {List resolved issues with IDs}

**CVE & Vulnerability Assessment**:
{Search for CVEs, document any found}

---

## 5. Privacy & ZK Proof Mechanisms

**Privacy Infrastructure**:

**Proof Systems** (if applicable):
- {✅/❌} {Proof system type}
- {✅/❌} {Implementation details}

**Privacy Mechanisms**:
1. **{Mechanism}**: {Description}
2. **{Mechanism}**: {Description}

**Cryptographic Primitives**:
- {List primitives used: ZK-SNARKs, Pedersen hash, etc.}

---

## 6. Dependencies & Third-Party Analysis

#### Dependency Management

**Lock Files**:
- {NUMBER} dependency lock files ({types})

**Key Dependencies** (sampled):
- {✅/⚠️/❌} `{package}` ({version}): {Purpose}
- {✅/⚠️/❌} `{package}` ({version}): {Purpose}

**Security Concerns**:
- {❌/⚠️/✅} Automated dependency scanning
- {❌/⚠️/✅} Dependency update process

**Recommendations**:
1. {Specific recommendation}
2. {Specific recommendation}

---

## 7. Documentation Quality

#### Documentation Coverage

**Documentation Files**: {NUMBER} Markdown files

**Comprehensive Documentation**:
- {✅/❌} README.md present ({SIZE})
- {✅/❌} CONTRIBUTING.md
- {✅/❌} Technical documentation
- {✅/❌} API documentation
- {✅/❌} Security documentation

**Areas for Improvement**:
- {❌} {Missing documentation}
- {⚠️} {Incomplete documentation}

---

## 8. Code Smells & Anti-Patterns

### Identified Issues

#### ⚠️ {Issue Category}
{Detailed description with examples}

**Recommendation**: {What should be done}

#### ✅ Positive Patterns Detected

**Clean Architecture**:
- {Pattern observed}
- {Pattern observed}

**SOLID Principles**:
- {Principle}: {How it's applied}
- {Principle}: {How it's applied}

**Best Practices**:
- {✅} {Practice}
- {✅} {Practice}

#### ❌ Missing Patterns

**{Category}**:
- {Missing pattern with recommendation}

---

## 9. Performance & Optimization

**Optimization Strategies**:

1. **{Strategy}**: {Description}
2. **{Strategy}**: {Description}

**Benchmarking Infrastructure**:
- {Presence of benchmarks}
- {Performance tracking}

---

## 10. Refactoring Opportunities

### High Priority

1. **{Opportunity}** (Effort: {LOW/MEDIUM/HIGH}, Impact: {LOW/MEDIUM/HIGH})
   - {Description}
   - Benefit: {Explanation}

### Medium Priority

{Continue pattern...}

### Low Priority

{Continue pattern...}

---

## 11. Technical Debt Assessment

### Overall Debt: {LOW/MEDIUM/HIGH}

**Green Flags**:
- {✅} {Positive indicator}
- {✅} {Positive indicator}

**Yellow Flags**:
- {⚠️} {Concern}
- {⚠️} {Concern}

**Red Flags**:
- {❌} {Critical issue OR "None detected"}

**Estimated Remediation**: {HOURS}
- {Task}: {hours}
- {Task}: {hours}

---

## 12. Positive Findings

### Exceptional Practices

1. **{Practice}**:
   - {Description with evidence}

2. **{Practice}**:
   - {Description with evidence}

---

## 13. Critical Issues

### High Severity: {NONE or list}

### Medium Severity

**{Issue Number}. {Title}**
- **Risk**: {Description}
- **Recommendation**: {What to do}
- **Effort**: {Estimate}

### Low Severity

{Continue pattern...}

---

## 14. Recommendations

### Immediate Actions (Next Sprint)

1. {✅} **{Action}** ({TIME ESTIMATE})
   - {Detailed description}
   - {Benefit}

### Short Term (1-2 Months)

{Continue pattern...}

### Long Term (3-6 Months)

{Continue pattern...}

---

## Conclusion

{2-3 paragraph summary of findings}

✅ **{Positive assessment}**
✅ **{Positive assessment}**
✅ **{Positive assessment}**

**Minor Improvements Needed**:
- {Improvement}
- {Improvement}

**Overall Assessment**: This codebase is {ASSESSMENT} and demonstrates {PRACTICES}.

**Recommendation**: **{APPROVED/NEEDS WORK}** for production use {WITH QUALIFICATIONS IF ANY}.

---

## Appendix A: Repository Statistics

```
Repository: {URL}
Clone Date: {DATE}
Commit Analyzed: HEAD (latest)

File Counts:
- Total source files: {NUMBER}
- {Language} files: {NUMBER}
- {Language} files: {NUMBER}
- Markdown files: {NUMBER}

Lines of Code:
- {Language}: {NUMBER}
- {Language}: {NUMBER}
- Total: ~{NUMBER}

Test Files:
- {Type} tests: {NUMBER}
- Total: {NUMBER}

Infrastructure:
- Package files: {NUMBER}
- CI/CD workflows: {NUMBER}
- Docker files: {NUMBER}
- Lock files: {NUMBER}
```

---

**Report Generated**: {DATE} by {TOOL}
**Constitutional Compliance**: ✅ All data sourced from actual repository analysis
**Data Sources**: Repository clone, file analysis, documentation review
```

---

## Example Command for Code Llama

```bash
#!/bin/bash
PROJECT="0xbow"
REPO_PATH="/tmp/code_reviews/defi/$PROJECT"

# Navigate to repo
cd "$REPO_PATH"

# Gather metrics
total_files=$(find . -type f -name "*.ts" -o -name "*.sol" -o -name "*.js" | wc -l)
total_loc=$(find . -type f \( -name "*.ts" -o -name "*.sol" -o -name "*.js" \) -exec wc -l {} + | tail -1 | awk '{print $1}')
test_files=$(find . -path "*/test/*" -o -name "*.test.*" -o -name "*.spec.*" | wc -l)

# Create prompt
cat > /tmp/review_prompt.txt << EOF
You are a senior code reviewer analyzing the $PROJECT repository.

Repository location: $REPO_PATH
Files analyzed: $total_files
Total LOC: $total_loc
Test files: $test_files

Review this codebase following the template at /home/flower/code_review_template_for_local_llm.md

Focus on:
1. Architecture and code organization
2. Security practices
3. Privacy implementation (ZK-SNARKs, cryptography)
4. Testing coverage
5. Dependencies and third-party security
6. Documentation quality
7. Technical debt

DO NOT include quality scores (8.5/10), percentages, or confidence metrics.
Only provide factual, verifiable observations with evidence.

Examine the following key files:
$(ls -R "$REPO_PATH" | grep -E "\.(sol|ts|js|md)$" | head -20)

Generate the code review report now.
EOF

# Run with Code Llama
codellama < /tmp/review_prompt.txt > "/home/flower/Ethereum-Cypherpunk-Research/defi/$PROJECT/reports/code_review.md"
```

---

## Example Command for Gemini CLI

```bash
#!/bin/bash
PROJECT="0xbow"
REPO_PATH="/tmp/code_reviews/defi/$PROJECT"

cd "$REPO_PATH"

# Use Gemini for analysis
gemini chat << EOF
Analyze the code repository at $REPO_PATH following the template at /home/flower/code_review_template_for_local_llm.md

Repository: $(git remote get-url origin)
Language: TypeScript, Solidity
Focus: Privacy protocol with zero-knowledge proofs

Examine architecture, security, testing, and provide factual observations.
No quality scores or percentages.
EOF
```

---

## Batch Processing Script

```bash
#!/bin/bash
# Process all defi and identity projects with local LLM

SECTORS="defi identity"
REPO_BASE="/tmp/code_reviews"
OUTPUT_BASE="/home/flower/Ethereum-Cypherpunk-Research"

for sector in $SECTORS; do
  for proj_dir in "$REPO_BASE/$sector"/*; do
    proj=$(basename "$proj_dir")

    echo "Reviewing: $sector/$proj"

    # Run review (adapt for your LLM)
    code-llama --template /home/flower/code_review_template_for_local_llm.md \
               --repo "$proj_dir" \
               --output "$OUTPUT_BASE/$sector/$proj/reports/code_review.md"

    echo "✅ $sector/$proj complete"
  done
done
```

---

**Save this template to**: `/home/flower/code_review_template_for_local_llm.md`

**For Claude Code**: Continue with detailed reviews for 2 sample projects to validate the template.
