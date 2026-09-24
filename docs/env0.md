# Pathly on Env0

**English** · [Français](fr/env0.md) · [Español](es/env0.md)

Wire [Env0](https://www.env0.com) environments to the [Pathly](https://pathlyhq.com) Terraform provider and manage synthetic monitoring as part of every environment lifecycle.

> **Get an API key from [pathlyhq.com](https://pathlyhq.com).** Sign up at [pathlyhq.com/en/login?mode=signup](https://pathlyhq.com/en/login?mode=signup), create a token in the console, then store it as sensitive env var `PATHLY_API_TOKEN` in Env0 (never in git or Terraform variables).

> [Pathly home](https://pathlyhq.com) · [Developers EN](https://pathlyhq.com/en/developers) · [Developers FR](https://pathlyhq.com/fr/developers)  
> Example code: [`examples/env0/`](../examples/env0/)  
> English is the default / canonical version of this guide.

## Platform comparison

| | [Spacelift](spacelift.md) | Env0 (this guide) | [Scalr](scalr.md) |
|---|---|---|---|
| **Strength** | Policy-as-code, stacks, drift | Environments, custom flows | Workspaces, VCS, cost |
| **Secret** | Context / env secret `PATHLY_API_TOKEN` | Sensitive env var | Variable set / workspace env |
| **Example** | [`examples/spacelift/`](../examples/spacelift/) | [`examples/env0/`](../examples/env0/) | [`examples/scalr/`](../examples/scalr/) |

## Prerequisites

- An Env0 organization with a project and template permissions
- A [Pathly](https://pathlyhq.com) API token ([developers](https://pathlyhq.com/en/developers))
- Git access to a repo that includes [`examples/env0/`](../examples/env0/)

## 1. Create a Pathly API token (pathlyhq.com)

1. Sign in at [pathlyhq.com](https://pathlyhq.com) ([sign up](https://pathlyhq.com/en/login?mode=signup) if needed).
2. Create a token with the scopes required by your Terraform resources.
3. Keep the value for the Env0 secret step.

![Screenshot placeholder: Pathly — API token](../docs/assets/env0-pathly-token.png)

Guides: [EN developers](https://pathlyhq.com/en/developers) · [FR developers](https://pathlyhq.com/fr/developers).

## 2. Add `PATHLY_API_TOKEN` as a sensitive environment variable

1. In Env0, open your **Project** or **Environment**.
2. Go to **Variables**.
3. Add `PATHLY_API_TOKEN` as an **Environment variable**.
4. Enable **Sensitive** so the value is redacted in logs.
5. Scope it to the environments that manage Pathly resources.

![Screenshot placeholder: Env0 — sensitive env var](../docs/assets/env0-secret.png)

The Pathly provider picks up `PATHLY_API_TOKEN` without any provider arguments. Avoid `TF_VAR_pathly_token` patterns that write secrets into state.

## 3. Create a template and environment

1. **Templates → Create** pointing at `examples/env0/` in your repo.
2. Choose Terraform or OpenTofu.
3. Create an **Environment** from that template.
4. Confirm `PATHLY_API_TOKEN` is inherited.

![Screenshot placeholder: Env0 — template / environment](../docs/assets/env0-environment.png)

## 4. What the example deploys

[`examples/env0/`](../examples/env0/) uses `pathlyhq/pathly` `~> 0.1` to create:

| Resource | Purpose |
|----------|---------|
| `pathly_scenario` | HTTP check for the service under test |
| `pathly_sla_target` | Rolling availability objective |
| `pathly_webhook` | Failure notifications |
| `pathly_maintenance_window` | Planned quiet window |

Resource schema: [pathlyhq.com/en/developers](https://pathlyhq.com/en/developers).

## 5. Deploy

1. Run **Deploy** on the Env0 environment.
2. Approve the plan if your project requires it.
3. Open [Pathly](https://pathlyhq.com) and confirm the scenario is enabled.

![Screenshot placeholder: Env0 — deploy success](../docs/assets/env0-deploy.png)

## 6. Environment lifecycle tips

- Destroying the Env0 environment deletes Pathly resources managed by the state — ideal for ephemeral previews.
- Share a read-only Pathly token for plan-only roles when possible.
- Document the token rotation process next to your Env0 project settings.

## Learn more

- [Pathly](https://pathlyhq.com)
- [Pathly developers (EN)](https://pathlyhq.com/en/developers)
- [Pathly developers (FR)](https://pathlyhq.com/fr/developers)
- Sibling guides: [Spacelift](spacelift.md) · [Scalr](scalr.md)
