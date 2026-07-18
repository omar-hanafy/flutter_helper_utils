/// Validates the AI coding-assistant plugin tree against this repository.
///
/// Deterministic checks (no network, no AI): manifest/catalog JSON syntax,
/// version alignment with `pubspec.yaml`, kebab-case identifiers, skill
/// frontmatter, self-contained skill references, absence of absolute or
/// escaping paths, and pub archive exclusions in `.pubignore`.
///
/// Run from the repository root: `dart run tool/validate_agent_plugin.dart`.
/// Exits non-zero when any check fails; prints every failure, not just the
/// first.
library;

import 'dart:convert';
import 'dart:io';

const _pluginRoot = 'tooling/ai/flutter-helper-utils';
const _claudeManifestPath = '$_pluginRoot/.claude-plugin/plugin.json';
const _codexManifestPath = '$_pluginRoot/.codex-plugin/plugin.json';
const _claudeCatalogPath = '.claude-plugin/marketplace.json';
const _codexCatalogPath = '.agents/plugins/marketplace.json';
const _skillsDir = '$_pluginRoot/skills';

final _kebabCase = RegExp(r'^[a-z0-9]+(-[a-z0-9]+)*$');
final _errors = <String>[];

void _fail(String message) => _errors.add(message);

String? _readPubspecVersion() {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    _fail('pubspec.yaml not found (run from the repository root).');
    return null;
  }
  final match = RegExp(
    r'^version:\s*(\S+)\s*$',
    multiLine: true,
  ).firstMatch(pubspec.readAsStringSync());
  if (match == null) {
    _fail('pubspec.yaml has no version line.');
    return null;
  }
  return match.group(1);
}

Map<String, dynamic>? _readJson(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    _fail('$path: missing file.');
    return null;
  }
  try {
    final decoded = jsonDecode(file.readAsStringSync());
    if (decoded is! Map<String, dynamic>) {
      _fail('$path: top-level JSON value must be an object.');
      return null;
    }
    return decoded;
  } on FormatException catch (e) {
    _fail('$path: invalid JSON (${e.message}).');
    return null;
  }
}

void _checkSourcePath(String path, String owner) {
  if (!path.startsWith('./')) {
    _fail('$owner: source path "$path" must start with "./".');
  }
  if (path.contains('..')) {
    _fail('$owner: source path "$path" must not contain "..".');
  }
  final resolved = path.startsWith('./') ? path.substring(2) : path;
  if (!Directory(resolved).existsSync()) {
    _fail('$owner: source path "$path" does not exist in the repository.');
  }
}

void _checkManifests(String pubspecVersion) {
  for (final entry in {
    _claudeManifestPath: 'Claude',
    _codexManifestPath: 'Codex',
  }.entries) {
    final manifest = _readJson(entry.key);
    if (manifest == null) continue;
    final name = manifest['name'];
    if (name is! String || !_kebabCase.hasMatch(name)) {
      _fail('${entry.key}: "name" must be a kebab-case string, got "$name".');
    }
    final version = manifest['version'];
    if (version != pubspecVersion) {
      _fail(
        '${entry.key}: version "$version" does not match pubspec.yaml '
        'version "$pubspecVersion".',
      );
    }
    for (final field in ['description', 'license', 'repository']) {
      if (manifest[field] is! String || (manifest[field] as String).isEmpty) {
        _fail('${entry.key}: "$field" must be a non-empty string.');
      }
    }
  }
}

