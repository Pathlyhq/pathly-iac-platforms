# Pathly on Spacelift

**English** · [Français](fr/spacelift.md) · [Español](es/spacelift.md)

Connect [Spacelift](https://spacelift.io) stacks to the [Pathly](https://pathlyhq.com) Terraform provider so synthetic monitoring follows your infrastructure as code.

> **Get an API key from [pathlyhq.com](https://pathlyhq.com).** Sign up at [pathlyhq.com/en/login?mode=signup](https://pathlyhq.com/en/login?mode=signup), create a token in the console, then store it as secret `PATHLY_API_TOKEN` in Spacelift (never in git or Terraform variables).

> [Pathly home](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers FR](https://pathlyhq.com/fr/developers)  
> Example code: [`examples/spacelift/`](../examples/spacelift/)  
> English is the default / canonical version of this guide.

## Platform comparison

| | Spacelift (this guide) | [Env0](env0.md) | [Scalr](scalr.md) |
|---|---|---|---|
| **Strength** | Policy-as-code, stacks, drift | Environments, custom flows | Workspaces, VCS, cost |
| **Secret** | Context / env secret `PATHLY_API_TOKEN` | Sensitive env var | Variable set / workspace env |
| **Example** | [`examples/spacelift/`](../examples/spacelift/) | [`examples/env0/`](../examples/env0/) | [`examples/scalr/`](../examples/scalr/) |

## Prerequisites

- A Spacelift account with permission to create stacks and contexts
- A [Pathly](https://pathlyhq.com) organization and API token ([how to create a token](https://pathlyhq.com/en/developers))
- A VCS repository containing the Terraform in this guide (or a mounted local path for private workers)

## 1. Create a Pathly API token (pathlyhq.com)

1. Open the [Pathly console](https://pathlyhq.com) ([sign up](https://pathlyhq.com/en/login?mode=signup) if needed).
2. Create an API token with scopes for scenarios, webhooks, maintenance windows and SLA targets.
3. Copy the token once — Spacelift will store it as a secret.

![Screenshot placeholder: Pathly console — create API token](../docs/assets/spacelift-pathly-token.png)

See also: [pathlyhq.com/en/developers](https://pathlyhq.com/en/developers) and [pathlyhq.com/fr/developers](https://pathlyhq.com/fr/developers).

## 2. Store `PATHLY_API_TOKEN` in Spacelift

1. In Spacelift, open **Contexts** (or the stack **Environment** tab).
2. Add an environment variable named `PATHLY_API_TOKEN`.
3. Mark it as **secret**.
4. Attach the context to the stack that will manage Pathly resources.

![Screenshot placeholder: Spacelift — secret environment variable](../docs/assets/spacelift-secret.png)

The [`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly) provider reads `PATHLY_API_TOKEN` automatically. Do **not** pass the token through a Terraform variable (it would be stored in state).

## 3. Create a Spacelift stack

1. **Stacks → Create stack**.
2. Point the stack at your repository path `examples/spacelift/` (or your fork).
3. Set the Terraform / OpenTofu workflow as usual.
4. Attach the context that holds `PATHLY_API_TOKEN`.
5. Optional: enable drift detection so Pathly console edits surface as drift.

![Screenshot placeholder: Spacelift — create stack](../docs/assets/spacelift-stack.png)

## 4. Terraform layout

The example under [`examples/spacelift/`](../examples/spacelift/) declares:

- `pathly_scenario` — HTTP probe for a critical URL
- `pathly_sla_target` — availability objective
- `pathly_maintenance_window` — weekly quiet period
- `pathly_webhook` — alert destination

Provider block (no credentials in HCL):

```hcl
provider "pathly" {}
```

Full resource field reference: [Pathly developers](https://pathlyhq.com/en/developers).

## 5. Plan and apply

1. Trigger a run from Spacelift (or push to the tracked branch).
2. Review the plan: Pathly resources appear as `pathly_*`.
3. Confirm apply.
4. In the [Pathly console](https://pathlyhq.com), verify the scenario and SLA target.

![Screenshot placeholder: Spacelift — successful apply with pathly resources](../docs/assets/spacelift-apply.png)

## 6. Policies and tips

- Use Spacelift **policies** to require a Pathly scenario whenever a production service is created.
- Keep Pathly tokens in a dedicated context shared only by monitoring stacks (least privilege).
- Prefer OpenTofu or Terraform `>= 1.6` with provider `pathlyhq/pathly` `~> 0.1`.

## Learn more

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (FR)](https://pathlyhq.com/fr/developers)
- Sibling guides: [Env0](env0.md) · [Scalr](scalr.md)
