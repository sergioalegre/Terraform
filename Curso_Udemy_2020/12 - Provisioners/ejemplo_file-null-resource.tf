#Basado en: https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11073130#questions

#Ejemplo de file provision y null resource: copiaremos un fichero a una instacia ya creada. No la vamos a crear

resource "null_resource" "cluster" {
  provisioner "file" {
    source = "/tmp/archivo.log"
    destination = "/tmp/archivo.log"
    connection {
      type = "ssh"
      host = "18.191.227.101" #instancia donde copiaremos el fichero
      user = "ubuntu"
      private_key = "${file("/tmp/testaccess.pem")}"
    }
  }
}
