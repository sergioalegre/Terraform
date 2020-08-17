#Basado en: https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11073210#questions

#Una vez creada la instacncia guardara en un archivo local la IP que le ha dado AWS

resource "aws_instance" "firstdemo" {
  ami = "ami-922914f7"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.firstdemo.private_ip} >> private_ips.txt" #ejemplo de local-exec
  }
  tags {
    Name = "threedemoinstance"
  }
}
