#Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11064176#questions

#1- Resource Group
resource "aws_security_group" "allow_elk4" {
  name        = "allow_elk4"
  description = "All all elasticsearch traffic"

  #vpc_id = "${aws_vpc.main.id}"

  # elasticsearch port
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # logstash port
  ingress {
    from_port   = 5043
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # kibana ports
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#2 - Instancia
resource "aws_instance" "elk" {
  ami           = "ami-5e8bb23b"
  instance_type = "t2.medium"
  key_name      = var.key
  vpc_security_group_ids = [
    aws_security_group.allow_elk4.id,
  ]

  provisioner "file" { #cambiamos la config de elasticsearch para admitr conexiones
    content     = "network.bind_host: 0.0.0.0"
    destination = "/tmp/elasticsearch.yml"
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "file" { #cambiamos la config de kibana para admitr conexiones
    content     = "server.host: 0.0.0.0"
    destination = "/tmp/kibana.yml"
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "file" { #cambiamos la config de logstash para admitr conexiones
    content     = "http.host: 0.0.0.0"
    destination = "/tmp/logstash.yml"
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "file" { #copiamos este archivo a la instancia
    source      = "filebeat.yml"
    destination = "/tmp/filebeat.yml"
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "file" { #copiamos este archivo a la instancia
    source      = "beats.conf"
    destination = "/tmp/beats.conf"
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "remote-exec" { #instalamos los componenetes con el script
    script = "elasticsearch.sh"
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  depends_on = [aws_security_group.allow_elk4] # para que no se ejecute hasta que el security group no haya sido creado
}

#3- Asignar una ElasticIP a la instancia
resource "aws_eip" "ip" {
  instance = aws_instance.elk.id
}
