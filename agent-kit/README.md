# agent-kit

Особистий маркетплейс плагінів для Claude Code: спільні скіли, агенти й хуки для всіх репозиторіїв.

**Принцип:** у кіті лежить *метод* (як робити), у кожному репо лежать *факти* (тонкий `AGENTS.md` зі шляхами, командами й заборонами).

## Структура

```
.claude-plugin/marketplace.json     # маркетплейс "bukovyak-kit"
plugins/
  terraform-platform/               # реалізація інфраструктури
    skills/
      tf-onboard-repo/              # /…:tf-onboard-repo — AGENTS.md + settings для нового репо (лише вручну)
      create-tf-module/             # новий модуль у папці модулів
      create-tf-environment/        # підключення модуля в середовище/регіон (terragrunt.hcl)
      create-ecs-service/           # оркестратор: модуль + середовище + ALB-маршрут
      tf-validate/                  # fmt / hclfmt / validate / tflint / trivy (scripts/validate.sh)
    agents/tf-reviewer.md           # рев'ю дифу: безпека, state, конвенції, ADR
    hooks/                          # PreToolUse: блокує apply/destroy/import/state-зміни
  arch-research/                    # ресерч і архітектура
    skills/
      research-options/             # brief → варіанти (паралельні сабагенти) → порівняння
      write-adr/                    # фіксація рішення (лише вручну)
      architecture-review/          # рев'ю дизайну/PR на відповідність constraints та ADR
    agents/
      option-researcher.md          # досліджує один варіант
      devils-advocate.md            # критик рекомендації
global/CLAUDE.md                    # → ~/.claude/CLAUDE.md (особисті правила для всіх проєктів)
templates/architecture-kb/          # каркас окремого репо architecture-kb
scripts/
  install-local.sh                  # локальне встановлення на ПК
  validate-kit.sh                   # перевірка структури кіту (і в CI)
```

## Встановлення

### На ПК (усі проєкти)
```sh
git clone git@github.com:bukovyakp/agent-kit ~/code/agent-kit
bash ~/code/agent-kit/scripts/install-local.sh
```
Потім у Claude Code:
```
/plugin marketplace add ~/code/agent-kit
/plugin install terraform-platform@bukovyak-kit
/plugin install arch-research@bukovyak-kit
```
Маркетплейс з локального шляху підхоплює правки скілів без пушу, тому так зручно розробляти скіли.

### У репозиторії (хмарні сесії claude.ai/code, CI, колеги)
Запусти в репо `/terraform-platform:tf-onboard-repo`, або додай вручну `.claude/settings.json`:
```json
{
  "extraKnownMarketplaces": {
    "bukovyak-kit": { "source": { "source": "github", "repo": "bukovyakp/agent-kit" } }
  },
  "enabledPlugins": {
    "terraform-platform@bukovyak-kit": true,
    "arch-research@bukovyak-kit": true
  }
}
```
Плюс у репо потрібні `AGENTS.md` (факти) і `CLAUDE.md` з одним рядком `@AGENTS.md`.

> Для приватного репо `agent-kit` хмарна сесія / колега повинні мати до нього доступ на GitHub.

### База знань для архітектури
Скопіюй `templates/architecture-kb/` в окремий репо (`~/code/architecture-kb`), заповни `constraints.md` і `principles.md`. Шлях до неї вказаний у `global/CLAUDE.md` і в секції Architecture в `AGENTS.md` репозиторіїв.

## Використання
- Явно: `/terraform-platform:create-ecs-service billing ghcr.io/x/billing:1.0 8080 /billing/*`
- Природно: «додай сервіс billing за ALB на /billing» — агент сам вибирає скіл за `description`.
- `tf-onboard-repo` і `write-adr` запускаються **лише вручну** (`disable-model-invocation: true`).

## Як додати / тюнити скіл
1. `plugins/<plugin>/skills/<kebab-name>/SKILL.md`: frontmatter `name` = назва папки, `description` = *що робить + коли застосовувати + чим відрізняється від сусідніх скілів*.
2. Тіло — кроки, перевірка, заборони; до ~500 рядків. Довге — в `references/`, шаблони — в `templates/`, детерміновані кроки — в `scripts/`.
3. Посилайся на еталони в репо (через AGENTS.md), а не вставляй код у скіл.
4. `bash scripts/validate-kit.sh`
5. Перевір двома способами: явним викликом і природним запитом (чи підхопився сам).
6. Невдалий запуск → додай у скіл правило, яке б цьому запобігло. Підніми `version` у `plugin.json`.

## Сумісність
- Claude Code: плагіни (цей репо), `~/.claude/skills`, `.claude/skills`.
- GitHub Copilot: читає `.claude/skills/` і `AGENTS.md` у репо; плагіни Claude Code — ні. Для Copilot можна симлінкнути потрібні папки `skills/` у `.claude/skills/` репо.
