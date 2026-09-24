# Pathly on Spacelift, Env0 and Scalr

**English** · [Français](README.fr.md) · [Español](README.es.md)


[![Powered by Pathly](https://img.shields.io/badge/Powered%20by-Pathly-0B5FFF?style=flat-square)](https://pathlyhq.com)
[![Website](https://img.shields.io/badge/Website-pathlyhq.com-111827?style=flat-square)](https://pathlyhq.com)
[![API docs](https://img.shields.io/badge/API-developers-2563eb?style=flat-square)](https://pathlyhq.com/en/developers)
[![Start free](https://img.shields.io/badge/Solo-start%20free-16a34a?style=flat-square)](https://pathlyhq.com/en/login?mode=signup)

> **Get started in one click.** Create a free account on [Pathly](https://pathlyhq.com) ([sign up](https://pathlyhq.com/en/login?mode=signup)), create an API key in the console, then export `PATHLY_API_TOKEN`. This project is the official bridge to [Pathly monitoring](https://pathlyhq.com) — real-browser and HTTP checks for checkout, login and availability, with data hosted in the EU. Full API reference: [pathlyhq.com/en/developers](https://pathlyhq.com/en/developers).

Run the official Terraform / OpenTofu provider **[`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly)** on the three leading IaC platforms — so [Pathly](https://pathlyhq.com) synthetic monitoring, SLA targets and webhooks live next to your cloud estate.

> Docs: [Pathly](https://pathlyhq.com) · [Developers (EN)](https://pathlyhq.com/en/developers) · [Developers (FR)](https://pathlyhq.com/fr/developers)  
> English (`README.md`, `docs/*.md`) is the default / canonical documentation language.

## Why Pathly + IaC platforms?

[Pathly](https://pathlyhq.com) monitors customer journeys (HTTP and browser) from multiple regions, tracks error budgets and fires webhooks on failure. Declaring Pathly resources in Terraform means:

- the same PR that changes a service can update its probe and SLA objective
- `PATHLY_API_TOKEN` stays in the platform secret store — never in git
- plans and applies are audited by Spacelift, Env0 or Scalr

Full API reference: [pathlyhq.com/en/developers](https://pathlyhq.com/en/developers).

## Platform comparison

| | [Spacelift](docs/spacelift.md) | [Env0](docs/env0.md) | [Scalr](docs/scalr.md) |
|---|---|---|---|
| **Strength** | Policy-as-code, stacks, drift | Environments, custom flows | Workspaces, VCS, cost |
| **Secret for Pathly** | Environment / context secret `PATHLY_API_TOKEN` | Environment variable (sensitive) | Variable set / workspace env |
| **Provider** | `pathlyhq/pathly` `~> 0.1` | same | same |
| **Example** | [`examples/spacelift/`](examples/spacelift/) | [`examples/env0/`](examples/env0/) | [`examples/scalr/`](examples/scalr/) |

All three platforms consume the same Pathly provider. Pick the one that already runs your Terraform, then follow the guide:

1. [Spacelift + Pathly](docs/spacelift.md)
2. [Env0 + Pathly](docs/env0.md)
3. [Scalr + Pathly](docs/scalr.md)

## Quick start (any platform)

```hcl
terraform {
  required_providers {
    pathly = {
      source  = "pathlyhq/pathly"
      version = "~> 0.1"
    }
  }
}

# Token from PATHLY_API_TOKEN — never a Terraform variable.
provider "pathly" {}

resource "pathly_scenario" "home" {
  name         = "Home page"
  url          = "https://shop.example.com"
  interval_sec = 300
}
```

Create an API token in the [Pathly console](https://pathlyhq.com) and store it as a **secret** named `PATHLY_API_TOKEN` on your platform. Details: [developers EN](https://pathlyhq.com/en/developers) · [developers FR](https://pathlyhq.com/fr/developers).

## Security

- Prefer environment / secret injection over `TF_VAR_*` for the Pathly token (variables can land in state).
- Use least-privilege Pathly API scopes for the stack that only manages scenarios.
- Encrypt remote state on the IaC platform.

## Learn more

- Product: [https://pathlyhq.com](https://pathlyhq.com)
- Developers EN: [https://pathlyhq.com/en/developers](https://pathlyhq.com/en/developers)
- Developers FR: [https://pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers)


## Related packages

| Package | Role |
|---|---|
| [pathly-terraform-provider](https://github.com/pathlyhq/pathly-terraform-provider) | Terraform / OpenTofu |
| [pathly-pulumi](https://github.com/pathlyhq/pathly-pulumi) | Pulumi |
| [pathly-cdktf](https://github.com/pathlyhq/pathly-cdktf) | CDK for Terraform |
| [pathly-crossplane](https://github.com/pathlyhq/pathly-crossplane) | Crossplane |
| [pathly-ansible](https://github.com/pathlyhq/pathly-ansible) | Ansible |
| [Pathly product](https://pathlyhq.com) | [Pathly monitoring](https://pathlyhq.com) |
## About Pathly

[Pathly](https://pathlyhq.com) is synthetic monitoring for agencies and e-commerce: replay the customer journey, catch broken checkouts before your clients call, and keep evidence (screenshot, step, runbook) ready for the invoice. Product: [pathlyhq.com](https://pathlyhq.com) · Developers: [pathlyhq.com/en/developers](https://pathlyhq.com/en/developers) · Status & pricing: [pathlyhq.com/en/pricing](https://pathlyhq.com/en/pricing).

## Author

| | |
|---|---|
| **Company** | Pathly |
| **Author** | Simon Raynaud / keyral |

See [AUTHORS](AUTHORS).

## License

Apache-2.0 — see [LICENSE](LICENSE).
