# Pathly on Scalr

**English** · [Français](fr/scalr.md) · [Español](es/scalr.md)

Use [Scalr](https://scalr.com) workspaces with the [Pathly](https://pathlyhq.com) Terraform provider to keep synthetic monitoring, SLA targets and webhooks under the same VCS workflow as your cloud modules.

> **Get an API key from [pathlyhq.com](https://pathlyhq.com).** Sign up at [pathlyhq.com/en/login?mode=signup](https://pathlyhq.com/en/login?mode=signup), create a token in the console, then store it as sensitive env var `PATHLY_API_TOKEN` in Scalr (never in git or Terraform variables).

> [Pathly home](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers FR](https://pathlyhq.com/fr/developers)  
> Example code: [`examples/scalr/`](../examples/scalr/)  
> English is the default / canonical version of this guide.

## Platform comparison

| | [Spacelift](spacelift.md) | [Env0](env0.md) | Scalr (this guide) |
|---|---|---|---|
| **Strength** | Policy-as-code, stacks, drift | Environments, custom flows | Workspaces, VCS, cost |
| **Secret** | Context / env secret `PATHLY_API_TOKEN` | Sensitive env var | Variable set / workspace env |
| **Example** | [`examples/spacelift/`](../examples/spacelift/) | [`examples/env0/`](../examples/env0/) | [`examples/scalr/`](../examples/scalr/) |

## Prerequisites

- A Scalr account with workspace create permissions
- A [Pathly](https://pathlyhq.com) API token ([create one](https://pathlyhq.com/en/developers))
- A VCS connection to a repository containing [`examples/scalr/`](../examples/scalr/)

## 1. Create a Pathly API token (pathlyhq.com)

1. Open [https://pathlyhq.com](https://pathlyhq.com) ([sign up](https://pathlyhq.com/en/login?mode=signup) if needed).
2. Create an API token with scopes matching the resources in the example.
3. Store it for the Scalr variable set.

![Screenshot placeholder: Pathly — API token for Scalr](../docs/assets/scalr-pathly-token.png)

Full API docs: [EN](https://pathlyhq.com/en/developers) · [FR](https://pathlyhq.com/fr/developers).

## 2. Inject `PATHLY_API_TOKEN` via a variable set

1. In Scalr, open **Variable sets** (or the workspace **Variables** tab).
2. Add an **Environment** variable `PATHLY_API_TOKEN`.
3. Mark it **sensitive**.
4. Attach the variable set to the workspace that runs Pathly Terraform.

![Screenshot placeholder: Scalr — sensitive environment variable](../docs/assets/scalr-secret.png)

The provider [`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly) authenticates from that environment variable. Do not put the token in `terraform.tfvars` or a non-sensitive Scalr Terraform variable.

## 3. Create a Scalr workspace

1. **Workspaces → New**.
2. Connect VCS and set the working directory to `examples/scalr/`.
3. Attach the variable set with `PATHLY_API_TOKEN`.
4. Enable run triggers / VCS auto-apply according to your policy.

![Screenshot placeholder: Scalr — workspace settings](../docs/assets/scalr-workspace.png)

## 4. Example resources

[`examples/scalr/`](../examples/scalr/) provisions Pathly monitoring resources:

```hcl
provider "pathly" {}

resource "pathly_scenario" "api_health" { ... }
resource "pathly_sla_target" "api_slo" { ... }
resource "pathly_maintenance_window" "weekly" { ... }
resource "pathly_webhook" "ops" { ... }
```

Field-level reference: [pathlyhq.com/en/developers](https://pathlyhq.com/en/developers).

## 5. Run plan / apply

1. Queue a run from Scalr (or push to the tracked branch).
2. Review the plan for `pathly_*` resources.
3. Apply and verify in the [Pathly console](https://pathlyhq.com).

![Screenshot placeholder: Scalr — apply with Pathly provider](../docs/assets/scalr-apply.png)

## 6. Operational notes

- Use Scalr **environments** to separate Pathly staging vs production tokens.
- Rotate `PATHLY_API_TOKEN` in the variable set without changing HCL.
- Pair with OPA / policy checks so production workspaces always declare a Pathly SLA target.

## Learn more

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (FR)](https://pathlyhq.com/fr/developers)
- Sibling guides: [Spacelift](spacelift.md) · [Env0](env0.md)
