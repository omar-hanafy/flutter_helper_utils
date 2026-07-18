# flutter_helper_utils - agent guide (maintainers)

Flutter utility package. Public API is `lib/flutter_helper_utils.dart`
(re-exports ALL of `package:dart_helper_utils` - which itself re-exports
`collection`, `convert_object`, and five intl symbols - plus this package's
colors, widgets, platform_env, future helpers, and `sugar.dart`).
`lib/sugar.dart` alone is the opt-in shortcut surface (context extensions,
`int.color`, num/Size sugar).

## Validation gates (run before claiming any change done)

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze                       # public_member_api_docs is enforced
flutter test
dart run tool/validate_agent_plugin.dart   # AI plugin/marketplace consistency
dart pub publish --dry-run            # must stay at 0 warnings
```

CI requires a PERFECT pana score on PRs ("CI / Pana" is a required check);
avoid changes that cost points (missing doc comments, dependency issues,
format drift).

## Conventions

- Dart-only utilities live in `dart_helper_utils`; type conversion lives in
  `convert_object`. Do not add pure-Dart helpers here - contribute upstream.
  Notifier utilities live in `better_value_notifier` (extracted in v9).
- Behavior quirks are load-bearing: `Breakpoint` matching is upper-bound
  (`width <= breakpoint.width`, defaults mobile 600 / tablet 1200 /
  desktop 1800), hex color strings use CSS channel order (`#RRGGBBAA`)
  while `0x` strings use Dart order (`0xAARRGGBB`), and `popPage` delegates
  to `maybePop` (respects `PopScope`) while `forcePopPage` pops directly.
  Do not "fix" these without a major release and a migration entry.
- Any public API change needs matching tests under `test/` and doc comments
  on every public member.
- Never use the em-dash character in this repo's files; use '-' instead.

## Release process

1. Version bump lands via PR to `main` (branch protection requires checks
   "Test on stable", "Pana", "dry-run"; no direct pushes). Stable versions
   only on `main`; `-dev` pre-releases only on `dev`.
2. `CHANGELOG.md` entry + `pubspec.yaml` version in the same PR.
3. Merge -> auto-release workflow creates tag
   `flutter_helper_utils-vX.Y.Z` + GitHub release; the tag triggers trusted
   publishing to pub.dev (OIDC, no manual credentials). Never re-use or
   overwrite an existing tag.
4. Breaking releases must update `migration_guides.md` AND ship the
   corresponding migration hop in the AI plugin (see below) before tagging.

## AI assistant plugin (Claude Code + Codex)

- Canonical tree: `tooling/ai/flutter-helper-utils/` (one shared `skills/`
  set; manifests `.claude-plugin/plugin.json` + `.codex-plugin/plugin.json`).
  Catalogs: `.claude-plugin/marketplace.json` and
  `.agents/plugins/marketplace.json` at the repo root.
- Both plugin manifests' `version` must equal the `pubspec.yaml` version -
  bump them together (CI enforces via `tool/validate_agent_plugin.dart`).
- Skill facts must match the source; when changing behavior in `lib/`,
  update the affected skill/reference files in the same PR.
- Any future BREAKING release must ship a migration hop in the plugin
  (a dedicated `migrate-flutter-helper-utils-vX-to-vY` skill for large
  migrations, or a hop entry in `upgrade-flutter-helper-utils`) before
  tagging.
- The plugin tree, catalogs, `tool/`, and this file are excluded from the
  pub.dev archive via `.pubignore` - keep the archive free of partial
  plugin content. `migration_guides.md` and `documentations/` stay IN the
  archive (linked from the README).
- Sibling repositories host their own plugins covering their layers:
  `dart-helper-utils@dart-helper-utils-tools` (Dart-only utilities) and
  `convert-object@convert-object-tools` (type conversion). Keep
  cross-references between the three consistent.
