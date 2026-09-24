/*
 * Spacelift + Pathly example
 *
 * Docs: https://pathlyhq.com
 *       https://pathlyhq.com/en/developers
 *       https://pathlyhq.com/fr/developers
 * Guide: ../../docs/spacelift.md
 *
 * Inject PATHLY_API_TOKEN as a Spacelift secret (Context / Environment).
 * Never put the token in a Terraform variable.
 */

terraform {
  required_version = ">= 1.6"
  required_providers {
    pathly = {
      source  = "pathlyhq/pathly"
      version = "~> 0.1"
    }
  }
}

provider "pathly" {}

variable "site_url" {
  type        = string
  description = "URL probed by Pathly — see https://pathlyhq.com/en/developers"
  default     = "https://shop.example.com"
}

variable "webhook_url" {
  type        = string
  description = "Outbound webhook destination for Pathly alerts."
  default     = "https://hooks.example.com/pathly"
}

resource "pathly_scenario" "home" {
  name            = "Spacelift — Home page"
  url             = var.site_url
  interval_sec    = 300
  expected_status = 200
  expect_text     = "Our products"
  max_latency_ms  = 2000
  severity        = "critical"
  tags            = ["spacelift", "prod", "pathly"]
  folder          = "spacelift"
  runbook         = "https://pathlyhq.com/en/developers"
}

resource "pathly_sla_target" "home" {
  scenario_id          = pathly_scenario.home.id
  name                 = "Home — 99.9 %"
  objective_pct        = 99.9
  window_days          = 30
  exclude_maintenance  = true
  warn_at_budget_ratio = 0.8
}

resource "pathly_maintenance_window" "weekly_backup" {
  weekday      = 0
  start_minute = 180
  duration_min = 120
  reason       = "Weekly backup (Spacelift + Pathly)"
}

resource "pathly_webhook" "alerts" {
  url    = var.webhook_url
  events = ["run.failed", "run.recovered", "incident.opened"]
}

output "scenario_id" {
  value       = pathly_scenario.home.id
  description = "Pathly scenario id — see https://pathlyhq.com/fr/developers"
}

output "sla_target_id" {
  value = pathly_sla_target.home.id
}
