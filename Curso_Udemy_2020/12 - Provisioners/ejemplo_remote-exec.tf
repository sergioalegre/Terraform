#Creará la instancia y despues dentro de ella ejecutará comandos
#Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11064210#questions
#IMPORTANTE: para usar remote-exec es obligatorio que el security group que usemos permita comunicacion en el puerto 22

resource "aws_instance" "firstdemo" {
  ami = "ami-922914f7"
  instance_type = "t2.micro"
  key_name = "testaccess"
  # security__goups = ["grupo_con_SSH"] #como no hemos indicado un security group, usará el por defecto, por lo que esto no funcionara si es default security group no tiene permisos de SSH
  provisioner "remote-exec" {
    inline = [
    "sudo yum -y install http://site.com/package.rpm",
    ]
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("/tmp/testaccess.pem")}"
    }
  }
}
