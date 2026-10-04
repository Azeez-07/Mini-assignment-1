# AWS Infrastructure Automation with Terraform

## 📌 Project Overview

This project demonstrates how to provision and manage AWS infrastructure using **Terraform** and **Infrastructure as Code (IaC)**.

The infrastructure is designed using reusable Terraform modules and includes networking, compute, security, static IP management, remote Terraform state storage, and CloudWatch monitoring.

The project includes:

- Amazon VPC
- Public and Private Subnets
- Internet Gateway
- Public and Private Route Tables
- Route Table Associations
- Security Group
- Multiple EC2 Instances
- Elastic IP
- Amazon S3
- Terraform Remote Backend
- Amazon CloudWatch CPU Monitoring

---

## 🏗️ Architecture

```text
                         AWS Cloud
                             |
                             |
                    +--------v--------+
                    |       VPC       |
                    |   10.0.0.0/16   |
                    +--------+---------+
                             |
                +------------+------------+
                |                         |
                v                         v
        +---------------+         +----------------+
        | Public Subnet |         | Private Subnet |
        | 10.0.1.0/24   |         | 10.0.2.0/24    |
        +-------+-------+         +----------------+
                |
                v
        +---------------+
        | Internet      |
        | Gateway       |
        +-------+-------+
                |
                v
        +---------------+
        | Public Route  |
        | Table         |
        +-------+-------+
                |
                v
        +---------------+
        | EC2 Instances |
        +-------+-------+
                |
                v
        +---------------+
        |  Elastic IP   |
        +---------------+

                EC2
                 |
                 v
        +----------------+
        |   CloudWatch   |
        | CPU Monitoring |
        +----------------+

        +----------------+
        |   Amazon S3    |
        | Terraform      |
        | Remote State   |
        +----------------+
```

---

## ☁️ AWS Resources

### 1. VPC

A custom Amazon VPC is created with the following CIDR block:

```text
10.0.0.0/16
```

The VPC provides an isolated networking environment for the AWS resources used in this project.

---

### 2. Public Subnet

A public subnet is created with:

```text
CIDR: 10.0.1.0/24
Availability Zone: us-east-1a
```

The public subnet is associated with the public route table.

The public route table contains a default route:

```text
0.0.0.0/0 → Internet Gateway
```

This allows resources placed in the public subnet to communicate with the internet.

---

### 3. Private Subnet

A private subnet is created with:

```text
CIDR: 10.0.2.0/24
Availability Zone: us-east-1a
```

The private subnet is associated with a separate private route table.

The private subnet does not have a direct route to the Internet Gateway and is therefore not directly exposed to the internet.

---

### 4. Internet Gateway

An Internet Gateway is attached to the VPC.

It provides internet connectivity to resources in the public subnet through the public route table.

```text
Public Subnet
      |
      v
Public Route Table
      |
      v
Internet Gateway
      |
      v
  Internet
```

---

### 5. Route Tables

Two route tables are configured:

#### Public Route Table

The public route table is associated with the public subnet and contains:

```text
0.0.0.0/0 → Internet Gateway
```

#### Private Route Table

The private route table is associated with the private subnet.

No direct Internet Gateway route is configured for the private subnet.

---

## 🔐 Security Group

A security group is created and attached to the EC2 instances.

The current configuration allows inbound traffic on:

| Port | Protocol | Purpose |
|------|----------|---------|
| 22 | TCP | SSH |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |

The security group is associated with the VPC created by the Terraform VPC module.

> This configuration is intended for learning and testing. In a production environment, SSH access should be restricted to trusted IP addresses instead of allowing access from `0.0.0.0/0`.

---

## 💻 EC2 Instances

A reusable Terraform EC2 module is used to create multiple EC2 instances.

The same module can be reused with different input values such as:

- AMI ID
- Instance type
- Instance name
- Key pair
- Subnet
- Security Group

This demonstrates how Terraform modules can be reused instead of writing separate EC2 resource configurations for every instance.

The project uses different operating system images for the EC2 instances as part of the assignment.

---

## 🌐 Elastic IP

An Elastic IP is created using Terraform and associated with an EC2 instance.

