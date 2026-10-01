---
name: tf-validate
description: Перевіряє Terraform/Terragrunt зміни — fmt, hclfmt, validate, tflint/trivy якщо встановлені — для заданих папок або всіх змінених у git. Використовуй після будь-якої зміни .tf/.hcl, для "перевір", "провалідуй", "чи все ок з terraform".
argument-hint: "[path ...]"
allowed-tools: Bash(bash *validate.sh*), Bash(terraform fmt*), Bash(terragrunt hclfmt*), Bash(git diff*), Bash(git status*)
---

# Validate Terraform changes

1. Визнач папки: аргументи, або змінені у git (`git status --porcelain` → унікальні директорії з `.tf`/`.hcl`).
2. Запусти скрипт поряд із цим SKILL.md:
   ```sh
   bash <this-skill-dir>/scripts/validate.sh <dir> [<dir> ...]
   ```
   Він робить `terraform fmt -check`, `terragrunt hclfmt --check`, `validate` і, якщо встановлені, `tflint` та `trivy config`. Відсутні інструменти пропускає з попередженням.
3. Якщо в AGENTS.md репо є секція Validate з іншими командами — вони мають пріоритет.
4. Форматування виправляй сам (`terraform fmt`, `terragrunt hclfmt`). Помилки validate/lint — виправ, якщо вони в твоїх змінах; якщо в чужому коді — лише повідом.
5. `validate` може впасти через відсутній доступ до backend/провайдера (немає AWS credentials) — це не помилка коду, так і напиши.

Звіт: таблиця папка × перевірка → ok / fixed / fail (причина) / skipped.
