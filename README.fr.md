# Pathly sur Spacelift, Env0 et Scalr

[English](README.md) · **Français** · [Español](README.es.md)


[![Powered by Pathly](https://img.shields.io/badge/Powered%20by-Pathly-0B5FFF?style=flat-square)](https://pathlyhq.com)
[![Website](https://img.shields.io/badge/Website-pathlyhq.com-111827?style=flat-square)](https://pathlyhq.com)
[![API docs](https://img.shields.io/badge/API-developers-2563eb?style=flat-square)](https://pathlyhq.com/fr/developers)
[![Start free](https://img.shields.io/badge/Solo-start%20free-16a34a?style=flat-square)](https://pathlyhq.com/fr/login?mode=signup)

> **Démarrage en un clic.** Créez un compte gratuit sur [Pathly](https://pathlyhq.com) ([inscription](https://pathlyhq.com/fr/login?mode=signup)), générez une clé API dans la console, puis exportez `PATHLY_API_TOKEN`. Ce dépôt est le pont officiel vers [la surveillance Pathly](https://pathlyhq.com) — contrôles HTTP et parcours navigateur (panier, connexion, disponibilité), données hébergées dans l’UE. Référence API : [pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers).

Exécutez le provider Terraform / OpenTofu officiel **[`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly)** sur les trois plateformes IaC leaders — pour que le monitoring synthétique [Pathly](https://pathlyhq.com), les objectifs SLA et les webhooks vivent à côté de votre estate cloud.

> Docs: [Pathly](https://pathlyhq.com) · [Developers (EN)](https://pathlyhq.com/en/developers) · [Developers (FR)](https://pathlyhq.com/fr/developers)  
> La version anglaise ([`README.md`](README.md), `docs/*.md`) fait référence.

## Pourquoi Pathly + plateformes IaC ?

[Pathly](https://pathlyhq.com) surveille les parcours clients (HTTP et navigateur) depuis plusieurs régions, suit les budgets d'erreur et déclenche des webhooks en cas d'échec. Décrire Pathly en Terraform permet:

- qu'une même PR mette à jour le service, sa sonde et son objectif SLA
- que `PATHLY_API_TOKEN` reste dans le coffre de secrets de la plateforme — jamais dans git
- que plans et applies soient audités par Spacelift, Env0 ou Scalr

Référence API: [pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers).

## Comparaison des plateformes

| | [Spacelift](docs/fr/spacelift.md) | [Env0](docs/fr/env0.md) | [Scalr](docs/fr/scalr.md) |
|---|---|---|---|
| **Point fort** | Policy-as-code, stacks, drift | Environnements, flux custom | Workspaces, VCS, coûts |
| **Secret Pathly** | Secret d'environnement / contexte `PATHLY_API_TOKEN` | Variable d'environnement (sensible) | Variable set / env workspace |
| **Provider** | `pathlyhq/pathly` `~> 0.1` | idem | idem |
| **Exemple** | [`examples/spacelift/`](examples/spacelift/) | [`examples/env0/`](examples/env0/) | [`examples/scalr/`](examples/scalr/) |

Guides détaillés:

1. [Spacelift + Pathly](docs/fr/spacelift.md)
2. [Env0 + Pathly](docs/fr/env0.md)
3. [Scalr + Pathly](docs/fr/scalr.md)

## Démarrage rapide

```hcl
terraform {
  required_providers {
    pathly = {
      source  = "pathlyhq/pathly"
      version = "~> 0.1"
    }
  }
}

provider "pathly" {}

resource "pathly_scenario" "home" {
  name         = "Page d'accueil"
  url          = "https://shop.example.com"
  interval_sec = 300
}
```

Créez un jeton dans la [console Pathly](https://pathlyhq.com) et stockez-le comme secret `PATHLY_API_TOKEN`. Voir [developers FR](https://pathlyhq.com/fr/developers) · [developers EN](https://pathlyhq.com/en/developers).

## En savoir plus

- Produit: [https://pathlyhq.com](https://pathlyhq.com)
- Developers EN: [https://pathlyhq.com/en/developers](https://pathlyhq.com/en/developers)
- Developers FR: [https://pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers)


## Packages associés

| Package | Role |
|---|---|
| [pathly-terraform-provider](https://github.com/pathlyhq/pathly-terraform-provider) | Terraform / OpenTofu |
| [pathly-pulumi](https://github.com/pathlyhq/pathly-pulumi) | Pulumi |
| [pathly-cdktf](https://github.com/pathlyhq/pathly-cdktf) | CDK for Terraform |
| [pathly-crossplane](https://github.com/pathlyhq/pathly-crossplane) | Crossplane |
| [pathly-ansible](https://github.com/pathlyhq/pathly-ansible) | Ansible |
| [Pathly product](https://pathlyhq.com) | [Pathly monitoring](https://pathlyhq.com) |
## À propos de Pathly

[Pathly](https://pathlyhq.com) surveille les parcours clients des agences et e-commerçants : rejoue le tunnel, détecte un checkout cassé avant l’appel du client, et joint la preuve (capture, étape, consigne) à la facture de maintenance. Produit : [pathlyhq.com](https://pathlyhq.com) · Développeurs : [pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers) · Tarifs : [pathlyhq.com/fr/pricing](https://pathlyhq.com/fr/pricing).

## Auteur

| | |
|---|---|
| **Société** | Pathly |
| **Auteur** | Simon Raynaud / keyral |

Voir [AUTHORS](AUTHORS).

## Licence

Apache-2.0 — voir [LICENSE](LICENSE).
