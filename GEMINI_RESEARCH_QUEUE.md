# Gemini CLI Research Queue

**Purpose**: Deep web search and fetch for projects needing code analysis and additional research
**Gemini Strengths**: Web search, web fetch, content analysis
**Target**: 17 projects missing code analysis + gaps verification

---

## Priority 1: Projects Missing Code Analysis (17 projects)

These projects need **deep code analysis** via web search and GitHub exploration:

### Tier A: High-Profile Projects (8 projects)
**Research Needed**: Code architecture, security analysis, technical implementation

1. **arpa** - https://github.com/ARPA-Network/BLS-TSS-Network
   - Search: "ARPA Network code architecture", "ARPA threshold signature scheme implementation"
   - Fetch: GitHub README, docs/, CONTRIBUTING.md
   - Analysis: Cryptographic implementation, network architecture

2. **grin** - https://github.com/mimblewimble/grin
   - Search: "Grin MimbleWimble implementation", "Grin privacy code review"
   - Fetch: GitHub docs, Rust codebase structure
   - Analysis: MimbleWimble protocol, privacy guarantees

3. **nillion** - https://nillion.com + https://docs.nillion.com
   - Search: "Nillion blind computation architecture", "Nillion technical whitepaper"
   - Fetch: Documentation site, technical blog posts
   - Analysis: Blind computing implementation, privacy tech

4. **session** - https://github.com/oxen-io/session-desktop
   - Search: "Session messenger privacy implementation", "Session onion routing"
   - Fetch: GitHub security docs, protocol specs
   - Analysis: E2E encryption, routing protocol

5. **taiko** - https://github.com/taikoxyz/taiko-mono
   - Search: "Taiko ZK-rollup implementation", "Taiko sequencer code"
   - Fetch: Monorepo structure, technical docs
   - Analysis: ZK-EVM implementation, rollup architecture

6. **status** - https://github.com/status-im/status-mobile
   - Search: "Status mobile privacy features", "Status Waku implementation"
   - Fetch: Mobile app codebase, Waku protocol docs
   - Analysis: Messaging privacy, network protocol

7. **veramo** - https://github.com/decentralized-identity/veramo
   - Search: "Veramo DID framework architecture", "Veramo verifiable credentials"
   - Fetch: Framework docs, plugin system
   - Analysis: Identity verification, privacy model

8. **beam** - https://github.com/BeamMW/beam
   - Search: "Beam confidential assets code", "Beam Lelantus MW implementation"
   - Fetch: C++ codebase structure, protocol docs
   - Analysis: Confidential transactions, privacy tech

### Tier B: Wallets & Infrastructure (5 projects)
**Research Needed**: Security audits, privacy features, user protection

9. **railway-wallet** - https://railway.xyz
   - Search: "Railway wallet privacy features", "Railway 0zk technology"
   - Fetch: Website technical pages, security docs
   - Analysis: Zero-knowledge proofs, wallet security

10. **frame** - https://github.com/floating/frame
    - Search: "Frame wallet architecture", "Frame Ethereum security"
    - Fetch: Desktop wallet codebase, security model
    - Analysis: Key management, transaction privacy

11. **edge-wallet** - https://github.com/EdgeApp/edge-react-gui
    - Search: "Edge wallet privacy features", "Edge security model"
    - Fetch: React Native codebase, security docs
    - Analysis: Multi-currency support, privacy features

12. **pirate-chain** - https://pirate.black
    - Search: "Pirate Chain z-transactions", "Pirate Chain fork implementation"
    - Fetch: Zcash fork documentation, privacy specs
    - Analysis: Shielded transactions, privacy guarantees

13. **mask** - https://mask.io
    - Search: "Mask Network browser extension security", "Mask privacy layer"
    - Fetch: Extension architecture, privacy docs
    - Analysis: Social media privacy, Web3 integration

### Tier C: Protocols & Tools (4 projects)
**Research Needed**: Protocol specifications, implementation details

14. **sismo** - https://github.com/sismo-core/sismo-protocol
    - Search: "Sismo ZK badge implementation", "Sismo attestation protocol"
    - Fetch: Protocol docs, smart contract code
    - Analysis: Zero-knowledge proofs, identity privacy

15. **zion** - https://www.getzion.com
    - Search: "Zion social platform architecture", "Zion content privacy"
    - Fetch: Platform documentation, API specs
    - Analysis: Decentralized social, content ownership

16. **zkbob** - https://github.com/zkBob/zkbob-contracts
    - Search: "zkBob stablecoin privacy", "zkBob smart contract security"
    - Fetch: Solidity contracts, audit reports
    - Analysis: Zero-knowledge privacy, compliance features

17. **--target** - *(Needs identification - appears to be malformed project name)*
    - Search: "Ethereum privacy target project", directory name investigation
    - Manual investigation required

---

## Priority 2: Description Quality Verification (20 projects)

These have descriptions but need **richer content** from web sources:

### Verify & Enhance Short Descriptions (< 50 chars)

1. **veramo** (40 chars): "JavaScript framework for verifiable data"
   - Search: "Veramo framework capabilities", "Veramo use cases"
   - Goal: Expand to 100-150 char comprehensive description

2. **1inch-privacy** (24 chars): "No description available"
   - Search: "1inch privacy features", "1inch Fusion mode privacy"
   - Fetch: https://1inch.io/privacy, technical docs

3. **curve-privacy**, **dark-forest**, **eth2-deposit-cli**, **gitcoin-grants**, **mask**, **mina-protocol**, **zecrey**
   - All have placeholder descriptions
   - Need web search for official descriptions

---

## Priority 3: GitHub Repository Deep Dive (10 projects)

