output "instance_ip" { # Output the instance ID on the terminal
  value = format("ec2-user@%s ansible_user=ec2-user", aws_instance.terraform-ec2-instance.public_ip)
}

output "output_vars" {
  value = format(
    "sed -i '5i  \\\n  vars:\\n    ansible_python_interpreter: /usr/bin/python3\\n    efs_cmd: sudo mount -t efs -o tls %s:/ /var/www/html/\\n    rds_endpoint: %s\\n    efs_mount_forever: sed -i \"2i %s:/ /var/www/html efs defaults,_netdev 0 0\" /etc/fstab' ansible/main.yml",
    aws_efs_file_system.efs.id,
    substr(aws_db_instance.rds_instance.endpoint, 0, length(aws_db_instance.rds_instance.endpoint) - 5),
    aws_efs_file_system.efs.id
  )
}



