terraform {
  required_providers {
    wavefront = {
      source = "vmware/wavefront"
    }
  }
}

provider "wavefront" {
}

resource "wavefront_dashboard_json" "test_dashboard_json" {
  dashboard_json = file("./kubernetes/ingress-nginx-controller.json")
}
