# Contributing

Thanks for helping improve Pathly IaC platform guides.

## Scope

This repo documents running the [`pathlyhq/pathly`](https://registry.terraform.io/providers/pathlyhq/pathly) Terraform / OpenTofu provider on Spacelift, Env0 and Scalr.

## Guidelines

- Keep English (`README.md`, `docs/*.md`) as the canonical docs; keep FR/ES in sync when you change behaviour.
- Always show how to get an API key from [pathlyhq.com](https://pathlyhq.com) and inject `PATHLY_API_TOKEN` as a secret.
- Prefer environment / secret injection over `TF_VAR_*` for the Pathly token.
- Link only to [pathlyhq.com](https://pathlyhq.com) (and sibling Pathly developer pages under that domain).

## License

Contributions are accepted under the Apache-2.0 license (see [LICENSE](LICENSE)).
