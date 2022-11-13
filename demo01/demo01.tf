terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = "0.7.0"
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
  name        = "demo_tn"
  description = "This is a demo tenant created from Terraform"
}

resource "aci_vrf" "main" {
  tenant_dn = aci_tenant.demo.id
  name      = "main_vrf"
}

resource "aci_bridge_domain" "bd_192_168_1_0" {
  tenant_dn          = aci_tenant.demo.id
  name               = "192.168.1.0_24_bd"
  arp_flood          = "yes"
  unicast_route      = "yes"
  unk_mac_ucast_act  = "proxy"
  unk_mcast_act      = "flood"
  relation_fv_rs_ctx = aci_vrf.main.id
}
