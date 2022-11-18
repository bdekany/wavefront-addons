terraform {
  required_providers {
    wavefront = {
      source = "vmware/wavefront"
    }
  }
}


variable "dashboards" {
  type = list
  description = "Paths to Dashboards JSON files"
  # default = ["./kubernetes/kube-deprecated-api.json"]
}

provider "wavefront" {
}

resource "wavefront_dashboard_json" "dashboard_from_list" {
  for_each = toset( var.dashboards)
  dashboard_json = file(each.key)
}
