#!/usr/bin/env bash
set -euo pipefail

name="${1:-world}"

printf 'Hello, %s.\n' "$name"
printf 'This came from scripts/hello-script.sh\n'
