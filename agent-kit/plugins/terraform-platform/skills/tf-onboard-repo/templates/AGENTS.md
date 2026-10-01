# <repo-name>

<Одне речення: що в цьому репо (модулі / середовища / обидва), для якого продукту.>

## Layout
- Модулі (код): `<path>/<stage>/<service>/<name>/`
- Середовища (terragrunt): `<path>/<region>/<stage>/<service>/<name>/terragrunt.hcl`
- Спільні шаблони: `<path>/`
- Нумерація `.tf`: `00-init` (data/locals), `01-main`, `02..95` ресурси, `96-variables`, `99-outputs`
- Еталонний модуль: `<path>`
- Еталонне середовище: `<path>`

## Dependencies
- Механізм: <terraform_remote_state через locals.dependency | terragrunt dependency | ...>
- State: S3 `<bucket var>`, ключ `<region>/<stage>/<service>/<name>/terraform.tfstate`

## Versions
- Terraform / Terragrunt: з `.terraform-version` / `.terragrunt-version` сусідньої папки

## Validate
```sh
terraform fmt -recursive <modules-path>
terragrunt hclfmt
cd <env-dir> && terragrunt validate
```

## Forbidden
- `apply`, `destroy`, `state rm|mv|push`, `import` — тільки людина
- Не змінювати спільні шаблони без явного прохання

## Architecture
- ADR і обмеження: <~/code/architecture-kb | docs/architecture>
