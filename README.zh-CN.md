# tokyonight.zsh-fsh

[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![zsh](https://img.shields.io/badge/zsh-%E2%89%A5%205.7-blue.svg)](https://www.zsh.org/)
[![Variants](https://img.shields.io/badge/variants-4-7aa2f7.svg)](#变体)

[English](README.md) | **简体中文**

**[Fast Syntax Highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)（F-Sy-H）的 Tokyo Night 主题。**

tokyonight.zsh-fsh 把 [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) 的四种配色 —— `night`、`storm`、`moon`、`day` —— 完整带到 zsh 命令行。F-Sy-H 暴露的每一个样式键都映射到了对应的 Tokyo Night 调色板 token，使用精确的真彩色（truecolor）。

<p align="center">
  <img src="assets/preview-night.svg" alt="Tokyo Night night 预览" width="720">
</p>

| storm | moon | day |
| :---: | :---: | :---: |
| ![Tokyo Night storm 预览](assets/preview-storm.svg) | ![Tokyo Night moon 预览](assets/preview-moon.svg) | ![Tokyo Night day 预览](assets/preview-day.svg) |

## 特性

- **四种变体** —— `night`、`storm`、`moon`、`day`，色值直接取自 tokyonight.nvim 官方调色板。
- **完整覆盖** —— F-Sy-H 的全部 59 个样式键均已配色：命令、内建命令、保留字、别名、路径、glob、选项、字符串、字符串内转义/变量、变量、数学运算、`for` 循环、`case`、heredoc/here-string、重定向、历史展开、括号匹配、递归高亮（secondary 主题）等。
- **真彩色** —— 颜色以 `#rrggbb` 书写；在支持 truecolor 的终端上精确呈现，否则由 zsh 自动降级到最接近的 256 色。
- **语义对应而非凭感觉配色** —— 每个 F-Sy-H 样式键都对应到 tokyonight.nvim 中语义相同的高亮组（见[映射表](#颜色映射)），让 shell 和编辑器观感一致。

## 环境要求

- [Fast Syntax Highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)（下称 fsh）。
- zsh **≥ 5.7**（行编辑器支持真彩色）；更老的 zsh 无法解析 `fg=#rrggbb` 样式。
- 建议使用支持 truecolor 的终端（现代终端基本都支持）。

在 shell 里检查 truecolor 支持：

```zsh
print -P '%F{#7aa2f7}这行文字必须是蓝色%f'
```

## 安装

### 方式一 —— 安装脚本（推荐）

```zsh
git clone https://github.com/b1nhack/tokyonight.zsh-fsh.git
cd tokyonight.zsh-fsh
./install.sh night    # night | storm | moon | day
```

脚本会把**四种**变体都复制到 `~/.config/fsh/`；如果当前 shell 已加载 fsh，还会立即激活所选主题。

### 方式二 —— 手动

```zsh
mkdir -p ~/.config/fsh
cp themes/tokyonight-night.ini ~/.config/fsh/
```

然后在任何加载了 fsh 的 shell 里激活：

```zsh
fast-theme XDG:tokyonight-night
```

也可以不复制，直接指定文件路径：

```zsh
fast-theme /path/to/tokyonight.zsh-fsh/themes/tokyonight-night.ini
```

### 持久化

fsh 会把当前主题持久化到 `$FAST_WORK_DIR`，所以 `fast-theme` 只需执行**一次**，重启终端后依然生效。如果喜欢在 `~/.zshrc` 里显式声明，在加载插件之后追加：

```zsh
# 加载 fast-syntax-highlighting 之后
fast-theme -q XDG:tokyonight-night
```

fsh 会缓存处理好的主题（`current_theme.zsh` + `.zwc`），每次启动的开销可以忽略不计。

## 变体

| 主题 | 背景色 | 适用场景 |
| :-- | :-- | :-- |
| `tokyonight-night` | `#1a1b26` | 默认款：干净、深邃的暗蓝夜色 |
| `tokyonight-storm` | `#24283b` | 更柔和的蓝灰风暴 |
| `tokyonight-moon` | `#222436` | 饱和度更高的「月光」色 |
| `tokyonight-day` | `#e1e2e7` | 浅色变体，适合明亮环境 |

随时切换 —— 切换只是再跑一次 `fast-theme`：

```zsh
fast-theme XDG:tokyonight-storm
```

## 颜色映射

F-Sy-H 样式键与 tokyonight.nvim 高亮组的对应关系（各变体的具体色值）：

| F-Sy-H 样式 | tokyonight.nvim token | night | storm | moon | day |
| :-- | :-- | --: | --: | --: | --: |
| `default` | 前景色 | `#c0caf5` | `#c0caf5` | `#c8d3f5` | `#3760bf` |
| `unknown-token`、`matherr` | `red` / `error` | `#f7768e` | `#f7768e` | `#ff757f` | `#f52a65` |
| `command`、`single-sq-bracket` | `blue`（Function） | `#7aa2f7` | `#7aa2f7` | `#82aaff` | `#2e7de9` |
| `builtin`、`function`、`alias`、`subcommand`、`precommand`、`back-quoted-argument` | `blue1`（@function.builtin） | `#2ac3de` | `#2ac3de` | `#65bcff` | `#188092` |
| `reserved-word`、`double-paren`、`double-sq-bracket`、`for-loop-operator`、`globbing` | `magenta`（@keyword.control） | `#bb9af7` | `#bb9af7` | `#c099ff` | `#9854f1` |
| `single-`/`double-`/`dollar-quoted-argument`、`optarg-string` | `green`（String） | `#9ece6a` | `#9ece6a` | `#c3e88d` | `#587539` |
| `variable`、`here-string-var`、`case-input` | `yellow`（@variable.parameter） | `#e0af68` | `#e0af68` | `#ffc777` | `#8c6c3e` |
| `path`、`path-to-dir`、`single-`/`double-hyphen-option` | `cyan` | `#7dcfff` | `#7dcfff` | `#86e1fc` | `#007197` |
| `commandseparator`、`redirection`、`here-string-tri`、`for-loop-separator`、`case-parentheses`、`assign-array-bracket` | `blue5`（@operator） | `#89ddff` | `#89ddff` | `#89ddff` | `#006a83` |
| `mathnum`、`for-loop-number`、`exec-descriptor`、`history-expansion`、`optarg-number` | `orange`（@number） | `#ff9e64` | `#ff9e64` | `#ff966c` | `#b15c00` |
| `comment` | `comment` | `#565f89` | `#565f89` | `#636da6` | `#848cb5` |
| `bracket-level-1` | 彩虹 `blue` + 粗体 | `#7aa2f7` | `#7aa2f7` | `#82aaff` | `#2e7de9` |
| `bracket-level-2` | 彩虹 `yellow` + 粗体 | `#e0af68` | `#e0af68` | `#ffc777` | `#8c6c3e` |
| `bracket-level-3` | 彩虹 `green` + 粗体 | `#9ece6a` | `#9ece6a` | `#c3e88d` | `#587539` |
| `paired-bracket`（背景） | `bg_search` | `#3d59a1` | `#3d59a1` | `#3e68d7` | `#7890dd` |
| `case-condition`（背景） | `bg_visual` | `#283457` | `#2e3c64` | `#2d3f76` | `#b7c1e3` |
| `subtle-bg`、`here-string-text`（背景） | `bg_highlight` | `#292e42` | `#292e42` | `#2f334d` | `#c4c8da` |
| `incorrect-subtle`（背景） | `diff.delete` | `#4a272f` | `#52313f` | `#4b2a3d` | `#dababe` |
| `mathvar` | `blue` + 粗体 | `#7aa2f7` | `#7aa2f7` | `#82aaff` | `#2e7de9` |

完整定义见 [themes/](themes) 目录下的 INI 文件。

## 自定义

### zsh-autocomplete 集成

zsh-autocomplete 默认把补全列表里的 `common substring:` 条目画成 ANSI color 11 上的黑字——在 Tokyo Night 配色下几乎不可见。本仓库提供了现成的重定义（安装到 `~/.config/fsh/extras/zsh-autocomplete/`）：

```zsh
source ~/.config/fsh/extras/zsh-autocomplete/tokyonight-night.zsh
```

把这行加在加载 zsh-autocomplete 之后，并与当前使用的变体保持一致。标签变为蓝色粗体，公共子串使用主题的 search 语义（前景于 `bg_search` 上）。

> **注意**：上下文必须写 `:completion:*:unambiguous`——zsh-autocomplete 自己的 README 写的是 `:autocomplete:*:unambiguous`，那个模式匹配不上、会被静默忽略。另一个已知限制：历史行列表里命中文本的高亮是上游硬编码（黑字亮黄底，见 `_autocomplete__history_lines` 的 `_comp_colors`），没有任何定制入口。

### Overlay（微调少量样式）

不必复制整个主题再改 —— 用 fsh 的 [overlay 机制](https://github.com/zdharma-continuum/fast-syntax-highlighting/blob/master/THEME_GUIDE.md)。创建 `~/.config/fsh/overlay.ini`：

```ini
; overlay.ini —— 叠加在当前主题之上
[base]
comment = #4a557f

[command-point]
command = #89b4fa
```

应用（注意文件名必须包含 *overlay*）：

```zsh
fast-theme XDG:overlay
```

### 递归高亮

在 `$( ... )` 和 `eval` 参数内部，fsh 会切换到 *secondary* 主题，让嵌套代码看起来不同。本主题使用内置的 **`zdharma`**（冷色调蓝紫，和 Tokyo Night 很搭）。想换成别的（比如 `clean`）？往 overlay 里加：

```ini
[base]
secondary = clean
```

如果四种变体都安装了，也可以用另一个 Tokyo Night 变体（`secondary = tokyonight-moon`）。

## 常见问题

- **报错 `cannot parse style …: unknown color`** —— zsh 低于 5.7，不认识 `#rrggbb` 样式。请升级 zsh，或把 INI 里的色值改成 256 色编号（`fast-theme -p` 可打印色板）。
- **颜色发灰/不准** —— 终端不支持 truecolor，zsh 只能近似渲染。用上面的 `print -P` 命令验证，并检查 `$COLORTERM`。
- **实时预览** —— `fast-theme -t XDG:tokyonight-night` 会切换主题并打印覆盖各类样式的演示代码块。
- **从头再来** —— `fast-theme -r` 清除已设主题（之后重启 shell）。

## 重新生成预览图

预览图是根据主题文件本身生成的 SVG：

```zsh
python3 scripts/generate_previews.py   # 输出 assets/preview-*.svg
```

## 致谢与许可

- 调色板：[folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) —— Apache License 2.0，已注明出处；见 [LICENSE](LICENSE)。
- 主题格式、`fast-theme` 及 fsh 本体：[zdharma-continuum/fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) —— BSD-3-Clause。
- 本仓库代码：MIT.