The Elastic IP provides a static public IPv4 address for the instance.

```text
EC2 Instance
     |
     v
Elastic IP
```

The Elastic IP module also demonstrates how one Terraform module can use an output from another module.

---

## 📊 CloudWatch Monitoring

A dedicated CloudWatch module is used to monitor EC2 CPU utilization.

The module accepts:

```text
instance_id
cpu_threshold
```

The CloudWatch alarm monitors:

```text
Metric: CPUUtilization
Namespace: AWS/EC2
Statistic: Average
```

The alarm is configured to trigger when CPU utilization exceeds the configured threshold for the specified evaluation period.

Example:

```text
EC2 Instance
      |
      | CPU Utilization
      v
  CloudWatch
      |
      v
 CPU Alarm
```

The CloudWatch module outputs the alarm name.

---

## 🪣 Amazon S3 – Terraform Remote State

Amazon S3 is used as the Terraform remote backend.

The Terraform state file is stored remotely in an S3 bucket instead of relying only on the local machine.

```text
Terraform
    |
    v
Amazon S3
    |
    v
terraform.tfstate
```

The S3 bucket is configured with versioning to help maintain previous versions of stored state objects.

The remote backend allows Terraform state to be maintained separately from the local working directory.

---

## 📦 Terraform Module Structure

The project follows a modular architecture.

```text
Terraform Project/
│
├── main.tf
├── provider.tf
├── terraform.tf
├── s3.tf
├── .gitignore
│
└── module/
    │
    ├── VPC/
    │   ├── vpc.tf
    │   ├── subnet.tf
    │   ├── igw.tf
    │   ├── routetable.tf
    │   ├── rtassociation.tf
    │   └── output.tf
    │
    ├── Securitygroup/
    │   └── securitygroup.tf
    │
    ├── ec2/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── output.tf
    │
    ├── ElasticIP/
    │   ├── elasticIP.tf
    │   ├── eipassociation.tf
    │   └── output.tf
    │
    └── CloudWatch/
        ├── main.tf
        ├── variables.tf
        └── output.tf
```

---

## 🔄 Module Flow

The Terraform modules communicate with each other using variables and outputs.

```text
                 VPC Module
                     |
                     | VPC ID
                     v
             Security Group
                     |
                     | Security Group ID
                     v
                EC2 Module
                     |
                     | Instance ID
              +------+------+
              |             |
              v             v
         Elastic IP     CloudWatch
         Association       Alarm
```

This allows the infrastructure to remain modular and reusable.

---

## 🛠️ Terraform Commands

### Initialize Terraform

```bash
terraform init
```

### Format Terraform files

```bash
terraform fmt -recursive
```

### Validate the configuration

```bash
terraform validate
```

### Preview infrastructure changes

```bash
terraform plan
```

### Deploy the infrastructure

```bash
terraform apply
```

### Destroy the infrastructure

```bash
terraform destroy
```

---

## 🔒 Security

Sensitive files and Terraform state files are excluded from Git using `.gitignore`.

The repository should never contain:

```text
*.pem
*.key
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
.terraform/
```

AWS credentials should never be hardcoded inside Terraform configuration files.

---

## 🎯 Project Objectives

The main objectives of this project were to gain hands-on experience with:

- Infrastructure as Code
- Terraform modules
- Terraform variables and outputs
- AWS VPC networking
- Public and private subnet architecture
- Internet Gateway
- Route tables
- Security Groups
- EC2 provisioning
- Elastic IP management
- Amazon S3 remote state
- CloudWatch monitoring
- Modular Terraform architecture

---

## 🚀 Future Improvements

The following improvements can be added to make the architecture more production-oriented:

- NAT Gateway for private subnet outbound connectivity
- Multiple Availability Zones
- Application Load Balancer
- Auto Scaling Group
- SNS notifications for CloudWatch alarms
- More restrictive Security Group rules
- IAM roles for AWS services
- CI/CD pipeline for Terraform
- Separate development, staging, and production environments

---

## ⚠️ Disclaimer

This project was created for educational purposes and hands-on DevOps practice.

The configuration demonstrates core AWS and Terraform concepts and is not intended to represent a complete production-ready architecture.
