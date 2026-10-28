#!/usr/bin/env python3
"""Generate SVG previews of every tokyonight variant for Fast Syntax Highlighting.

The demo transcript below is hand-tokenized with F-Sy-H style keys; each style
key is resolved through the actual theme INI files, so the previews always
reflect the shipped colors.

Usage:  python3 scripts/generate_previews.py
Output: assets/preview-<variant>.svg
"""

from __future__ import annotations

import configparser
import html
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
ASSETS = ROOT / "assets"
VARIANTS = ("night", "storm", "moon", "day")

FONT = "ui-monospace, 'JetBrains Mono', 'Fira Code', 'SF Mono', Menlo, Consolas, monospace"
FONT_SIZE = 13
CHAR_W = 7.8
LINE_H = 22
PAD_X = 22
PAD_Y = 18
TITLE_H = 38
DOT_R = 5.5

# Token colors for the window chrome, taken from each variant's own palette.
CHROME = {
    "night": {"bg": "#1a1b26", "bg_dark": "#16161e", "fg_dark": "#a9b1d6", "red": "#f7768e", "yellow": "#e0af68", "green": "#9ece6a"},
    "storm": {"bg": "#24283b", "bg_dark": "#1f2335", "fg_dark": "#a9b1d6", "red": "#f7768e", "yellow": "#e0af68", "green": "#9ece6a"},
    "moon": {"bg": "#222436", "bg_dark": "#1e2030", "fg_dark": "#828bb8", "red": "#ff757f", "yellow": "#ffc777", "green": "#c3e88d"},
    "day": {"bg": "#e1e2e7", "bg_dark": "#d0d5e3", "fg_dark": "#6172b0", "red": "#f52a65", "yellow": "#8c6c3e", "green": "#587539"},
}

# A hand-tokenized zsh transcript. Each line is a list of (text, style-key)
# spans; a style key of None means plain text (the theme's `default` style).
DEMO: list[list[tuple[str, str | None]]] = [
    [("# tokyonight.zsh-fsh — Tokyo Night for Fast Syntax Highlighting", "comment")],
    [("autoload", "builtin"), (" -Uz ", "single-hyphen-option"), ("compinit", "function"),
     (" && ", "commandseparator"), ("compinit", "function"), (" -C", "single-hyphen-option")],
    [("export", "builtin"), (" PATH=", None), ('"', "double-quoted-argument"),
     ("$HOME", "back-or-dollar-double-quoted-argument"), ("/.local/bin:", "double-quoted-argument"),
     ("$PATH", "back-or-dollar-double-quoted-argument"), ('"', "double-quoted-argument")],
    [("alias", "builtin"), (" ll=", None), ("'ls -lah --color=auto'", "single-quoted-argument")],
    [("ll", "alias"), (" ~/work/tokyonight.zsh-fsh", "path")],
    [("git", "command"), (" commit", "subcommand"), (" -m", "double-hyphen-option"),
     (' "feat: add tokyonight theme"', "double-quoted-argument"), (" --amend", "double-hyphen-option")],
    [("docker", "command"), (" run", "subcommand"), (" --rm -it", "double-hyphen-option"), (" alpine:3.19", None)],
    [("grep", "command"), (" -i", "single-hyphen-option"), (" --count", "double-hyphen-option"),
     (' "pattern"', "double-quoted-argument"), (" ", None), ("*", "globbing"), (".md", "globbing-ext")],
    [("for", "reserved-word"), (" f ", "for-loop-variable"), ("in ", "reserved-word"), ("*.zsh", "globbing"),
     ("; ", "for-loop-separator"), ("do", "reserved-word"), (" wc", "command"), (" -l", "single-hyphen-option"),
     (" $f", "variable"), (";", "commandseparator"), (" done", "reserved-word")],
    [("size=", None), ("$", None), ("((", "double-paren"), ("4096", "mathnum"), (" + ", None),
     ("HISTSIZE", "mathvar"), ("))", "double-paren")],
    [("cat", "builtin"), (" <<<", "here-string-tri"), (' "hello ', "here-string-text"),
     ("$USER", "here-string-var"), ('"', "here-string-text")],
    [("make", "command"), (" ", None), ("2", "exec-descriptor"), (">", "redirection"), (" /dev/null", "path"),
     (" && ", "commandseparator"), ("echo", "builtin"), (" !!", "history-expansion")],
    [("invalidcommand", "unknown-token"), (" --typo", "double-hyphen-option"), ("=", None), ("/dev/null", "path")],
]


