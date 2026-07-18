# flutter_helper_utils - AI assistant plugin

Package-specific skills that teach coding agents the EXACT
flutter_helper_utils APIs. Installable in Claude Code and OpenAI Codex
from this repository. Markdown skills only - no hooks, no MCP servers, no
scripts, no telemetry.

## Capabilities

| Skill | Use it for |
|---|---|
| `use-flutter-helper-utils` | BuildContext theme/media-query/navigation/platform/snapshot helpers, the import model (main vs `sugar.dart`), exact member names + full API reference |
| `adaptive-ui-and-lists-with-flutter-helper-utils` | `PlatformTypeProvider` + `Breakpoint` semantics (upper-bound matching, watch vs read), `TypedListView`/`TypedSliverList`/`buildListView` parameter contracts, scroll-position helpers |
| `colors-with-flutter-helper-utils` | String-to-Color parsing (CSS vs `0x` hex alpha order), `set*` channel APIs, darken/lighten/shade/tint, WCAG + color-blindness accessibility, reading Colors from Maps/JSON |
| `migrate-flutter-helper-utils-v8-to-v9` | The v8-to-v9 breaking migration (notifier extraction, color/navigation renames, `dataWhen` to `when`, dart_helper_utils v6 cascade) with detection greps and rename tables |
| `upgrade-flutter-helper-utils` | Version-aware upgrades: detects the installed version, sequences the v7/v8/v8.5/v9 hops, patch no-ops, future-version fallback |

## Install - Claude Code

```
/plugin marketplace add omar-hanafy/flutter_helper_utils
/plugin install flutter-helper-utils@flutter-helper-utils-tools
```

Start a new session afterwards so the skills load. Invoke explicitly with
`/flutter-helper-utils:use-flutter-helper-utils` (same pattern for the
other skills), or just describe the task - the skills self-select.

## Install - OpenAI Codex (CLI)

```
codex plugin marketplace add omar-hanafy/flutter_helper_utils
codex plugin add flutter-helper-utils@flutter-helper-utils-tools
```

Start a new session afterwards. The Codex IDE extension does not support
plugins; use its `$skill-installer` to copy the skills from
`tooling/ai/flutter-helper-utils/skills/` instead.

## Example prompts

- "Make this screen adaptive with flutter_helper_utils breakpoints -
  two-pane on desktop, single column on mobile."
- "Build the products list with pull-to-refresh and infinite scroll using
  TypedListView."
- "Parse the theme colors from this JSON and verify the text/background
  pairs meet WCAG AA."
- "Migrate this app from flutter_helper_utils 8.x to 9.x."

## Updating / uninstalling

Claude Code: `/plugin marketplace update flutter-helper-utils-tools`,
`/plugin uninstall flutter-helper-utils`. Codex:
`codex plugin marketplace update flutter-helper-utils-tools`,
`codex plugin remove flutter-helper-utils` (removing the marketplace
cascades).

## Permissions and trust

The plugin adds instruction files only. It never runs code by itself; the
agent's normal permission model governs every command it suggests. Skills
reference repository files and public pub.dev/GitHub URLs - nothing else.

## Compatibility

- Skills document flutter_helper_utils 9.x (they detect and route older
  versions to the migration skills).
- Plugin version tracks the package version (`pubspec.yaml` ==
  `.claude-plugin/plugin.json` == `.codex-plugin/plugin.json`), enforced
  by `tool/validate_agent_plugin.dart` in CI.
- Sibling plugins cover the layers below:
  `dart-helper-utils@dart-helper-utils-tools` (Dart utilities) and
  `convert-object@convert-object-tools` (type conversion). Install them
  alongside for full-stack coverage.

## Maintainers

- One canonical skills tree lives here; both manifests point at it.
- Validate locally: `dart run tool/validate_agent_plugin.dart` (also in
  CI) and `claude plugin validate .` at the repo root.
- Every future breaking release MUST ship a migration hop (dedicated
  `migrate-flutter-helper-utils-vX-to-vY` skill or an
  `upgrade-flutter-helper-utils` hop entry) before tagging - see
  `AGENTS.md`.
