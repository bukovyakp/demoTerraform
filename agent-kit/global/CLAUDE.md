# Глобальні інструкції (→ ~/.claude/CLAUDE.md)

## Комунікація
- Відповідай українською; код, коміти, назви ресурсів — англійською.
- Коротко: висновок спочатку, деталі потім.

## Інфраструктура
- Ніколи не запускай `apply`, `destroy`, `import`, `state rm|mv|push` — тільки `plan`, і лише на прохання.
- Перед зміною Terraform/Terragrunt прочитай `AGENTS.md` репо. Немає — запропонуй `/terraform-platform:tf-onboard-repo`.
- Після змін `.tf`/`.hcl` — `/terraform-platform:tf-validate`.

## Архітектура
- База знань (constraints, principles, ADR, research): `~/code/architecture-kb`
- Перед порадою щодо вибору технології/сервісу — звір з constraints.md і accepted ADR.

## Git
- Коміти: Conventional Commits (`feat:`, `fix:`, `chore:`), тема ≤ 72 символи.
- Не пуш у main/master напряму.
