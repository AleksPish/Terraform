#File containing the connection details for the vsphere you will be building the VM in.
#If possible swich out the password and username using environment vairables or another method to secure the credentials

variable "vsphere_user" {
  description = "Username for vSphere"
  default     = "<user name for vsphere>"
}

variable "vsphere_password" {
  description = "Password for vSphere"
  default     = "<password for vsphere>"
}

variable "vsphere_server" {
  description = "vSphere server address"
  default     = "<FQDN for vsphere>"
}

variable "vsphere_datacentername" {
  description = "Datacenter name"
  default     = "<datacenter name in vsphere>"
}