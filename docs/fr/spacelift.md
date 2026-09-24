# Pathly sur Spacelift

[English](../spacelift.md) · **Français** · [Español](../es/spacelift.md)

Connectez des stacks [Spacelift](https://spacelift.io) au provider Terraform [Pathly](https://pathlyhq.com) pour que le monitoring synthétique suive votre infrastructure as code.

> **Obtenir une clé API sur [pathlyhq.com](https://pathlyhq.com).** Inscription : [pathlyhq.com/fr/login?mode=signup](https://pathlyhq.com/fr/login?mode=signup). Créez un jeton dans la console, puis stockez-le comme secret `PATHLY_API_TOKEN` dans Spacelift (jamais dans git ni en variable Terraform).

> [Accueil Pathly](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers FR](https://pathlyhq.com/fr/developers)  
> Code d'exemple : [`examples/spacelift/`](../../examples/spacelift/)  
> La version anglaise ([`spacelift.md`](../spacelift.md)) fait référence.

## Comparaison des plateformes

| | Spacelift (ce guide) | [Env0](env0.md) | [Scalr](scalr.md) |
|---|---|---|---|
| **Point fort** | Policy-as-code, stacks, drift | Environnements, flux custom | Workspaces, VCS, coûts |
| **Secret** | Secret d'environnement / contexte `PATHLY_API_TOKEN` | Variable d'environnement sensible | Variable set / env workspace |
| **Exemple** | [`examples/spacelift/`](../../examples/spacelift/) | [`examples/env0/`](../../examples/env0/) | [`examples/scalr/`](../../examples/scalr/) |

## Prérequis

- Un compte Spacelift avec droit de créer stacks et contexts
- Une organisation [Pathly](https://pathlyhq.com) et un jeton API ([créer un jeton](https://pathlyhq.com/fr/developers))
- Un dépôt VCS contenant le Terraform de ce guide (ou un chemin local monté pour workers privés)

## 1. Créer un jeton API Pathly (pathlyhq.com)

1. Ouvrir la [console Pathly](https://pathlyhq.com) ([inscription](https://pathlyhq.com/fr/login?mode=signup) si besoin).
2. Créer un jeton API avec les portées scénarios, webhooks, fenêtres de maintenance et objectifs SLA.
3. Copier le jeton une seule fois — Spacelift le stockera comme secret.

![Placeholder capture : console Pathly — créer un jeton API](../assets/spacelift-pathly-token.png)

Voir aussi : [pathlyhq.com/en/developers](https://pathlyhq.com/en/developers) et [pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers).

## 2. Stocker `PATHLY_API_TOKEN` dans Spacelift

1. Dans Spacelift, ouvrir **Contexts** (ou l'onglet **Environment** du stack).
2. Ajouter une variable d'environnement `PATHLY_API_TOKEN`.
3. La marquer **secret**.
4. Attacher le context au stack qui gérera les ressources Pathly.

![Placeholder capture : Spacelift — variable d'environnement secrète](../assets/spacelift-secret.png)

Le provider [`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly) lit `PATHLY_API_TOKEN` automatiquement. Ne **pas** passer le jeton via une variable Terraform (il serait stocké dans le state).

## 3. Créer un stack Spacelift

1. **Stacks → Create stack**.
2. Pointer le stack vers le chemin `examples/spacelift/` du dépôt (ou votre fork).
3. Configurer le workflow Terraform / OpenTofu comme d'habitude.
4. Attacher le context qui contient `PATHLY_API_TOKEN`.
5. Optionnel : activer la détection de drift pour que les éditions console Pathly apparaissent en drift.

![Placeholder capture : Spacelift — créer un stack](../assets/spacelift-stack.png)

## 4. Organisation Terraform

L'exemple [`examples/spacelift/`](../../examples/spacelift/) déclare :

- `pathly_scenario` — sonde HTTP pour une URL critique
- `pathly_sla_target` — objectif de disponibilité
- `pathly_maintenance_window` — fenêtre calme hebdomadaire
- `pathly_webhook` — destination d'alerte

Bloc provider (aucune credential dans le HCL) :

```hcl
provider "pathly" {}
```

Référence complète des champs : [développeurs Pathly](https://pathlyhq.com/fr/developers).

## 5. Plan et apply

1. Déclencher un run depuis Spacelift (ou pousser sur la branche suivie).
2. Examiner le plan : les ressources Pathly apparaissent en `pathly_*`.
3. Confirmer l'apply.
4. Dans la [console Pathly](https://pathlyhq.com), vérifier le scénario et l'objectif SLA.

![Placeholder capture : Spacelift — apply réussi avec ressources pathly](../assets/spacelift-apply.png)

## 6. Policies et conseils

- Utiliser les **policies** Spacelift pour exiger un scénario Pathly dès qu'un service de production est créé.
- Garder les jetons Pathly dans un context dédié, partagé seulement par les stacks de monitoring (moindre privilège).
- Préférer OpenTofu ou Terraform `>= 1.6` avec le provider `pathlyhq/pathly` `~> 0.1`.

## En savoir plus

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (FR)](https://pathlyhq.com/fr/developers)
- Guides associés : [Env0](env0.md) · [Scalr](scalr.md)
