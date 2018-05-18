#!/bin/bash

set -e

tmp_dir="$(dirname "$0")/../tmp"
[[ ! -d "$tmp_dir" ]] && mkdir -p "$tmp_dir"

usage_log_file="$(realpath "$tmp_dir/j4-dmenu-desktop-usage-log")"
j4-dmenu-desktop --usage-log="$usage_log_file" --display-binary                               130 ↵
