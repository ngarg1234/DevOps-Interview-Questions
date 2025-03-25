output "instance_public_ip" {
  #value = "${aws_instance.db_instance.public_ip}"
  value = ["${aws_instance.db_instance.*.public_ip}"]
}
