# pgSQL, create DB and backup DB in Terraform and AWS
Creates 1 virtual machin with pgSQL.
Create Database "test_database". In database create Table "customers" and fill in the data.

# Quick Start
1. Use this instuctions to install [Terraform](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started) and configurate AWS CLI 
2. Terraform will automatically search for saved API credentials in ~/.aws/credentials
3. Copy all file in one dirctory on you unix PC
4. Use command `terraform init` to initialize a working directory containing Terraform configuration files
5. Use command `terraform apply` to create VM's

# File list
1. Provider.tf - info for provider
2. Main.tf -  Create VM, copy file and run script
3. Securitygroup.tf - Create securitygroup for connect to VM
4. Subnet.tf - Create subnet to create custom network
5. Var.tf - variables
6. sql_init_file - Script for pgSQL

