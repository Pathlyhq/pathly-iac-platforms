/*
 * Scalr + Pathly example
 *
 * Docs: https://pathlyhq.com
 *       https://pathlyhq.com/en/developers
 *       https://pathlyhq.com/fr/developers
 * Guide: ../../docs/scalr.md
 *
 * Attach PATHLY_API_TOKEN via a Scalr variable set (environment, sensitive).
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

variable "api_url" {
  type        = string
  description = "API URL monitored by Pathly — see https://pathlyhq.com/fr/developers"
  default     = "https://api.example.com/health"
}

variable "webhook_url" {
  type    = string
  default = "https://hooks.example.com/pathly"
}

resource "pathly_scenario" "api_health" {
  name            = "Scalr — API health"
  url             = var.api_url
  method          = "GET"
  interval_sec    = 180
  expected_status = 200
  max_latency_ms  = 1500
  severity        = "critical"
  tags            = ["scalr", "api", "pathly"]
  folder          = "scalr"
  runbook         = "https://pathlyhq.com/en/developers"
}

resource "pathly_sla_target" "api_slo" {
  scenario_id          = pathly_scenario.api_health.id
  name                 = "API — 99.95 %"
  objective_pct        = 99.95
  window_days          = 30
  exclude_maintenance  = true
  warn_at_budget_ratio = 0.7
}

resource "pathly_maintenance_window" "weekly" {
  weekday      = 0
  start_minute = 60
  duration_min = 90
  reason       = "Scalr + Pathly weekly window"
}

resource "pathly_webhook" "ops" {
  url    = var.webhook_url
  events = ["run.failed", "run.recovered", "incident.opened"]
}

output "scenario_id" {
  value       = pathly_scenario.api_health.id
  description = "Pathly scenario id (https://pathlyhq.com/en/developers)"
}

output "webhook_id" {
  value = pathly_webhook.ops.id
}