Projects with GitHub but need **README/docs extraction**:

### Clone & Extract Technical Details

1. **alephim** - https://github.com/aleph-im
   - Extract: Architecture docs, API documentation, deployment guides

2. **arpa** - https://github.com/ARPA-Network
   - Extract: Protocol specification, cryptography docs, network topology

3. **brume-wallet** - https://github.com/brumewallet
   - Extract: Security model, privacy features, wallet architecture

4. **chainport** - https://github.com/chainport
   - Extract: Bridge architecture, security mechanisms, cross-chain tech

5. **fileverse** - https://github.com/fileverse
   - Extract: Decentralized storage, encryption, privacy guarantees

6-10. **grin, nillion, session, taiko, veramo** (already in Tier A above)

---

## Priority 4: Website Content Mining (15 projects)

Projects with websites but need **deep content extraction**:

### Scrape Technical Pages & Blog Posts

1. **concordium** - https://concordium.com
   - Fetch: /technology, /developers, /privacy-layer
   - Extract: Zero-knowledge proofs, identity layer

2. **findora** - https://findora.org
   - Fetch: /technology, /whitepaper, /zkp
   - Extract: Confidential assets, privacy tech

3. **iden3** - https://iden3.io
   - Fetch: /docs, /protocol, /circom
   - Extract: ZK circuits, identity protocol

4. **iexec** - https://iex.ec
   - Fetch: /confidential-computing, /technology
   - Extract: TEE implementation, privacy guarantees

5. **incognito** - https://incognito.org
   - Fetch: /privacy, /technology, /how-it-works
   - Extract: Privacy coins, shielding tech

6-15. **light-protocol, mobilecoin, brave-browser, cake-wallet, circom, farcaster, lens-protocol, metamask-snaps, railway, snapshot-x**

---

## Gemini CLI Commands

### For Web Search (Code Analysis Research)
```bash
# Example for ARPA
gemini search "ARPA Network threshold signature implementation code architecture"
gemini search "ARPA BLS-TSS Network security analysis"
gemini search "ARPA privacy guarantees technical review"
```

### For Web Fetch (Documentation Extraction)
```bash
# Example for Grin
gemini fetch "https://github.com/mimblewimble/grin/blob/master/README.md"
gemini fetch "https://docs.grin.mw/about-grin/privacy/"
gemini fetch "https://github.com/mimblewimble/grin/blob/master/doc/intro.md"
```

### For Content Analysis
```bash
# Example for Nillion
gemini analyze "https://docs.nillion.com/concepts" --extract "privacy features, architecture, cryptography"
gemini summarize "https://nillion.com/blog/technical-overview" --focus "implementation details"
```

---

## Research Output Format

For each project researched, create:

### 1. Code Analysis JSON (`analysis/code_analysis.json`)
```json
{
  "project_name": "project-name",
  "research_date": "2025-10-10",
  "architecture": {
    "type": "description",
    "components": ["list", "of", "components"],
    "confidence": 0.90,
    "sources": ["URL1", "URL2"]
  },
  "privacy_mechanisms": {
    "techniques": ["ZK proofs", "encryption", "etc"],
    "implementation": "description",
    "confidence": 0.85,
    "sources": ["URL"]
  },
  "security_analysis": {
    "audits": ["audit reports"],
    "vulnerabilities": "known issues",
    "mitigations": "security measures",
    "confidence": 0.80,
    "sources": ["URL"]
  },
  "code_quality": {
    "languages": {"Rust": "60%", "Go": "40%"},
    "test_coverage": "if available",
    "documentation": "quality assessment"
  }
}
```

### 2. Technical Report (`reports/code_analysis.md`)
Markdown summary of findings with sections:
- Architecture Overview
- Privacy Implementation
- Security Analysis
- Code Quality Assessment
- Recommendations

---

## Constitutional Compliance Requirements

All research MUST follow:
- ✅ **Real data only** - No synthetic generation
- ✅ **Multi-source verification** - 2+ sources for critical claims
- ✅ **Confidence scoring** - 0.0-1.0 for all data points
- ✅ **Source attribution** - Every claim cites source URL
- ✅ **Gap reporting** - Explicitly document what's missing

---

## Execution Strategy

### Parallel Batches (4 streams)
**Batch 1** (Tier A1-4): arpa, grin, nillion, session
**Batch 2** (Tier A5-8): taiko, status, veramo, beam
**Batch 3** (Tier B): railway-wallet, frame, edge-wallet, pirate-chain, mask
**Batch 4** (Tier C): sismo, zion, zkbob, --target

### Timeline
- **Each project**: 30-45 minutes of research
- **Batch 1-2**: High priority, complete first (8 projects = 4-6 hours)
- **Batch 3-4**: Medium priority, complete next (9 projects = 4-6 hours)
- **Total**: 8-12 hours for complete code analysis coverage

---

## Success Criteria

### Minimum Requirements (Constitutional Compliance)
- ✅ Description: 100-300+ characters from official sources
- ✅ Architecture: Core components and design pattern
- ✅ Privacy Tech: Specific cryptographic/privacy mechanisms
- ✅ Security: Known audits, vulnerabilities, or mitigation strategies
- ✅ Code Quality: Language breakdown, test coverage if available
- ✅ Sources: 3-5+ URLs cited for verification

### Deliverables Per Project
1. `analysis/code_analysis.json` - Structured technical data
2. `reports/code_analysis.md` - Human-readable summary
3. Updated `constitutional_research.json` - Integrated findings
4. Updated `README.md` - Reflects new technical depth

---

*Research Protocol v2.0.0 - Constitutional Compliance Required*
*Zero Fabrication - 100% Real Data - Multi-Source Verification*
