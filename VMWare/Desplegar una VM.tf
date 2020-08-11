#Basado en https://www.altaro.com/vmware/install-terraform-vsphere/

#1- Instalar terrafrom
#2- Hacer la variable de entorno en Powershell con: setx PATH "$env:path;C:\ruta\Terraform" -m


#Contenido del main.tf
provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "P@ssw0rd"
  vsphere_server = "192.168.0.7"
  version = "~&gt; 1.11"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

#Data Sources
data "vsphere_datacenter" "dc" {
  name = "LukeLab"
}

data "vsphere_datastore" "datastore" {
  name          = "ESXi1-Internal"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Luke-HA-DRS"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "VMTemp"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#Virtual Machine Resource
resource "vsphere_virtual_machine" "web1" {
  name             = "Web1"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 4096
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
  firmware = "efi"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      windows_options {
        computer_name  = "Web1"
        workgroup      = "home"
        admin_password = "VMw4re"
      }

      network_interface {
        ipv4_address = "192.168.0.46"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.0.1"
    }
  }
}
