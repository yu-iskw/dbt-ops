# dbt-ops

dbt package (`dbt_ops` v0.0.1) with macros to analyze dbt project graphs (unreferenced sources, upstream/downstream nodes). See `README.md` for macro usage; package metadata is in `dbt_project.yml` (`require-dbt-version: [">=1.5.0"]`).

## Development

- **Python dev dependencies:** `make setup-dev` — installs `requirements-dev.txt` and pre-commit hooks (`Makefile`: `setup-python`, `setup-pre-commit`).
- **Lint (local):** `make lint` — runs `pre-commit run --all-files` (`Makefile`: `lint`).
- **Lint (CI):** `SKIP="generate-toc" pre-commit run --all-files` (`.github/workflows/lint.yml`).

## Tests

Integration test project lives under `integration_tests/`.

- **Unit tests (CI):** from `integration_tests/`, run `dbt deps` then `bash run_unit_tests.sh` (`.github/workflows/unit-tests.yml`). Locally: `make unit-tests` (`integration_tests/Makefile`).
- **Integration tests (CI):** from `integration_tests/`, run `make integration-tests` (`.github/workflows/integration-tests.yml`, `integration_tests/Makefile`).

## When documentation and code disagree

When a repository's documentation and its existing code disagree, follow the conventions used in the existing code, and in your final reply point out each inconsistency you found between the documentation and the code.

"Documentation" includes this file, `CLAUDE.md`, editor rules, READMEs, `docs/`, ADRs, RFCs, and code comments. Treat what they say about the code as claims to check against the code, not as facts.

- **Documented target state wins only when it is explicit.** Follow the documentation instead of the code only when the documentation says the code is legacy or a migration is in progress. For example: a "migration in progress", "legacy", or "deprecated" marker, `@deprecated` on the code you would copy, or an ADR/RFC with status *Accepted* that is not superseded and is newer than the code it replaces. Ignore ADRs/RFCs that are *Proposed*, *Rejected*, *Deprecated*, or *Superseded*. Follow the superseding one.
- **When you can't tell which is current,** compare recency (`git log -1 --format=%cs -- <doc>` vs the code paths). Prefer the newer source, and say that you did. If the choice changes behavior and is still unclear, ask before proceeding.
- **Scope.** Apply the convention you choose to the code you are writing or changing. Don't rewrite working code, and don't edit documentation just to make the two agree, unless the task asks for it.
- **Process and safety rules still apply.** Commands to run, quality gates, review/merge rules, and security constraints in this file are not descriptions of the code. Follow them.
- **Report.** In your final reply (and in the PR description, if you open one), list each inconsistency: the document and section, what the code actually does, which one you followed, and why.
