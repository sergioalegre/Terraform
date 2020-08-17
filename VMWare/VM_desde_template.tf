#https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine
data "vsphere_datacenter" "dc" {
  name = "poner_aqui_nombre_datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "poner_aqui_datastore"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "poner_aqui_nombre_cluster"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "poner_aqui_nombre_red"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "poner_aqui_nombre_template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name             = "poner_aqui_nombre_VM"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
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
        computer_name  = "poner_aqui_nombre_VM"
        workgroup      = "test"
        admin_password = "VMw4re"
      }

        network_interface {
          ipv4_address = "poner_aqui_IP"
          ipv4_netmask = 25 #poner la mascara
        }
        ipv4_gateway = "poner_aqui_nombre_gateway"
      }
    }
  }
