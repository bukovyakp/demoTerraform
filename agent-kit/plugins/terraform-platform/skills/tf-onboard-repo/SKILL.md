---
name: tf-onboard-repo
description: Готує Terraform/Terragrunt репозиторій до роботи з агентом — сканує структуру і створює тонкий AGENTS.md (Layout, Dependencies, Validate, Forbidden), CLAUDE.md з імпортом і .claude/settings.json з підключенням плагінів bukovyak-kit. Використовуй для "онборд репо", "підготуй репозиторій для агента", "створи AGENTS.md".
disable-model-invocation: true
---

# Onboard Terraform repo

Мета: глобальні скіли знають *метод*, а `AGENTS.md` репозиторію — *факти*. Цей скіл створює `AGENTS.md`.

## 1. Розвідка (тільки читання)
- Дерево верхнього рівня і 2–3 рівні вглиб: де модулі (`*.tf` без `terragrunt.hcl`), де середовища (`terragrunt.hcl`), де спільні шаблони (`*.hcl` з `generate`/`locals`).
- Конвенція імен і нумерації `.tf`-файлів (напр. `00-init`, `01-main`, `96-variables`, `99-outputs`).
- Як модулі отримують залежності: `dependency` блоки terragrunt, `terraform_remote_state`, SSM, data sources.
- Backend і state: бакет, ключі, профілі. Звідки беруться `region`, `profile` (напр. `region.hcl`).
- Версії: `.terraform-version`, `.terragrunt-version`, `required_providers`.
- CI (`.github/workflows`, `atlantis.yaml` тощо): які перевірки вже запускаються.
- Знайди 1–2 **еталонні** модулі/середовища, з яких найкраще копіювати нові.

## 2. Згенеруй файли
За шаблонами з `templates/` поряд із цим SKILL.md:
- `AGENTS.md` ← `templates/AGENTS.md`. Тільки факти, підтверджені в коді; невідоме позначай `TODO:` і питай користувача.
- `CLAUDE.md` ← один рядок `@AGENTS.md` (якщо CLAUDE.md вже існує — додай рядок, нічого не видаляй).
- `.claude/settings.json` ← `templates/settings.json` (якщо існує — злий ключі, не перезаписуй).

## 3. Підсумок
Покажи користувачу список `TODO:` у згенерованому AGENTS.md — їх треба заповнити людині.

## Правила
- Не вигадуй: кожен пункт Layout має відповідати реальному шляху в репо.
- AGENTS.md — до ~80 рядків. Довгі пояснення не потрібні, лише шляхи, команди, заборони.
