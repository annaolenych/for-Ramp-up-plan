README
Description
This project uses Terraform to create an AWS infrastructure, including a VPC, public and private subnets, an internet gateway, route tables, security groups, an EC2 instance, an EBS volume, and other necessary resources for the setup.

Prerequisites
Terraform installed (version 0.12 or higher).
AWS CLI installed and configured with appropriate credentials.
An SSH key pair available in the AWS region for accessing the EC2 instance (replace "new-key" in the configuration).
Usage
Clone this repository or create your Terraform file with the provided configuration.

Initialize the Terraform project by running:

bash
Копіювати код
terraform init
Review the planned infrastructure changes by running:

bash
Копіювати код
terraform plan
Apply the configuration to create the infrastructure:

bash
Копіювати код
terraform apply
You will be prompted to confirm the action. Type yes to proceed.

Once the deployment is complete, the public IP address of the EC2 instance will be displayed in the output.

Variables
The following variables are defined in the configuration file:

aws_azs: List of availability zones in the us-west-1 region.
public_subnet_cidrs: List of CIDR blocks for public subnets.
private_subnet_cidrs: List of CIDR blocks for private subnets.
Default Values
aws_azs: ["us-west-1a", "us-west-1b"]
public_subnet_cidrs: ["192.168.1.0/24", "192.168.2.0/24"]
private_subnet_cidrs: ["192.168.3.0/24", "192.168.4.0/24"]
Resources Created
VPC:

CIDR: 192.168.0.0/16
Name: Terraform_VPC
Subnets:

Public and private subnets created across the specified availability zones.
Internet Gateway:

Attached to the VPC for internet access.
Route Tables:

Public route table associated with public subnets, routing internet traffic through the internet gateway.
Security Group:

Allows ingress on port 80 (HTTP) and port 22 (SSH).
Allows all outbound traffic.
EC2 Instance:

Uses the most recent RHEL 9 AMI.
Instance type: t2.micro
Associated with a public IP address.
EBS Volume:

Size: 2GB
Attached to the EC2 instance.
Outputs
ec2_instance_ip: The public IP address of the EC2 instance, which can be used to SSH into the instance.
Cleanup
To destroy all resources created by this Terraform configuration, run:

bash
terraform destroy
This will remove all AWS infrastructure components.
