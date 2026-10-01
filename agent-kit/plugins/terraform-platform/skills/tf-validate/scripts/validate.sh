#!/usr/bin/env bash
# Usage: validate.sh <dir> [<dir> ...]
# Runs format and static checks for Terraform/Terragrunt dirs. Missing tools are skipped.
set -u
rc=0
have() { command -v "$1" >/dev/null 2>&1; }
run() { echo "  \$ $*"; "$@" || { echo "  -> FAIL"; rc=1; }; }

[ $# -eq 0 ] && { echo "usage: $0 <dir> [<dir> ...]"; exit 2; }

for d in "$@"; do
  echo "== $d"
  [ -d "$d" ] || { echo "  not a directory, skipped"; continue; }
  if ls "$d"/*.tf >/dev/null 2>&1; then
    if have terraform; then run terraform fmt -check -diff "$d"; else echo "  terraform: not installed, skipped"; fi
    if have tflint; then (cd "$d" && run tflint --init >/dev/null && run tflint); fi
    if have trivy; then run trivy config --quiet --exit-code 1 "$d"; fi
  fi
  if [ -f "$d/terragrunt.hcl" ]; then
    if have terragrunt; then
      (cd "$d" && run terragrunt hclfmt --check)
      (cd "$d" && run terragrunt validate)
    else
      echo "  terragrunt: not installed, skipped"
    fi
  elif ls "$d"/*.tf >/dev/null 2>&1 && have terraform; then
    (cd "$d" && run terraform init -backend=false -input=false >/dev/null && run terraform validate)
  fi
done
exit $rc
