# Pathly en Env0

[English](../env0.md) · [Français](../fr/env0.md) · **Español**

Conecte entornos [Env0](https://www.env0.com) al provider Terraform de [Pathly](https://pathlyhq.com) y gestione el monitoreo sintético en el ciclo de vida de cada entorno.

> **Obtenga una clave API en [pathlyhq.com](https://pathlyhq.com).** Registro: [pathlyhq.com/es/login?mode=signup](https://pathlyhq.com/es/login?mode=signup). Cree un token en la consola y guárdelo como variable de entorno sensible `PATHLY_API_TOKEN` en Env0 (nunca en git ni en variables Terraform).

> [Inicio Pathly](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers ES](https://pathlyhq.com/es/developers)  
> Código de ejemplo: [`examples/env0/`](../../examples/env0/)  
> La versión en inglés ([`env0.md`](../env0.md)) es la canónica.

## Comparación de plataformas

| | [Spacelift](spacelift.md) | Env0 (esta guía) | [Scalr](scalr.md) |
|---|---|---|---|
| **Fortaleza** | Policy-as-code, stacks, drift | Entornos, flujos custom | Workspaces, VCS, costes |
| **Secreto** | Secreto de entorno / contexto `PATHLY_API_TOKEN` | Variable de entorno sensible | Variable set / env workspace |
| **Ejemplo** | [`examples/spacelift/`](../../examples/spacelift/) | [`examples/env0/`](../../examples/env0/) | [`examples/scalr/`](../../examples/scalr/) |

## Requisitos previos

- Una organización Env0 con proyecto y permisos de plantillas
- Un token de API [Pathly](https://pathlyhq.com) ([desarrolladores](https://pathlyhq.com/es/developers))
- Acceso Git a un repo que incluya [`examples/env0/`](../../examples/env0/)

## 1. Crear un token de API Pathly (pathlyhq.com)

1. Inicie sesión en [pathlyhq.com](https://pathlyhq.com) ([registro](https://pathlyhq.com/es/login?mode=signup) si hace falta).
2. Cree un token con los scopes que exijan sus recursos Terraform.
3. Guarde el valor para el paso de secreto en Env0.

![Marcador de captura: Pathly — token de API](../assets/env0-pathly-token.png)

Guías: [EN developers](https://pathlyhq.com/en/developers) · [ES developers](https://pathlyhq.com/es/developers).

## 2. Añadir `PATHLY_API_TOKEN` como variable de entorno sensible

1. En Env0, abra su **Project** o **Environment**.
2. Vaya a **Variables**.
3. Añada `PATHLY_API_TOKEN` como **Environment variable**.
4. Active **Sensitive** para que el valor quede redactado en los logs.
5. Limítela a los entornos que gestionan recursos Pathly.

![Marcador de captura: Env0 — variable de env sensible](../assets/env0-secret.png)

El provider Pathly toma `PATHLY_API_TOKEN` sin argumentos de provider. Evite patrones `TF_VAR_pathly_token` que escriben secretos en el state.

## 3. Crear una plantilla y un entorno

1. **Templates → Create** apuntando a `examples/env0/` en su repo.
2. Elija Terraform u OpenTofu.
3. Cree un **Environment** desde esa plantilla.
4. Confirme que `PATHLY_API_TOKEN` se hereda.

![Marcador de captura: Env0 — plantilla / entorno](../assets/env0-environment.png)

## 4. Qué despliega el ejemplo

[`examples/env0/`](../../examples/env0/) usa `pathlyhq/pathly` `~> 0.1` para crear:

| Recurso | Propósito |
|----------|---------|
| `pathly_scenario` | Comprobación HTTP del servicio bajo prueba |
| `pathly_sla_target` | Objetivo de disponibilidad rodante |
| `pathly_webhook` | Notificaciones de fallo |
| `pathly_maintenance_window` | Ventana de silencio planificada |

Esquema de recursos: [pathlyhq.com/es/developers](https://pathlyhq.com/es/developers).

## 5. Desplegar

1. Ejecute **Deploy** en el entorno Env0.
2. Apruebe el plan si su proyecto lo exige.
3. Abra [Pathly](https://pathlyhq.com) y confirme que el escenario está habilitado.

![Marcador de captura: Env0 — deploy correcto](../assets/env0-deploy.png)

## 6. Consejos de ciclo de vida

- Destruir el entorno Env0 elimina los recursos Pathly gestionados por el state — ideal para previews efímeros.
- Comparta un token Pathly de solo lectura para roles plan-only cuando sea posible.
- Documente la rotación del token junto a la configuración del proyecto Env0.

## Más información

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (ES)](https://pathlyhq.com/es/developers)
- Guías hermanas: [Spacelift](spacelift.md) · [Scalr](scalr.md)
