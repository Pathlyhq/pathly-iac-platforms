# Pathly en Spacelift

[English](../spacelift.md) · [Français](../fr/spacelift.md) · **Español**

Conecte stacks de [Spacelift](https://spacelift.io) al provider Terraform de [Pathly](https://pathlyhq.com) para que el monitoreo sintético siga su infrastructure as code.

> **Obtenga una clave API en [pathlyhq.com](https://pathlyhq.com).** Registro: [pathlyhq.com/es/login?mode=signup](https://pathlyhq.com/es/login?mode=signup). Cree un token en la consola y guárdelo como secreto `PATHLY_API_TOKEN` en Spacelift (nunca en git ni en variables Terraform).

> [Inicio Pathly](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers ES](https://pathlyhq.com/es/developers)  
> Código de ejemplo: [`examples/spacelift/`](../../examples/spacelift/)  
> La versión en inglés ([`spacelift.md`](../spacelift.md)) es la canónica.

## Comparación de plataformas

| | Spacelift (esta guía) | [Env0](env0.md) | [Scalr](scalr.md) |
|---|---|---|---|
| **Fortaleza** | Policy-as-code, stacks, drift | Entornos, flujos custom | Workspaces, VCS, costes |
| **Secreto** | Secreto de entorno / contexto `PATHLY_API_TOKEN` | Variable de entorno sensible | Variable set / env workspace |
| **Ejemplo** | [`examples/spacelift/`](../../examples/spacelift/) | [`examples/env0/`](../../examples/env0/) | [`examples/scalr/`](../../examples/scalr/) |

## Requisitos previos

- Una cuenta Spacelift con permiso para crear stacks y contexts
- Una organización [Pathly](https://pathlyhq.com) y un token de API ([cómo crear un token](https://pathlyhq.com/es/developers))
- Un repositorio VCS con el Terraform de esta guía (o una ruta local montada para workers privados)

## 1. Crear un token de API Pathly (pathlyhq.com)

1. Abra la [consola Pathly](https://pathlyhq.com) ([registro](https://pathlyhq.com/es/login?mode=signup) si hace falta).
2. Cree un token de API con scopes para escenarios, webhooks, ventanas de mantenimiento y objetivos SLA.
3. Copie el token una sola vez — Spacelift lo guardará como secreto.

![Marcador de captura: consola Pathly — crear token de API](../assets/spacelift-pathly-token.png)

Véase también: [pathlyhq.com/en/developers](https://pathlyhq.com/en/developers) y [pathlyhq.com/es/developers](https://pathlyhq.com/es/developers).

## 2. Guardar `PATHLY_API_TOKEN` en Spacelift

1. En Spacelift, abra **Contexts** (o la pestaña **Environment** del stack).
2. Añada una variable de entorno llamada `PATHLY_API_TOKEN`.
3. Márquela como **secret**.
4. Adjunte el context al stack que gestionará los recursos Pathly.

![Marcador de captura: Spacelift — variable de entorno secreta](../assets/spacelift-secret.png)

El provider [`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly) lee `PATHLY_API_TOKEN` automáticamente. **No** pase el token por una variable Terraform (se almacenaría en el state).

## 3. Crear un stack Spacelift

1. **Stacks → Create stack**.
2. Apunte el stack a la ruta `examples/spacelift/` del repositorio (o su fork).
3. Configure el workflow Terraform / OpenTofu como de costumbre.
4. Adjunte el context que contiene `PATHLY_API_TOKEN`.
5. Opcional: active la detección de drift para que los cambios en la consola Pathly aparezcan como drift.

![Marcador de captura: Spacelift — crear stack](../assets/spacelift-stack.png)

## 4. Diseño Terraform

El ejemplo en [`examples/spacelift/`](../../examples/spacelift/) declara:

- `pathly_scenario` — sonda HTTP para una URL crítica
- `pathly_sla_target` — objetivo de disponibilidad
- `pathly_maintenance_window` — periodo de silencio semanal
- `pathly_webhook` — destino de alertas

Bloque provider (sin credenciales en el HCL):

```hcl
provider "pathly" {}
```

Referencia completa de campos: [desarrolladores Pathly](https://pathlyhq.com/es/developers).

## 5. Plan y apply

1. Dispare un run desde Spacelift (o haga push a la rama seguida).
2. Revise el plan: los recursos Pathly aparecen como `pathly_*`.
3. Confirme el apply.
4. En la [consola Pathly](https://pathlyhq.com), verifique el escenario y el objetivo SLA.

![Marcador de captura: Spacelift — apply correcto con recursos pathly](../assets/spacelift-apply.png)

## 6. Policies y consejos

- Use **policies** de Spacelift para exigir un escenario Pathly cuando se cree un servicio de producción.
- Mantenga los tokens Pathly en un context dedicado, compartido solo por stacks de monitoreo (menor privilegio).
- Prefiera OpenTofu o Terraform `>= 1.6` con el provider `pathlyhq/pathly` `~> 0.1`.

## Más información

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (ES)](https://pathlyhq.com/es/developers)
- Guías hermanas: [Env0](env0.md) · [Scalr](scalr.md)
