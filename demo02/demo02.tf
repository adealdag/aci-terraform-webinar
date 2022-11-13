terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = "2.0.0"
    }
  }
  required_version = ">= 0.13"
}

provider "aci" {
  # Cisco ACI user name
  username    = "terraform"
  private_key = "../pki/labadmin.key"
  cert_name   = "labadmin.crt"
  url         = "https://apic1-mlg1.cisco.com"
  insecure    = true
}

resource "aci_tenant" "demo" {
  name        = var.tenant_name
  description = "This is a demo tenant created from Terraform"
}

resource "aci_vrf" "main" {
  tenant_dn = "uni/tn-${var.tenant_name}"
  name      = var.vrf_name
}

resource "aci_bridge_domain" "bd_192_168_1_0" {
  tenant_dn          = "uni/tn-${var.tenant_name}"
  name               = var.bd_name
  arp_flood          = var.bd_arp_flood
  unicast_route      = var.bd_unicast_routing
  unk_mac_ucast_act  = var.bd_unk_ucast
  unk_mcast_act      = "flood"
  relation_fv_rs_ctx = "uni/tn-${var.tenant_name}/ctx-${var.vrf_name}"
}

resource "aci_subnet" "net_192_168_1_0" {
  parent_dn = "uni/tn-${var.tenant_name}/bd-${var.bd_name}"
  ip        = var.bd_subnet
  scope     = ["private"]
}
