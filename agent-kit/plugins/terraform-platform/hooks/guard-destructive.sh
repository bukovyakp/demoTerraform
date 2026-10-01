#!/usr/bin/env bash
# PreToolUse hook: blocks destructive Terraform/Terragrunt commands.
# Input: hook JSON on stdin. Exit 2 = block, stderr is shown to the agent.
input="$(cat)"

pattern='(terraform|terragrunt)[^"]*[[:space:]](apply|destroy|import)([[:space:]"]|$)|(terraform|terragrunt)[^"]*[[:space:]]state[[:space:]]+(rm|mv|push|replace-provider)|(terraform|terragrunt)[^"]*[[:space:]]force-unlock'

if printf '%s' "$input" | grep -Eq "$pattern"; then
  echo "Blocked by terraform-platform: apply/destroy/import/state changes are run by a human only. Run 'plan' and show the result instead." >&2
  exit 2
fi
exit 0