void _checkCatalogs() {
  final claude = _readJson(_claudeCatalogPath);
  final codex = _readJson(_codexCatalogPath);
  String? claudeName;
  String? codexName;

  if (claude != null) {
    claudeName = claude['name'] as String?;
    if (claudeName == null || !_kebabCase.hasMatch(claudeName)) {
      _fail('$_claudeCatalogPath: marketplace "name" must be kebab-case.');
    }
    if (claude['owner'] is! Map || (claude['owner'] as Map)['name'] == null) {
      _fail('$_claudeCatalogPath: "owner.name" is required.');
    }
    final plugins = claude['plugins'];
    if (plugins is! List || plugins.isEmpty) {
      _fail('$_claudeCatalogPath: "plugins" must be a non-empty array.');
    } else {
      final names = <String>{};
      for (final plugin in plugins.cast<Map<String, dynamic>>()) {
        final name = plugin['name'] as String?;
        if (name == null || !_kebabCase.hasMatch(name)) {
          _fail('$_claudeCatalogPath: plugin "name" must be kebab-case.');
        } else if (!names.add(name)) {
          _fail('$_claudeCatalogPath: duplicate plugin name "$name".');
        }
        final source = plugin['source'];
        if (source is String) {
          _checkSourcePath(source, '$_claudeCatalogPath ($name)');
        } else {
          _fail(
            '$_claudeCatalogPath ($name): expected a relative-path string '
            'source for a repo-hosted plugin.',
          );
        }
        if (plugin.containsKey('version')) {
          _fail(
            '$_claudeCatalogPath ($name): do not set "version" in the '
            'catalog entry; plugin.json is the single version source.',
          );
        }
      }
    }
  }

  if (codex != null) {
    codexName = codex['name'] as String?;
    if (codexName == null || !_kebabCase.hasMatch(codexName)) {
      _fail('$_codexCatalogPath: marketplace "name" must be kebab-case.');
    }
    final plugins = codex['plugins'];
    if (plugins is! List || plugins.isEmpty) {
      _fail('$_codexCatalogPath: "plugins" must be a non-empty array.');
    } else {
      for (final plugin in plugins.cast<Map<String, dynamic>>()) {
        final name = plugin['name'] as String?;
        if (name == null || !_kebabCase.hasMatch(name)) {
          _fail('$_codexCatalogPath: plugin "name" must be kebab-case.');
        }
        final source = plugin['source'];
        if (source is Map<String, dynamic>) {
          if (source['source'] != 'local') {
            _fail(
              '$_codexCatalogPath ($name): expected {"source": "local"} for '
              'a repo-hosted plugin.',
            );
          }
          final path = source['path'];
          if (path is String) {
            _checkSourcePath(path, '$_codexCatalogPath ($name)');
          } else {
            _fail('$_codexCatalogPath ($name): "source.path" is required.');
          }
        } else {
          _fail('$_codexCatalogPath ($name): "source" must be an object.');
        }
      }
    }
  }

  if (claudeName != null && codexName != null && claudeName != codexName) {
    _fail(
      'Marketplace names differ between catalogs: "$claudeName" (Claude) vs '
      '"$codexName" (Codex). Keep them identical so install docs stay true.',
    );
  }
}

({String? name, String? description}) _parseFrontmatter(
  String path,
  String content,
) {
  final lines = const LineSplitter().convert(content);
  if (lines.isEmpty || lines.first.trim() != '---') {
    _fail('$path: missing YAML frontmatter opening "---".');
    return (name: null, description: null);
  }
  final end = lines.indexWhere((l) => l.trim() == '---', 1);
  if (end == -1) {
    _fail('$path: frontmatter never closes with "---".');
    return (name: null, description: null);
  }
  String? name;
  String? description;
  for (final line in lines.sublist(1, end)) {
    if (line.startsWith('name:')) {
      name = line.substring('name:'.length).trim();
    } else if (line.startsWith('description:')) {
      description = line.substring('description:'.length).trim();
    }
  }
  return (name: name, description: description);
}

void _checkSkillLinks(String skillDir, String mdPath, String content) {
  final links = RegExp(r'\[[^\]]*\]\(([^)]+)\)').allMatches(content);
  for (final match in links) {
    final target = match.group(1)!.split('#').first.trim();
    if (target.isEmpty || target.contains('://')) continue;
    if (target.startsWith('/')) {
      _fail('$mdPath: absolute link target "$target" is not portable.');
      continue;
    }
    final normalized = Uri(
      path: '${File(mdPath).parent.path}/$target',
    ).normalizePath().path;
    if (!normalized.startsWith('$skillDir/')) {
      _fail(
        '$mdPath: link "$target" escapes the skill directory; skills must '
        'be self-contained.',
      );
      continue;
    }
    if (!File(normalized).existsSync()) {
      _fail('$mdPath: link target "$target" does not exist.');
    }
  }
}

