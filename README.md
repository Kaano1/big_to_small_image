The Big_to_small_image application stores user information entered into a PHP-based website on AWS RDS and uploads user-submitted images to AWS S3 buckets every 2 minutes. These images are automatically resized, and when accessing user information, the images are displayed in their smaller form. This system is built on AWS infrastructure using Terraform and Ansible.

## Requirements

1. **Terraform**: Download and install Terraform. [Download Terraform](https://www.terraform.io/downloads.html)
2. **Ansible**: Download and install Ansible. [Download Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
3. **AWS Account**: Create an AWS account. [Create AWS Account](https://aws.amazon.com/)
4. **AWS Access Keys**: Update the `access key` and `secret key` in the `ansible/source/setAWS.sh` file with your own AWS credentials.
5. **Region Settings**: Set the desired AWS region. Currently, Stockholm (eu-north-1) is selected, but you can configure it to your preferred region.
6. **Mail YML File**: Pay attention to the `source/mail.yml` file. During the execution of `del_vars.sh`, some lines may have been unintentionally removed. Please verify and correct as needed.

### Installation

Once you meet the requirements, simply run the `make` command in the terminal to start the installation process.
