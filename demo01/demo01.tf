terraform {
  required_providers {
    aci = {
      source = "ciscodevnet/aci"
      version = "0.7.0"
    }
  }
  required_version = ">= 0.13"
}

provider "aci" {
  # Cisco ACI user name
  username = "orchestrator"
  private_key = "../pki/labadmin.key"
  cert_name = "labadmin.crt"
  url      = "https://apic-ams.cisco.com"
  insecure = true
}

resource "aci_tenant" "demo" {
  name        = "demo_tn"
  description = "This is a demo tenant created from Terraform"
}

resource "aci_vrf" "main" {
  tenant_dn              = aci_tenant.demo.id
  name                   = "main_vrf"
}