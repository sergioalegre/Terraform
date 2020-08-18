# basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/12782793#questions
resource "aws_instance" "firstdemo" {
  ami             = "ami-922914f7"
  instance_type   = "t2.micro"
  security_groups = ["demo-sg"]
  key_name        = "newck"
  tags = {
    Name = "demoinstance1"
  }
}

resource "null_resource" "provisioning" {
  depends_on = [aws_instance.firstdemo] #esperemos a que la instancia este lista antes de seguir

  provisioner "local-exec" { #llamamos al playbook de ansible
    command = "sleep 120 ; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ./newck.pem -i '${aws_instance.firstdemo.public_ip},' nginxplay.yml"
  }
}