def load_styles(variant: str) -> dict[str, str]:
    """Flatten a theme INI into {style-key: value}."""
    ini = configparser.ConfigParser()
    ini.read(ROOT / "themes" / f"tokyonight-{variant}.ini")
    styles: dict[str, str] = {}
    for section in ini.sections():
        for key, value in ini.items(section):
            styles[key] = value.strip()
    return styles


def parse_style(value: str) -> tuple[str | None, str | None, bool, bool]:
    """Return (fg, bg, bold, underline) for an F-Sy-H style value."""
    fg = bg = None
    bold = underline = False
    for part in (p.strip() for p in value.split(",")):
        if not part or part == "none":
            continue
        if part == "bold":
            bold = True
        elif part == "underline":
            underline = True
        elif part in ("blink", "conceal", "reverse", "standout"):
            continue
        elif part.startswith("bg:"):
            bg = part[3:]
        else:
            fg = part
    return fg, bg, bold, underline


def esc(text: str) -> str:
    return html.escape(text, quote=True)


def render(variant: str) -> str:
    styles = load_styles(variant)
    chrome = CHROME[variant]

    default_fg = parse_style(styles.get("default", "none"))[0] or "#ffffff"
    widths = [sum(len(text) for text, _ in line) for line in DEMO]
    width = max(widths) * CHAR_W + 2 * PAD_X
    height = PAD_Y * 2 + TITLE_H + LINE_H * len(DEMO)

    parts: list[str] = []
    parts.append(
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width:.0f}" height="{height:.0f}" '
        f'viewBox="0 0 {width:.0f} {height:.0f}" font-family="{esc(FONT)}" font-size="{FONT_SIZE}">'
    )
    # window: title bar on bg_dark, editor body on the variant's own bg
    parts.append(f'<rect x="0" y="0" width="{width:.0f}" height="{height:.0f}" rx="10" fill="{chrome["bg_dark"]}"/>')
    # editor body with rounded bottom corners
    parts.append(
        f'<path d="M 0 {TITLE_H} H {width:.0f} V {height - 10:.0f} '
        f'Q {width:.0f} {height:.0f} {width - 10:.0f} {height:.0f} H 10 Q 0 {height:.0f} 0 {height - 10:.0f} Z" '
        f'fill="{chrome["bg"]}"/>'
    )
    # title bar dots
    dot_y = TITLE_H / 2 + 2
    for i, color in enumerate((chrome["red"], chrome["yellow"], chrome["green"])):
        parts.append(f'<circle cx="{PAD_X + i * (DOT_R * 3):.1f}" cy="{dot_y:.1f}" r="{DOT_R}" fill="{color}"/>')
    title = f"zsh — tokyonight-{variant}"
    parts.append(
        f'<text x="{width / 2:.1f}" y="{dot_y + FONT_SIZE * 0.36:.1f}" text-anchor="middle" '
        f'fill="{chrome["fg_dark"]}">{esc(title)}</text>'
    )

    body_top = TITLE_H + PAD_Y
    for line_no, line in enumerate(DEMO):
        base_y = body_top + line_no * LINE_H + FONT_SIZE
        x = PAD_X
        for text, style_key in line:
            fg, bg, bold, underline = (None, None, False, False)
            if style_key:
                fg, bg, bold, underline = parse_style(styles.get(style_key, ""))
            fg = fg or default_fg
            weight = " font-weight=\"bold\"" if bold else ""
            deco = " text-decoration=\"underline\"" if underline else ""

            if bg:
                span_w = len(text) * CHAR_W
                parts.append(
                    f'<rect x="{x:.1f}" y="{base_y - FONT_SIZE * 0.88:.1f}" width="{span_w:.1f}" '
                    f'height="{FONT_SIZE * 1.25:.1f}" fill="{bg}"/>'
                )
            parts.append(
                f'<text x="{x:.1f}" y="{base_y:.1f}" fill="{fg}"{weight}{deco} xml:space="preserve">{esc(text)}</text>'
            )
            x += len(text) * CHAR_W
    parts.append("</svg>")
    return "\n".join(parts)


def main() -> None:
    ASSETS.mkdir(exist_ok=True)
    for variant in VARIANTS:
        svg = render(variant)
        out = ASSETS / f"preview-{variant}.svg"
        out.write_text(svg, encoding="utf-8")
        print(f"wrote {out.relative_to(ROOT)} ({len(svg)} bytes)")


if __name__ == "__main__":
    main()