void _checkSkills() {
  final skillsRoot = Directory(_skillsDir);
  if (!skillsRoot.existsSync()) {
    _fail('$_skillsDir: missing skills directory.');
    return;
  }
  final skillDirs = skillsRoot.listSync().whereType<Directory>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  if (skillDirs.isEmpty) {
    _fail('$_skillsDir: no skills found.');
    return;
  }
  final seen = <String>{};
  for (final dir in skillDirs) {
    final dirName = dir.path.split(Platform.pathSeparator).last;
    final skillPath = '${dir.path}/SKILL.md';
    final skillFile = File(skillPath);
    if (!skillFile.existsSync()) {
      _fail('$skillPath: missing SKILL.md.');
      continue;
    }
    if (!_kebabCase.hasMatch(dirName)) {
      _fail('${dir.path}: skill directory name must be kebab-case.');
    }
    if (!seen.add(dirName)) {
      _fail('${dir.path}: duplicate skill name.');
    }
    final content = skillFile.readAsStringSync();
    final frontmatter = _parseFrontmatter(skillPath, content);
    if (frontmatter.name != dirName) {
      _fail(
        '$skillPath: frontmatter name "${frontmatter.name}" must equal the '
        'directory name "$dirName" (agentskills.io requirement).',
      );
    }
    final description = frontmatter.description;
    if (description == null || description.isEmpty) {
      _fail('$skillPath: frontmatter "description" is required.');
    } else {
      if (description.length > 1024) {
        _fail(
          '$skillPath: description is ${description.length} chars; the '
          'portable limit is 1024.',
        );
      }
      if (description.contains(': ') && !description.startsWith('"')) {
        _fail(
          '$skillPath: unquoted description contains ": " which breaks the '
          'YAML plain scalar (frontmatter would silently drop). Rephrase or '
          'quote the whole value.',
        );
      }
    }
    for (final md
        in dir
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.md'))) {
      final text = md.readAsStringSync();
      _checkSkillLinks(dir.path, md.path, text);
      for (final marker in ['/Users/', '/home/', r'C:\']) {
        if (text.contains(marker)) {
          _fail('${md.path}: contains machine-specific path marker "$marker".');
        }
      }
      for (final marker in ['-----BEGIN', 'ghp_', 'AKIA']) {
        if (text.contains(marker)) {
          _fail('${md.path}: contains secret-like marker "$marker".');
        }
      }
    }
  }
}

void _checkPubignore() {
  final file = File('.pubignore');
  if (!file.existsSync()) {
    _fail('.pubignore: missing; the plugin tree would leak into the archive.');
    return;
  }
  final lines = const LineSplitter()
      .convert(file.readAsStringSync())
      .map((l) => l.trim())
      .toSet();
  for (final required in ['tooling/', 'tool/', 'AGENTS.md', 'CLAUDE.md']) {
    if (!lines.contains(required)) {
      _fail(
        '.pubignore: missing "$required" - the pub.dev archive must not '
        'contain a partial AI plugin or maintainer-only files.',
      );
    }
  }
}

/// Entry point; see the library docs for what is validated.
void main() {
  final pubspecVersion = _readPubspecVersion();
  if (pubspecVersion != null) {
    _checkManifests(pubspecVersion);
  }
  _checkCatalogs();
  _checkSkills();
  _checkPubignore();

  if (_errors.isEmpty) {
    stdout.writeln('Agent plugin validation passed.');
    return;
  }
  stderr.writeln('Agent plugin validation FAILED:');
  for (final error in _errors) {
    stderr.writeln('  - $error');
  }
  exitCode = 1;
}
