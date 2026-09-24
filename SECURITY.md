# Security Policy

## Supported versions

Security fixes are applied on the latest `main` branch of this documentation repository.

## Reporting a vulnerability

Report issues in examples or guidance that could leak credentials to **security@pathlyhq.com**.

For privacy or personal-data concerns, contact **privacy@pathlyhq.com**.

Please include the repository name (`pathly-iac-platforms`) and the affected guide or example path.

## Credentials

- Store `PATHLY_API_TOKEN` as a **platform secret** (Spacelift context, Env0 sensitive variable, Scalr sensitive env var).
- Never commit tokens to git or put them in Terraform variables that land in state.
- Create and rotate tokens in the [Pathly console](https://pathlyhq.com) — see [developers](https://pathlyhq.com/en/developers).
