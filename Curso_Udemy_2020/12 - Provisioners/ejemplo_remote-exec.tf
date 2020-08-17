#Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11064210#questions

#Creará la instancia y despues dentro de ella instala un paquete

resource "aws_instance" "firstdemo" {
  ami = "ami-922914f7"
  instance_type = "t2.micro"
  key_name = "testaccess"
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
