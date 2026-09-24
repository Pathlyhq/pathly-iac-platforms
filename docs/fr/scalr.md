# Pathly sur Scalr

[English](../scalr.md) · **Français** · [Español](../es/scalr.md)

Utilisez des workspaces [Scalr](https://scalr.com) avec le provider Terraform [Pathly](https://pathlyhq.com) pour garder le monitoring synthétique, les objectifs SLA et les webhooks sous le même workflow VCS que vos modules cloud.

> **Obtenir une clé API sur [pathlyhq.com](https://pathlyhq.com).** Inscription : [pathlyhq.com/fr/login?mode=signup](https://pathlyhq.com/fr/login?mode=signup). Créez un jeton dans la console, puis stockez-le comme variable d'environnement sensible `PATHLY_API_TOKEN` dans Scalr (jamais dans git ni en variable Terraform).

> [Accueil Pathly](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers FR](https://pathlyhq.com/fr/developers)  
> Code d'exemple : [`examples/scalr/`](../../examples/scalr/)  
> La version anglaise ([`scalr.md`](../scalr.md)) fait référence.

## Comparaison des plateformes

| | [Spacelift](spacelift.md) | [Env0](env0.md) | Scalr (ce guide) |
|---|---|---|---|
| **Point fort** | Policy-as-code, stacks, drift | Environnements, flux custom | Workspaces, VCS, coûts |
| **Secret** | Secret d'environnement / contexte `PATHLY_API_TOKEN` | Variable d'environnement sensible | Variable set / env workspace |
| **Exemple** | [`examples/spacelift/`](../../examples/spacelift/) | [`examples/env0/`](../../examples/env0/) | [`examples/scalr/`](../../examples/scalr/) |

## Prérequis

- Un compte Scalr avec droit de créer des workspaces
- Un jeton API [Pathly](https://pathlyhq.com) ([en créer un](https://pathlyhq.com/fr/developers))
- Une connexion VCS vers un dépôt contenant [`examples/scalr/`](../../examples/scalr/)

## 1. Créer un jeton API Pathly (pathlyhq.com)

1. Ouvrir [https://pathlyhq.com](https://pathlyhq.com) ([inscription](https://pathlyhq.com/fr/login?mode=signup) si besoin).
2. Créer un jeton API avec les portées correspondant aux ressources de l'exemple.
3. Le conserver pour le variable set Scalr.

![Placeholder capture : Pathly — jeton API pour Scalr](../assets/scalr-pathly-token.png)

Docs API : [EN](https://pathlyhq.com/en/developers) · [FR](https://pathlyhq.com/fr/developers).

## 2. Injecter `PATHLY_API_TOKEN` via un variable set

1. Dans Scalr, ouvrir **Variable sets** (ou l'onglet **Variables** du workspace).
2. Ajouter une variable **Environment** `PATHLY_API_TOKEN`.
3. La marquer **sensitive**.
4. Attacher le variable set au workspace qui exécute le Terraform Pathly.

![Placeholder capture : Scalr — variable d'environnement sensible](../assets/scalr-secret.png)

Le provider [`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly) s'authentifie depuis cette variable d'environnement. Ne pas mettre le jeton dans `terraform.tfvars` ni dans une variable Terraform Scalr non sensible.

## 3. Créer un workspace Scalr

1. **Workspaces → New**.
2. Connecter le VCS et définir le répertoire de travail sur `examples/scalr/`.
3. Attacher le variable set avec `PATHLY_API_TOKEN`.
4. Activer run triggers / auto-apply VCS selon votre politique.

![Placeholder capture : Scalr — réglages workspace](../assets/scalr-workspace.png)

## 4. Ressources de l'exemple

[`examples/scalr/`](../../examples/scalr/) provisionne des ressources de monitoring Pathly :

```hcl
provider "pathly" {}

resource "pathly_scenario" "api_health" { ... }
resource "pathly_sla_target" "api_slo" { ... }
resource "pathly_maintenance_window" "weekly" { ... }
resource "pathly_webhook" "ops" { ... }
```

Référence des champs : [pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers).

## 5. Plan / apply

1. Enfiler un run depuis Scalr (ou pousser sur la branche suivie).
2. Examiner le plan pour les ressources `pathly_*`.
3. Appliquer et vérifier dans la [console Pathly](https://pathlyhq.com).

![Placeholder capture : Scalr — apply avec le provider Pathly](../assets/scalr-apply.png)

## 6. Notes opérationnelles

- Utiliser les **environments** Scalr pour séparer jetons Pathly staging et production.
- Faire tourner `PATHLY_API_TOKEN` dans le variable set sans changer le HCL.
- Coupler avec OPA / policy checks pour que les workspaces de production déclarent toujours un objectif SLA Pathly.

## En savoir plus

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (FR)](https://pathlyhq.com/fr/developers)
- Guides associés : [Spacelift](spacelift.md) · [Env0](env0.md)
