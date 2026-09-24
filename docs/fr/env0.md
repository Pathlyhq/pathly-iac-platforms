# Pathly sur Env0

[English](../env0.md) · **Français** · [Español](../es/env0.md)

Branchez des environnements [Env0](https://www.env0.com) au provider Terraform [Pathly](https://pathlyhq.com) et gérez le monitoring synthétique dans le cycle de vie de chaque environnement.

> **Obtenir une clé API sur [pathlyhq.com](https://pathlyhq.com).** Inscription : [pathlyhq.com/fr/login?mode=signup](https://pathlyhq.com/fr/login?mode=signup). Créez un jeton dans la console, puis stockez-le comme variable d'environnement sensible `PATHLY_API_TOKEN` dans Env0 (jamais dans git ni en variable Terraform).

> [Accueil Pathly](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers FR](https://pathlyhq.com/fr/developers)  
> Code d'exemple : [`examples/env0/`](../../examples/env0/)  
> La version anglaise ([`env0.md`](../env0.md)) fait référence.

## Comparaison des plateformes

| | [Spacelift](spacelift.md) | Env0 (ce guide) | [Scalr](scalr.md) |
|---|---|---|---|
| **Point fort** | Policy-as-code, stacks, drift | Environnements, flux custom | Workspaces, VCS, coûts |
| **Secret** | Secret d'environnement / contexte `PATHLY_API_TOKEN` | Variable d'environnement sensible | Variable set / env workspace |
| **Exemple** | [`examples/spacelift/`](../../examples/spacelift/) | [`examples/env0/`](../../examples/env0/) | [`examples/scalr/`](../../examples/scalr/) |

## Prérequis

- Une organisation Env0 avec projet et droits sur les templates
- Un jeton API [Pathly](https://pathlyhq.com) ([développeurs](https://pathlyhq.com/fr/developers))
- Accès Git à un dépôt contenant [`examples/env0/`](../../examples/env0/)

## 1. Créer un jeton API Pathly (pathlyhq.com)

1. Se connecter sur [pathlyhq.com](https://pathlyhq.com) ([inscription](https://pathlyhq.com/fr/login?mode=signup) si besoin).
2. Créer un jeton avec les portées requises par vos ressources Terraform.
3. Conserver la valeur pour l'étape secret Env0.

![Placeholder capture : Pathly — jeton API](../assets/env0-pathly-token.png)

Guides : [EN developers](https://pathlyhq.com/en/developers) · [FR developers](https://pathlyhq.com/fr/developers).

## 2. Ajouter `PATHLY_API_TOKEN` comme variable d'environnement sensible

1. Dans Env0, ouvrir votre **Project** ou **Environment**.
2. Aller dans **Variables**.
3. Ajouter `PATHLY_API_TOKEN` comme **Environment variable**.
4. Activer **Sensitive** pour masquer la valeur dans les logs.
5. La limiter aux environnements qui gèrent Pathly.

![Placeholder capture : Env0 — variable d'env sensible](../assets/env0-secret.png)

Le provider Pathly lit `PATHLY_API_TOKEN` sans argument provider. Éviter les motifs `TF_VAR_pathly_token` qui écrivent des secrets dans le state.

## 3. Créer un template et un environnement

1. **Templates → Create** pointant vers `examples/env0/` dans votre dépôt.
2. Choisir Terraform ou OpenTofu.
3. Créer un **Environment** depuis ce template.
4. Confirmer que `PATHLY_API_TOKEN` est hérité.

![Placeholder capture : Env0 — template / environnement](../assets/env0-environment.png)

## 4. Ce que déploie l'exemple

[`examples/env0/`](../../examples/env0/) utilise `pathlyhq/pathly` `~> 0.1` pour créer :

| Ressource | Rôle |
|----------|------|
| `pathly_scenario` | Contrôle HTTP du service sous test |
| `pathly_sla_target` | Objectif de disponibilité glissant |
| `pathly_webhook` | Notifications d'échec |
| `pathly_maintenance_window` | Fenêtre calme planifiée |

Schéma des ressources : [pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers).

## 5. Déployer

1. Lancer **Deploy** sur l'environnement Env0.
2. Approuver le plan si le projet l'exige.
3. Ouvrir [Pathly](https://pathlyhq.com) et confirmer que le scénario est actif.

![Placeholder capture : Env0 — deploy réussi](../assets/env0-deploy.png)

## 6. Conseils cycle de vie

- Détruire l'environnement Env0 supprime les ressources Pathly gérées par le state — idéal pour les previews éphémères.
- Partager un jeton Pathly en lecture seule pour les rôles plan-only quand c'est possible.
- Documenter la rotation du jeton à côté des réglages projet Env0.

## En savoir plus

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (FR)](https://pathlyhq.com/fr/developers)
- Guides associés : [Spacelift](spacelift.md) · [Scalr](scalr.md)
