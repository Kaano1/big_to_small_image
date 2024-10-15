resource "null_resource" "ec2-ip-address" {
	provisioner "local-exec" {
		command = "echo ${ format("ec2-user@%s ansible_user=ec2-user", aws_instance.terraform-ec2-instance.public_ip)} > ansible/inventory.ini"
	}

	depends_on = [aws_instance.terraform-ec2-instance]
}

resource "null_resource" "ec2-create-inventory" {
  provisioner "local-exec" {
    command = "sed -i '5i  \\\n  vars:\\\n    ansible_python_interpreter: /usr/bin/python3\\\n    efs_cmd: sudo mount -t efs -o tls ${aws_efs_file_system.efs.id}:/ /var/www/html/\\\n    rds_endpoint: ${substr(aws_db_instance.rds_instance.endpoint, 0, length(aws_db_instance.rds_instance.endpoint) - 5)}\\\n    efs_mount_forever: sed -i \"2i ${aws_efs_file_system.efs.id}:/ /var/www/html efs defaults,_netdev 0 0\"  /etc/fstab\\\n    instance_id: ${aws_instance.terraform-ec2-instance.id}' ansible/main.yml"
  }

  depends_on = [
    aws_efs_file_system.efs,
    null_resource.ec2-ip-address,
    aws_db_instance.rds_instance
  ]
}

resource "null_resource" "ansible-start" {
	provisioner "local-exec" {
		command = "cd ansible/ && ansible-playbook -i inventory.ini main.yml --private-key /home/kaan/myComputer.pem"
	}

	depends_on = [null_resource.ec2-create-inventory]
}
