---
name: create-tf-environment
description: Підключає існуючий Terraform модуль у середовище/регіон через terragrunt.hcl — створює папку середовища, include шаблонів, source, inputs, файли версій. Використовуй для "задеплой модуль в <env/region>", "додай terragrunt для", "нове середовище для сервісу", "розгорни в eu-central-1". НЕ для написання коду ресурсів — для цього create-tf-module.
argument-hint: "<module-path> <region> [inputs]"
---

# Create Terragrunt environment entry

## 0. Контекст
Прочитай `AGENTS.md` (Layout, Versions). Знайди еталонний `terragrunt.hcl` поряд із цільовим місцем (той самий stage/service).

## 1. Вхідні дані
- Модуль (шлях у папці модулів), регіон/середовище, значення `inputs` для змінних модуля без дефолтів.
- Якщо регіону ще немає (немає `region.hcl` чи аналогу) — зупинись і спитай: новий регіон — окрема задача.

## 2. Кроки
1. Дзеркаль шлях модуля в дереві середовищ (stage/service/name збігаються).
2. Скопіюй `terragrunt.hcl` з еталону; зміни лише `terraform.source` та `inputs`. `include`/`generate` залишай як в еталоні.
3. Скопіюй `.terraform-version` і `.terragrunt-version` з сусідньої папки.
4. Переконайся, що модулі, від яких залежить цей (remote_state / dependency), вже існують у **цьому ж** регіоні.
5. Перевір унікальні значення, що можуть конфліктувати: імена ресурсів, listener rule priority, CIDR, порти.

## 3. Перевірка
`/terraform-platform:tf-validate` для нової папки. `plan` — тільки якщо користувач попросив і є доступ.

## 4. Звіт
Шлях, inputs, залежності; що треба перевірити людині перед `apply`.
