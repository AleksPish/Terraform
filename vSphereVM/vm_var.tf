#File containing all the vairables required to create the VM from template

variable "vm_name" {
  description = "vm name"
  default     = "<vm name>"
}

variable "cluster_name" {
  description = "Name of cluster to place the vm"
  default = "<cluster>"
}

variable "vmfolder" {
  description = "folder in vsphere containing the vms"
  default     = "/<folder>"
}

variable "admin_password" {
  description = "local admin password"
  default     = "<password>"
}

variable "template" {
  description = "Name of the template to clone from"
  default = "<template name>"
}
variable "num_cpus" {
  description = "Number of CPUs for the virtual machine"
  type        = number
  default     = 4
}
variable "vsphere_network" {
  description = "Network"
  default     = "<network/portgroup>"
}
variable "ip_address" {
  description = "IP address for VM"
  default     = "<ip address>"
}
variable "netmask" {
  default = 24
}
variable "gateway" {
  default = "<gateway ip>"
}
variable "vsphere_datastore" {
  description = "Datastore"
  default     = "<datastore name>"
}
variable "memory" {
  description = "Amount of memory for the virtual machine (in MB)"
  type        = number
  default     = 32768 
}

variable "windows2022Licence" {
  description = "Licence key for server 2022"
  default     = "<licence Key>"
}