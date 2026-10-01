---
name: create-ecs-service
description: Створює новий ECS Fargate сервіс "під ключ" — модуль (task definition, service, target group, listener rule на ALB) і його terragrunt-середовище. Використовуй для "новий сервіс в ECS", "задеплой контейнер", "додай мікросервіс за ALB на /path". Оркеструє create-tf-module і create-tf-environment.
argument-hint: "<name> <image> <port> <path-pattern> [region]"
---

# Create ECS service

## 1. Вхідні дані (спитай усе відсутнє одним повідомленням)
- `name` (kebab-case), `image`, `container_port`
- Маршрутизація: `path_pattern` та/або `host_header` на ALB
- Ресурси: cpu/memory (типово 256/512), desired count (типово 1)
- Health check path (типово `/health`)
- Регіон (типово — перший з AGENTS.md)
- Секрети/змінні середовища, доступ до інших сервісів (БД, S3, черги)

## 2. Кроки
1. Знайди існуючий ECS-сервіс у репо — це еталон (див. AGENTS.md). Звір із ним усе нижче.
2. Модуль → за `create-tf-module`: копія структури еталонного сервісу (task def, service, target group, listener rule, variables, outputs).
3. Listener rule priority: `grep -rn "priority" <modules> <envs>` — вибери вільний, не перетинайся з іншими правилами того самого listener.
4. IAM: task role з мінімальними правами під заявлені доступи; execution role — як в еталоні.
5. Логи: CloudWatch log group з retention як в еталоні.
6. Середовище → за `create-tf-environment`.

## 3. Перевірка
`/terraform-platform:tf-validate` для обох нових папок. Далі запусти агента `tf-reviewer` на змінені файли.

## 4. Звіт
Таблиця: що створено, шлях, URL-маршрут, priority, ролі. Список того, що людина має зробити (образ у реєстрі, секрети, `apply`).
