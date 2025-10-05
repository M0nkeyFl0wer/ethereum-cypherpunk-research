# OpSec Summaries - Web3 Privacy Projects

This directory contains **operational security summaries only**.

## About These Summaries

- **Source**: Automated OSINT scans with SpiderFoot (200+ modules)
- **Coverage**: Infrastructure, domains, SSL, email discovery, threat intelligence
- **Purpose**: Executive-level security posture overview

## Full Detailed Reports

For complete security analysis including:
- Full SpiderFoot scan results (JSON)
- Critical findings with evidence
- Threat intelligence deep dives
- Pivot research and cross-references

See the main repository: [web3privacy-research](https://github.com/M0nkeyFl0wer/web3privacy-research/tree/main/security-analysis)

## Projects Analyzed

$(ls -1 *.md | grep opsec | sed 's/_opsec.md//' | awk '{print "- ["$1"](https://github.com/M0nkeyFl0wer/web3privacy-research/tree/main/security-analysis/"$1")"}')

---
*Last Updated: $(date)*
*Total OpSec Summaries: $(ls -1 *_opsec.md 2>/dev/null | wc -l)*
