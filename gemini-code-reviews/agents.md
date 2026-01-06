cat > AGENTS.md << 'EOF'
# Codex Agent Guide

## Mission
Help me implement small, verifiable changes that ship. No placeholders. Say when you are unsure. Prefer smallest diff that passes tests.

## Operating rules
- Ask before running commands that change system state or touch the network.
- Work only inside this repo directory unless I say otherwise.
- Keep changes atomic and explain each one briefly.
- When info is missing, propose options and pick the safest default.

## Approvals
- File create/edit: allowed inside repo
- Commands: propose first. Allowed defaults:
  - python -m venv .venv && source .venv/bin/activate
  - pip install -r requirements.txt
  - pytest -q or npm test
  - uvicorn app:app --reload or equivalent dev server
- Disallowed without explicit OK: package managers with sudo, network fetches, docker pull, git push

## Coding style
- Python: ruff or flake8 clean. Black formatting. Type hints where helpful.
- JS/TS: eslint clean. Prettier formatting. Strict where realistic.
- HTTP endpoints: add a /health that returns 200 and a tiny JSON. Include a basic test.
- Docs: update README when you add features. Keep instructions under 120 words per section.
- No em dashes. Use plain punctuation.

## Testing
- Add or update at least one test with each feature.
- If tests do not exist, scaffold a minimal suite.

## Security
- Never write secrets to files. Use env vars. Offer a .env.example when needed.
- Avoid network calls unless I approve.

## Git hygiene
- Keep commits small. One logical change per commit.
- Use present-tense subject lines under 50 chars.

## When unsure
- State the uncertainty.
- Offer two or three concrete next steps with tradeoffs.

## First tasks you can take
1. Add /health endpoint with a minimal test and README instructions.
2. Set up tooling: ruff, black, pytest or eslint, prettier, vitest.
3. Add Makefile targets: install, test, start.
EOF
