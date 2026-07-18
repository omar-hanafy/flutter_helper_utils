---
name: colors-with-flutter-helper-utils
description: Use when Flutter code parses, converts, or manipulates colors with the flutter_helper_utils package - string-to-Color parsing (hex/rgb/hsl/hwb/named CSS), opacity and channel changes (setOpacity, setAlpha), darken/lighten/shade/tint, WCAG contrast and accessibility checks, color-blindness simulation, color harmonies, toHex output, or reading Colors from JSON/Map config (toColor, tryGetColor).
---

# Colors with flutter_helper_utils

The color surface has two confidently-wrong traps: agents produce the
REMOVED v8 `add*` members as if they were current, and they invert the hex
alpha-position rule. Use the exact contracts below.

## THE hex trap: '#' is CSS order, '0x' is Dart order

- `'#FF000080'.toColor` -> `#`-prefixed 8-digit hex is CSS `#RRGGBBAA`:
  R=FF, G=00, B=00, alpha=80 -> **50%-transparent RED**.
- `'0xFF000080'.toColor` -> `0x`-prefixed hex is Dart `0xAARRGGBB`:
  alpha=FF, RGB=000080 -> **opaque NAVY**.
- Same duality for 4-digit shorthand: `'#F008'` is CSS RGBA, `'0xF008'`
  is Dart ARGB. 3- and 6-digit strings get full opacity prepended.
- This CSS ordering is CORRECT since v9 (v8 parsed it wrong); code
  migrated from v8 may silently change colors - re-verify stored hex.

`'...'.toColor` (getter, `Color?`) also parses: named CSS colors
('rebeccapurple'), `rgb(255 0 0 / 50%)` and legacy `rgb(255, 0, 0)` /
`rgba(...)`, `hsl(220, 60%, 50%)` / `hsla` (s and l REQUIRE the `%` sign),
`hwb(...)`, hue units `deg`/`rad`/`grad`/`turn`. Legacy `rgb()` with a 4th
value is REJECTED (use `rgba()` or the modern slash syntax); rgb components
must be all-percent or all-numeric. Validity checks: `isValidColor`,
`isHexColor`, `isRgbColor`, `isHslColor`, `isModernColor` (g).

## Exact names agents get wrong (verified against source)

| Task | WRONG guesses | Actual API |
|---|---|---|
| 50% transparent | `addOpacity(0.5)` ("v9 API" - it is the REMOVED v8 name), `withOpacity` | `color.setOpacity(0.5)` (0.0-1.0); `setAlpha(128)` (0-255); `scaleOpacity(0.5)` multiplies existing alpha |
| Channel change | `addRed(255)` (removed v8) | `setRed(255)`, `setGreen`, `setBlue` (0-255) |
| Contrast ratio | `contrastRatio(other)` | `color.contrast(other)` -> ratio >= 1.0 |
| WCAG pass/fail | `isAccessible(...)` | `background.meetsWCAG(foreground, {level: WCAGLevel.aa, context: WCAGContext.normalText})` |
| Readable text color | - | `background.contrastColor({light = Colors.white, dark = Colors.black, threshold = 0.179})` |
| Map -> Color | `tryGetString(...).toColor` detour, `altKeys:` | `map.getColor('primary', alternativeKeys: ['primaryColor'])` / `map.tryGetColor(...)` - FHU ships these directly |
| Any object -> Color | - | top-level `toColor(obj)` / `tryToColor(obj)` or `FConvertObject.toColor(obj, {mapKey, listIndex, defaultValue, converter})` |
| ARGB int out | `color.value` (deprecated Flutter) | `color.toARGBInt()` |

## Manipulation semantics (all sRGB-aligned internally)

- `darken([0.1])` / `lighten([0.1])` shift HSL lightness;
  `shade([0.1])` mixes toward black, `tint([0.1])` toward white - pick
  shade/tint for design-token ramps, darken/lighten for hover states.
- `blend(other, [t = 0.5])`, `complementary()`, `grayscale()`
  (perceptual, via linear luminance), `invert()` (alpha preserved).
- `isDark({threshold = 0.179})` / `isLight` use WCAG luminance, not HSL.
- Harmonies return `List<Color>` including the original: `triadic()`,
  `tetradic()`, `splitComplementary({angle = 30})`,
  `analogous({count = 3, angle = 30})`,
  `monochromatic({count = 5, lightnessRange = 0.5})`.
- `toHex({leadingHashSign = true, includeAlpha = false,
  omitAlphaIfFullOpacity = false, uppercase = false})` - alpha is OFF by
  default, and when included it is emitted FIRST (ARGB order, matching
  `Color(0x...)` round-trips, NOT CSS order).
- `isApproximately(other, {epsilon = 0.001})` for float-safe comparison;
  `toWidgetStateProperty` (g) wraps in `WidgetStateProperty.all`.
- Wide gamut: helpers convert to sRGB internally;
  `convertToColorSpace(space)` / `isInColorSpace(space)` manage
  `ColorSpace` explicitly.

## Accessibility toolkit

```dart
final ok = bg.meetsWCAG(fg, level: WCAGLevel.aaa,
    context: WCAGContext.largeText);          // aa/aaa x normalText/largeText/uiComponent
final suggestion = bg.suggestAccessibleColors(level: WCAGLevel.aa);
suggestion.normalText;                        // record: (normalText, largeText, uiComponent)
final seen = color.simulateColorBlindness(ColorBlindnessType.deuteranopia);
final safe = a.isDistinguishableFor(b, ColorBlindnessType.protanopia,
    minContrast: 3.0);
```

Thresholds: AA 4.5 normal / 3.0 large; AAA 7.0 normal / 4.5 large; UI
components always 3.0. `ColorBlindnessType`: `protanopia`,
`deuteranopia`, `tritanopia`, `achromatopsia`.

## Reading colors from config/JSON

`FConvertObject.toColor` (throwing) / `tryToColor` (nullable) accept
`Color`, `HSLColor`/`HSVColor`, ARGB `int`, numeric strings, and every
string format above; `mapKey:`/`listIndex:` navigate nested data,
`defaultValue:` and custom `converter:` are supported. Map extensions
`getColor`/`tryGetColor` add `alternativeKeys:` (first PRESENT key wins
after a null direct hit); Iterable extensions `getColor(index)` /
`tryGetColor(index)` mirror them. A failed `getColor` throws a
`ConversionException` with the offending key in its context map.

## Step 0: Inspect the project first

Resolved version: `grep -A2 'flutter_helper_utils' pubspec.lock`. The
`set*` members and CSS-order hex parsing are 9.x; on 8.x the `add*` names
still exist and 8-digit `#` hex parses DIFFERENTLY - migrate first
(migrate-flutter-helper-utils-v8-to-v9 skill).

## Verification

- `flutter analyze` the touched paths; `add*` color members resolving
  means the project is still on v8.
- For parsing code, add a test asserting an exact `Color` value for one
  `#RRGGBBAA` input (locks the CSS-order contract) and one `0x` input.

## Failure handling

- `toColor` returns null on valid-looking input: check the format rules
  above (missing `%` in hsl, 4th value in legacy `rgb()`, mixed
  percent/numeric rgb components).
- Undefined `setOpacity`: pre-9 version - use the migrate skill.
- Theme/ColorScheme role access (`context.themeData.primary`,
  `schemeColor('primary')`): that is the use-flutter-helper-utils skill.
