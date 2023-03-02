terraform {
  required_providers {
    wavefront = {
      source = "vmware/wavefront"
    }
  }
}

variable "WAVEFRONT_ADDRESS" {
  type = string
  description = "URL to your wavefont tenant ex: longboard.wavefront.com"
}

variable "WAVEFRONT_TOKEN" {
  type = string
  description = "API Token"
}

variable "dashboards" {
  type = list
  description = "Paths to Dashboards JSON files"
  # default = ["./kubernetes/kube-deprecated-api.json"]
}

provider "wavefront" {
  address = var.WAVEFRONT_ADDRESS
  token = var.WAVEFRONT_TOKEN
}

resource "wavefront_dashboard_json" "dashboard_from_list" {
  for_each = toset( var.dashboards)
  dashboard_json = file(each.key)
}
