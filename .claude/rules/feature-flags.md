# Feature flags

Unfinished features are merged to `main` early and hidden behind a flag, so branches stay short-lived and PRs stay small.

## Convention

- Flags live in one config file per environment (location set in `CLAUDE.md` → Stack). No hosted flag service yet.
- Name: `<context>.<feature>` in kebab-case, e.g. `billing.invoice-export`.
- Default: **off** in production config, on in development and test config when useful.
- One flag per spec. Create it in the first slice; reference the spec issue next to it in the config.
- Check the flag at the outermost layer (route, UI entry point, job registration), not deep inside the domain.
- Tests cover both flag states for code paths that differ.

## Removing a flag

The last slice of a spec removes the flag and the dead code path. The spec is not done until the flag is gone.
