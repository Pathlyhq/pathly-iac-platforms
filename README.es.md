# Pathly en Spacelift, Env0 y Scalr

[English](README.md) · [Français](README.fr.md) · **Español**


[![Powered by Pathly](https://img.shields.io/badge/Powered%20by-Pathly-0B5FFF?style=flat-square)](https://pathlyhq.com)
[![Website](https://img.shields.io/badge/Website-pathlyhq.com-111827?style=flat-square)](https://pathlyhq.com)
[![API docs](https://img.shields.io/badge/API-developers-2563eb?style=flat-square)](https://pathlyhq.com/es/developers)
[![Start free](https://img.shields.io/badge/Solo-start%20free-16a34a?style=flat-square)](https://pathlyhq.com/es/login?mode=signup)

> **Empiece en un clic.** Cree una cuenta gratuita en [Pathly](https://pathlyhq.com) ([registro](https://pathlyhq.com/es/login?mode=signup)), genere una clave API en la consola y exporte `PATHLY_API_TOKEN`. Este repositorio es el puente oficial hacia [la monitorización Pathly](https://pathlyhq.com): comprobaciones HTTP y de navegador (carrito, login, disponibilidad), con datos en la UE. Referencia API: [pathlyhq.com/es/developers](https://pathlyhq.com/es/developers).

Ejecute el provider oficial Terraform / OpenTofu **[`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly)** en las tres plataformas IaC líderes — para que el monitoreo sintético [Pathly](https://pathlyhq.com), los objetivos SLA y los webhooks vivan junto a su estate cloud.

> Docs: [Pathly](https://pathlyhq.com) · [Developers (EN)](https://pathlyhq.com/en/developers) · [Developers (ES)](https://pathlyhq.com/es/developers)  
> La versión en inglés ([`README.md`](README.md) y `docs/*.md`) es la canónica.

## ¿Por qué Pathly + plataformas IaC?

[Pathly](https://pathlyhq.com) monitorea journeys de cliente (HTTP y navegador) desde varias regiones, sigue presupuestos de error y dispara webhooks ante fallos. Declarar recursos Pathly en Terraform permite:

- que el mismo PR que cambia un servicio actualice su sonda y su objetivo SLA
- que `PATHLY_API_TOKEN` permanezca en el almacén de secretos de la plataforma — nunca en git
- que planes y applies queden auditados por Spacelift, Env0 o Scalr

Referencia API completa: [pathlyhq.com/es/developers](https://pathlyhq.com/es/developers).

## Comparación de plataformas

| | [Spacelift](docs/es/spacelift.md) | [Env0](docs/es/env0.md) | [Scalr](docs/es/scalr.md) |
|---|---|---|---|
| **Fortaleza** | Policy-as-code, stacks, drift | Entornos, flujos custom | Workspaces, VCS, costes |
| **Secreto Pathly** | Secreto de entorno / contexto `PATHLY_API_TOKEN` | Variable de entorno (sensible) | Variable set / env workspace |
| **Provider** | `pathlyhq/pathly` `~> 0.1` | igual | igual |
| **Ejemplo** | [`examples/spacelift/`](examples/spacelift/) | [`examples/env0/`](examples/env0/) | [`examples/scalr/`](examples/scalr/) |

Las tres plataformas consumen el mismo provider Pathly. Elija la que ya ejecuta su Terraform y siga la guía:

1. [Spacelift + Pathly](docs/es/spacelift.md)
2. [Env0 + Pathly](docs/es/env0.md)
3. [Scalr + Pathly](docs/es/scalr.md)

## Inicio rápido (cualquier plataforma)

```hcl
terraform {
  required_providers {
    pathly = {
      source  = "pathlyhq/pathly"
      version = "~> 0.1"
    }
  }
}

# Token desde PATHLY_API_TOKEN — nunca una variable Terraform.
provider "pathly" {}

resource "pathly_scenario" "home" {
  name         = "Página de inicio"
  url          = "https://shop.example.com"
  interval_sec = 300
}
```

Cree un token de API en la [consola Pathly](https://pathlyhq.com) y guárdelo como **secreto** `PATHLY_API_TOKEN` en su plataforma. Detalles: [developers ES](https://pathlyhq.com/es/developers) · [developers EN](https://pathlyhq.com/en/developers).

## Seguridad

- Preferir inyección de entorno / secreto frente a `TF_VAR_*` para el token Pathly (las variables pueden acabar en el state).
- Usar scopes Pathly de menor privilegio para el stack que solo gestiona escenarios.
- Cifrar el remote state en la plataforma IaC.

## Más información

- Producto: [https://pathlyhq.com](https://pathlyhq.com)
- Developers EN: [https://pathlyhq.com/en/developers](https://pathlyhq.com/en/developers)
- Developers ES: [https://pathlyhq.com/es/developers](https://pathlyhq.com/es/developers)


## Paquetes relacionados

| Package | Role |
|---|---|
| [terraform-provider-pathly](https://github.com/Pathlyhq/terraform-provider-pathly) | Terraform / OpenTofu |
| [pathly-pulumi](https://github.com/pathlyhq/pathly-pulumi) | Pulumi |
| [pathly-cdktf](https://github.com/pathlyhq/pathly-cdktf) | CDK for Terraform |
| [pathly-crossplane](https://github.com/pathlyhq/pathly-crossplane) | Crossplane |
| [pathly-ansible](https://github.com/pathlyhq/pathly-ansible) | Ansible |
| [Pathly product](https://pathlyhq.com) | [Pathly monitoring](https://pathlyhq.com) |
## Acerca de Pathly

[Pathly](https://pathlyhq.com) es monitorización sintética para agencias y e-commerce: reproduce el recorrido del cliente, detecta un checkout roto antes de la llamada, y deja la prueba (captura, paso, runbook) lista para la factura. Producto: [pathlyhq.com](https://pathlyhq.com) · Desarrolladores: [pathlyhq.com/es/developers](https://pathlyhq.com/es/developers) · Precios: [pathlyhq.com/es/pricing](https://pathlyhq.com/es/pricing).

## Autor

| | |
|---|---|
| **Empresa** | Pathly |
| **Autor** | Simon Raynaud / keyral |

Ver [AUTHORS](AUTHORS).

## Licencia

Apache-2.0 — ver [LICENSE](LICENSE).
