resource "aws_instance" "Application" {
  ami           = "ami-07a0715df72e58928"
  instance_type = "t3.micro"
  key_name = "project"
  tags = {
    Name = "master"
  }
  provisioner "file" {
    source      = "./frontend.sh"
    destination = "/home/ubuntu/frontend.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("./project.pem")}"
      host        = "${self.public_dns}"
    }
  }
  provisioner "file" {
    source      = "./backend.sh"
    destination = "/home/ubuntu/backend.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("./project.pem")}"
      host        = "${self.public_dns}"
    }
  }
provisioner "file" {
    source      = "./db-sql.sql"
    destination = "/home/ubuntu/db-sql.sql"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("./project.pem")}"
      host        = "${self.public_dns}"
    }
  }
provisioner "remote-exec" {
   connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("./project.pem")}"
      host        = "${self.public_dns}"
    }
    inline = [
      "chmod +x /home/ubuntu/frontend.sh",
      "chmod +x /home/ubuntu/backend.sh",
      "./backend.sh",
      "./frontend.sh",
    ]
  }  

  }