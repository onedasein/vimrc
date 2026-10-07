#!/usr/bin/env bash
# ============================================================
# leaf-pane.sh —— 在 tmux 里为 Markdown 开一个 leaf 实时预览窗格
#
# 用法：
#   leaf-pane.sh <file.md>      在左侧新开一个水平窗格（焦点留在原地，推荐）
#   leaf-pane.sh -f <file.md>   同上，但焦点跳到预览窗格
#   leaf-pane.sh -w <file.md>   改为新开一个 tmux 窗口（不是窗格）
#
# 说明：
#   * leaf 以 --watch 启动，你在 vim 里 :w 保存后预览自动刷新
#   * 必须在 tmux 会话内运行；不在 tmux 里会给出提示并直接原地运行 leaf
#   * 窗格宽度可用 LEAF_PANE_SIZE 调整（默认 45%，即 45% 终端宽度）
# ============================================================
set -euo pipefail

MODE=pane
case "${1:-}" in
    -f|--focus) MODE=focus; shift ;;
    -w|--window) MODE=window; shift ;;
    -h|--help)
        sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'
        exit 0
        ;;
esac

FILE=${1:-}
if [ -z "$FILE" ]; then
    echo "usage: $(basename "$0") [-f|-w] <file.md>" >&2
    exit 1
fi

# 转绝对路径（leaf 与 tmux 的 cwd 可能不同）
if command -v realpath >/dev/null 2>&1; then
    FILE=$(realpath -- "$FILE")
else
    FILE=$(cd "$(dirname "$FILE")" && pwd)/$(basename "$FILE")
fi

if [ ! -f "$FILE" ]; then
    echo "leaf-pane: 文件不存在：$FILE" >&2
    exit 1
fi

if ! command -v leaf >/dev/null 2>&1; then
    echo "leaf-pane: 找不到 leaf（应在 ~/.local/bin/leaf）" >&2
    exit 1
fi

# printf %q 保证路径里的空格/特殊字符在 tmux 的子 shell 里也安全
CMD="leaf -w $(printf '%q' "$FILE")"
SIZE=${LEAF_PANE_SIZE:-45%}

if [ -z "${TMUX:-}" ]; then
    echo "leaf-pane: 不在 tmux 会话内，直接原地运行 leaf（Ctrl+C 退出）" >&2
    exec leaf -w "$FILE"
fi

case "$MODE" in
    pane)
        # -h 水平分割（左右），-d 不切焦点，-b 放在左侧
        tmux split-window -h -d -b -l "$SIZE" "$CMD"
        ;;
    focus)
        tmux split-window -h -b -l "$SIZE" "$CMD"
        ;;
    window)
        tmux new-window -n "leaf:$(basename "$FILE")" "$CMD"
        ;;
esac
