# Variables file
# --

variable "tenant_name" {
  default = "demo_tn"
}

variable "vrf_name" {
  default = "main_vrf"
}

variable "bd_name" {
  default = "net01_bd"
}

variable "bd_arp_flood" {
  description = "Specify whether ARP flooding is enabled. If flooding is disabled, unicast routing will be performed on the target IP address."
  default = "yes"
  validation {
    condition = (var.bd_arp_flood == "yes") || (var.bd_arp_flood == "no")
    error_message = "Allowed values are \"yes\" and \"no\"."
  }
}

variable "bd_unicast_routing" {
  default = "yes"
}

variable "bd_unk_ucast" {
  default = "proxy"
}