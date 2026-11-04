/*
 * Env0 + Pathly example
 *
 * Docs: https://pathlyhq.com
 *       https://pathlyhq.com/en/developers
 *       https://pathlyhq.com/fr/developers
 * Guide: ../../docs/env0.md
 *
 * Set PATHLY_API_TOKEN as a sensitive Env0 environment variable.
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

variable "environment_name" {
  type        = string
  description = "Env0 environment label used in Pathly tags."
  default     = "preview"
}

variable "site_url" {
  type    = string
  default = "https://shop.example.com"
}

variable "webhook_url" {
  type    = string
  default = "https://hooks.example.com/pathly"
}

resource "pathly_scenario" "service" {
  name            = "Env0 — ${var.environment_name} health"
  url             = var.site_url
  interval_sec    = 300
  expected_status = 200
  severity        = "major"
  tags            = ["env0", var.environment_name, "pathly"]
  folder          = "env0"
  runbook         = "https://pathlyhq.com/en/developers"
}

resource "pathly_sla_target" "service" {
  scenario_id          = pathly_scenario.service.id
  name                 = "${var.environment_name} — 99.5 %"
  objective_pct        = 99.5
  window_days          = 7
  exclude_maintenance  = true
  warn_at_budget_ratio = 0.8
}

resource "pathly_maintenance_window" "deploy_window" {
  weekday      = 2
  start_minute = 120
  duration_min = 60
  reason       = "Env0 scheduled maintenance"
}

resource "pathly_webhook" "alerts" {
  url    = var.webhook_url
  events = ["run.failed", "run.recovered"]
}

output "scenario_id" {
  value = pathly_scenario.service.id
}
