# README

## Description

This project uses Terraform to create an AWS infrastructure, including a VPC, public and private subnets, an internet gateway, route tables, security groups, an EC2 instance, an EBS volume, and other necessary resources for the setup.

## Prerequisites

1. **Terraform** installed (version 0.12 or higher).
2. **AWS CLI** installed and configured with appropriate credentials.
3. An **SSH key pair** available in the AWS region for accessing the EC2 instance (replace `"new-key"` in the configuration).

## Usage

1. Clone this repository or create your Terraform file with the provided configuration.
2. Initialize the Terraform project by running:

   ```bash
   terraform init
   ```

3. Review the planned infrastructure changes by running:

   ```bash
   terraform plan
   ```

4. Apply the configuration to create the infrastructure:

   ```bash
   terraform apply
   ```

   You will be prompted to confirm the action. Type `yes` to proceed.

5. Once the deployment is complete, the public IP address of the EC2 instance will be displayed in the output.

## Variables

The following variables are defined in the configuration file:

- `aws_azs`: List of availability zones in the `us-west-1` region.
- `public_subnet_cidrs`: List of CIDR blocks for public subnets.
- `private_subnet_cidrs`: List of CIDR blocks for private subnets.

### Default Values

- `aws_azs`: `["us-west-1a", "us-west-1b"]`
- `public_subnet_cidrs`: `["192.168.1.0/24", "192.168.2.0/24"]`
- `private_subnet_cidrs`: `["192.168.3.0/24", "192.168.4.0/24"]`

## Resources Created

1. **VPC**:
   - CIDR: `192.168.0.0/16`
   - Name: `Terraform_VPC`

2. **Subnets**:
   - Public and private subnets created across the specified availability zones.

3. **Internet Gateway**:
   - Attached to the VPC for internet access.

4. **Route Tables**:
   - Public route table associated with public subnets, routing internet traffic through the internet gateway.

5. **Security Group**:
   - Allows ingress on port 80 (HTTP) and port 22 (SSH).
   - Allows all outbound traffic.

6. **EC2 Instance**:
   - Uses the most recent RHEL 9 AMI.
   - Instance type: `t2.micro`
   - Associated with a public IP address.

7. **EBS Volume**:
   - Size: 2GB
   - Attached to the EC2 instance.

## Outputs

- `ec2_instance_ip`: The public IP address of the EC2 instance, which can be used to SSH into the instance.

## Cleanup

To destroy all resources created by this Terraform configuration, run:

```bash
terraform destroy
```

This will remove all AWS infrastructure components.


result:
<img width="1182" alt="Screenshot 2024-10-16 at 17 50 08" src="https://github.com/user-attachments/assets/507b807e-6449-4a86-a923-eee7c5e9aa8e">

<img width="1194" alt="Screenshot 2024-10-16 at 17 50 01" src="https://github.com/user-attachments/assets/95dcbd36-5b6e-49a6-9d41-b58e0e43f326">
<img width="1187" alt="Screenshot 2024-10-16 at 17 49 09" src="https://github.com/user-attachments/assets/4f4a45b2-5d97-445c-9a0d-9ebebc452b76">
<img width="1169" alt="Screenshot 2024-10-16 at 17 48 21" src="https://github.com/user-attachments/assets/d4a35b8e-c271-40e4-97ae-ecd6bc6ec870">
<img width="1176" alt="Screenshot 2024-10-16 at 17 48 05" src="https://github.com/user-attachments/assets/8d232191-5a80-4a6a-b6c4-aa9016ad7073">
<img width="1200" alt="Screenshot 2024-10-16 at 17 47 28" src="https://github.com/user-attachments/assets/d2774123-7e8b-4ccf-b6fe-7d8dba9673b5">
<img width="541" alt="Screenshot 2024-10-16 at 17 45 59" src="https://github.com/user-attachments/assets/8e1c318f-6547-4317-9641-a04dba8d2d05">
<img width="1073" alt="Screenshot 2024-10-16 at 17 09 53" src="https://github.com/user-attachments/assets/872b628d-b3b5-4c4c-b10e-76c6d71867ba">
<img width="1077" alt="Screenshot 2024-10-16 at 17 09 46" src="https://github.com/user-attachments/assets/dd264dfd-2c35-46b9-bad7-e1071dc207a1">
<img width="1168" alt="Screenshot 2024-10-16 at 16 38 19" src="https://github.com/user-attachments/assets/e4da2af6-6af5-4edf-b183-ce9c44ec1fbb">
