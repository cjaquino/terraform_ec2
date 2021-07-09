# Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami-00399ec92321828f5 (64-bit x86) / ami-08e6b682a466887dd (64-bit Arm)
resource "aws_instance" "pilot-ec2-instance" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name = var.key-pair-name
  security_groups = ["${aws_security_group.ingress-all.id}"]

  tags = {
    Name = "UbuntuwDockerwSSH2"
  }

  subnet_id = "${aws_subnet.subnet-uno.id}"

  provisioner "file" {
    source = "init.sh"
    destination = "init.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      password    = ""
      private_key = file("uwd.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x init.sh",
      "./init.sh",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      password    = ""
      private_key = file("uwd.pem")
      host        = self.public_ip
    }
  }
}