resource "aws_instance" "db_instance" {
  count   = 1
  instance_type = "t2.micro"
  ami           = "ami-0943382e114f188e8"
  key_name      = "BastionKey"
  subnet_id     = "subnet-d94cafa0"
  vpc_security_group_ids      = ["sg-0a44108342b2e84d6"]
  associate_public_ip_address = true
   connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/BastionKey.pem")
   # private_key = "${file("/home/ubuntu/.ssh/BastionKey.pem")}"
    # file("${path.module}/my-key")
    #private_key = "file(/home/ubuntu/.ssh/BastionKey.pem)"
    host        = self.public_ip
  }
   provisioner "file" {
    source      = "install_mysql.sh"
    destination = "/home/ubuntu/install_mysql.sh"
  }
   provisioner "remote-exec" {
    inline = [
      "sleep 2m",
      "sudo apt get update",
      "chmod +x /home/ubuntu/install_mysql.sh",
      "/home/ubuntu/install_mysql.sh ${var.dbpass}",
    ]
  }
  }
#resource "null_resource" "example1" {
#  provisioner "local-exec" {
#    command = "echo ${aws_instance.db_instance[0].public_ip} >> ./ip_addr.txt"  
#  }
#}
