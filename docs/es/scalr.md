# Pathly en Scalr

[English](../scalr.md) · [Français](../fr/scalr.md) · **Español**

Use workspaces de [Scalr](https://scalr.com) con el provider Terraform de [Pathly](https://pathlyhq.com) para mantener el monitoreo sintético, los objetivos SLA y los webhooks bajo el mismo flujo VCS que sus módulos cloud.

> **Obtenga una clave API en [pathlyhq.com](https://pathlyhq.com).** Registro: [pathlyhq.com/es/login?mode=signup](https://pathlyhq.com/es/login?mode=signup). Cree un token en la consola y guárdelo como variable de entorno sensible `PATHLY_API_TOKEN` en Scalr (nunca en git ni en variables Terraform).

> [Inicio Pathly](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers ES](https://pathlyhq.com/es/developers)  
> Código de ejemplo: [`examples/scalr/`](../../examples/scalr/)  
> La versión en inglés ([`scalr.md`](../scalr.md)) es la canónica.

## Comparación de plataformas

| | [Spacelift](spacelift.md) | [Env0](env0.md) | Scalr (esta guía) |
|---|---|---|---|
| **Fortaleza** | Policy-as-code, stacks, drift | Entornos, flujos custom | Workspaces, VCS, costes |
| **Secreto** | Secreto de entorno / contexto `PATHLY_API_TOKEN` | Variable de entorno sensible | Variable set / env workspace |
| **Ejemplo** | [`examples/spacelift/`](../../examples/spacelift/) | [`examples/env0/`](../../examples/env0/) | [`examples/scalr/`](../../examples/scalr/) |

## Requisitos previos

- Una cuenta Scalr con permiso para crear workspaces
- Un token de API [Pathly](https://pathlyhq.com) ([crear uno](https://pathlyhq.com/es/developers))
- Una conexión VCS a un repositorio que contenga [`examples/scalr/`](../../examples/scalr/)

## 1. Crear un token de API Pathly (pathlyhq.com)

1. Abra [https://pathlyhq.com](https://pathlyhq.com) ([registro](https://pathlyhq.com/es/login?mode=signup) si hace falta).
2. Cree un token de API con scopes alineados a los recursos del ejemplo.
3. Guárdelo para el variable set de Scalr.

![Marcador de captura: Pathly — token de API para Scalr](../assets/scalr-pathly-token.png)

Docs API: [EN](https://pathlyhq.com/en/developers) · [ES](https://pathlyhq.com/es/developers).

## 2. Inyectar `PATHLY_API_TOKEN` mediante un variable set

1. En Scalr, abra **Variable sets** (o la pestaña **Variables** del workspace).
2. Añada una variable **Environment** `PATHLY_API_TOKEN`.
3. Márquela **sensitive**.
4. Adjunte el variable set al workspace que ejecuta el Terraform Pathly.

![Marcador de captura: Scalr — variable de entorno sensible](../assets/scalr-secret.png)

El provider [`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly) se autentica desde esa variable de entorno. No ponga el token en `terraform.tfvars` ni en una variable Terraform de Scalr no sensible.

## 3. Crear un workspace Scalr

1. **Workspaces → New**.
2. Conecte VCS y fije el directorio de trabajo en `examples/scalr/`.
3. Adjunte el variable set con `PATHLY_API_TOKEN`.
4. Active run triggers / auto-apply VCS según su política.

![Marcador de captura: Scalr — ajustes del workspace](../assets/scalr-workspace.png)

## 4. Recursos del ejemplo

[`examples/scalr/`](../../examples/scalr/) aprovisiona recursos de monitoreo Pathly:

```hcl
provider "pathly" {}

resource "pathly_scenario" "api_health" { ... }
resource "pathly_sla_target" "api_slo" { ... }
resource "pathly_maintenance_window" "weekly" { ... }
resource "pathly_webhook" "ops" { ... }
```

Referencia de campos: [pathlyhq.com/es/developers](https://pathlyhq.com/es/developers).

## 5. Ejecutar plan / apply

1. Encole un run desde Scalr (o haga push a la rama seguida).
2. Revise el plan de recursos `pathly_*`.
3. Aplique y verifique en la [consola Pathly](https://pathlyhq.com).

![Marcador de captura: Scalr — apply con el provider Pathly](../assets/scalr-apply.png)

## 6. Notas operativas

- Use **environments** de Scalr para separar tokens Pathly de staging y producción.
- Rote `PATHLY_API_TOKEN` en el variable set sin cambiar el HCL.
- Combine con OPA / policy checks para que los workspaces de producción declaren siempre un objetivo SLA Pathly.

## Más información

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (ES)](https://pathlyhq.com/es/developers)
- Guías hermanas: [Spacelift](spacelift.md) · [Env0](env0.md)
