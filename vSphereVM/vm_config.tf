#File containing all the basic configuration for the virtual machine
#See documentation here https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine


provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacentername
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.num_cpus
  memory           = var.memory
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = "pvscsi" # set to pvscsi if drivers are already installed in template (better performanace than LSI)
  firmware         = "efi"
  folder           = var.vmfolder
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  #Add extra disks if required
  #disk {
  #  label            = "disk1"
  #  size             = 300
  #  thin_provisioned = true
  #  unit_number      = 1
  #}

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name  = var.vm_name
        admin_password = var.admin_password
        product_key    = var.windows2022Licence
      }
      network_interface {
        ipv4_address = var.ip_address
        ipv4_netmask = var.netmask
      }
      ipv4_gateway = var.gateway
    }
  }
}
