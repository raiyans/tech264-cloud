# Terraform

- [Terraform](#terraform)
- [Launching an EC2 instance using terraform](#launching-an-ec2-instance-using-terraform)
  - [Adding a Security Group using Terraform](#adding-a-security-group-using-terraform)
  - [Adding Variables in Terraform](#adding-variables-in-terraform)
- [Push and Pull Configuration Management in IaC](#push-and-pull-configuration-management-in-iac)
  - [What is Push and Pull Configuration Management?](#what-is-push-and-pull-configuration-management)
    - [Push Configuration Management](#push-configuration-management)
    - [Pull Configuration Management](#pull-configuration-management)
  - [Which Tools Support Push and Pull?](#which-tools-support-push-and-pull)
  - [Does Terraform Use the Push or Pull Configuration?](#does-terraform-use-the-push-or-pull-configuration)
  - [Which is Better: Push or Pull Configuration Management?](#which-is-better-push-or-pull-configuration-management)
    - [Choosing Between Push and Pull:](#choosing-between-push-and-pull)
    - [Conclusion:](#conclusion)
- [Terraform GitHub Repository Automation](#terraform-github-repository-automation)
  - [Goal](#goal)
  - [Steps](#steps)
    - [Repository Link](#repository-link)

# Diagram of basic practical

![diagram](/images/terraform-basic.png)

### Securing Sensitive Files/Credentials

*When setting up Terraform, it is crucial to protect sensitive files, especially those containing credentials. To secure these files, you should use a .gitignore file to prevent them from being pushed to version control.*

1. Initialize Git Repository: Run `git init` in your project directory to initialize version control.
2. Create a `.gitignore` File:

*This file will specify the files and directories to be ignored by Git, helping to secure sensitive data and prevent unnecessary files from bloating the repository.*

```hcl
# .terraform.lock.hcl - Plugin version lock file (No sensitive information)
# This file locks the provider version (e.g., AWS provider version). It does not contain sensitive information, so it's not required to be ignored.
.terraform.lock.hcl

# .terraform/ - Terraform working directory (No sensitive information)
# Contains temporary files and caches. Ignored to avoid unnecessary bloat in the repository.
.terraform/

# terraform.tfstate and terraform.tfstate.backup - Sensitive files
# These files store information about the infrastructure's current state, which often includes credentials, IP addresses, and other sensitive data.
terraform.tfstate
terraform.tfstate.backup

# Variables files - Can contain sensitive data
# Terraform variables are often used to store sensitive data (e.g., AWS access keys, passwords).
*.tfvars
*.auto.tfvars
variable.tf

# Override files - Used for overriding configurations
# These files can be ignored as they are often used for custom configurations that should not be tracked.
override.tf
override.tf.json
```

***Never store AWS access keys, secret keys, or any sensitive information directly in the Terraform configuration files.***

### Creating an EC2 Instance via Terraform

1. Define the AWS Provider: Terraform requires a provider block to define which cloud provider (in this case, AWS) and region the infrastructure will be deployed in.

```hcl
provider "aws" {
  # Specify the AWS region for resource deployment
  region = "eu-west-1"
}
```

2. Create the EC2 Instance Resource: Use the aws_instance resource to define an EC2 instance. The resource block specifies the AMI ID, instance type, and other configuration details.

```hcl
resource "aws_instance" "app_instance" {
  # Specify the Amazon Machine Image (AMI) to use
  ami = "ami-0c1c30571d2dae5c9"  # Ubuntu 22.04 LTS AMI for eu-west-1

  # Specify the instance type (e.g., t2.micro for a free tier instance)
  instance_type = "t2.micro"

  # Ensure the instance is assigned a public IP address
  associate_public_ip_address = true

  # Add tags for better resource management (e.g., name, environment)
  tags = {
    Name = "tech264-raiyan-tf-app-instance"
  }
}
```

### Running Terraform Commands

*After writing the Terraform configuration, you can execute the following commands to manage your infrastructure.*

1. Initialize the Terraform Workspace: This command initializes the working directory by downloading necessary provider plugins and preparing the backend for managing the infrastructure state.

```bash
terraform init
```

2. Plan the Infrastructure Changes: This previews the changes that Terraform will make to your infrastructure based on the configuration. It checks for errors and shows a detailed execution plan without making any changes.

```bash
terraform plan
```

3. Apply the Changes: This command applies the changes outlined in the plan, creating or updating the resources as defined in the configuration.

```bash
terraform apply
```

4. Destroy the Infrastructure: This command deletes all the resources defined in the Terraform configuration, cleaning up the infrastructure.

```bash
terraform destroy
```

### Creating NSG Rules via Terraform

```hcl
provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "tech264_raiyan_tf_allow_port_22_3000_80" {

  # Allow port 22 (SSH) from localhost (127.0.0.1)
  ingress {
    description      = "Allow SSH from localhost"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow port 3000 from all (0.0.0.0/0)
  ingress {
    description      = "Allow access to port 3000 from all"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow port 80 (HTTP) from all (0.0.0.0/0)
  ingress {
    description      = "Allow access to port 80 from all"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tech264-raiyan-tf-allow-port-22-3000-80"
  }
}
```

### Creating an EC2 Instance and attaching NSG rules via Terraform

1. Update EC2 Configuration in main.tf: Ensure your EC2 instance resource block includes:
   - `key_name`: This variable references the SSH key to establish SSH connections to the EC2 instance.
   - `vpc_security_group_ids`: Requires a list of security group id's already created in AWS

```hcl
provider "aws" {
  # Region to create infrastructure
  region = "eu-west-1"
}

# Define the AWS instance and attach the existing Security Group and Key Pair
resource "aws_instance" "app_instance" {
  # Specify the AMI ID ami-0c1c30571d2dae5c9 (for Ubuntu 22.04 LTS)
  ami = "ami-0c1c30571d2dae5c9"

  # Specify the instance type - t2.micro
  instance_type = "t2.micro"

  # Add a Public IP address to this instance
  associate_public_ip_address = true

  # Attach the existing security group using the ID
  vpc_security_group_ids = ["sg-021d49f73d3a549ad"]  # Replace with your actual security group ID

  # Attach the key pair to enable SSH access
  key_name = "tech264-raiyan-aws-key"

  # Tag the instance with a name
  tags = {
    Name = "tech264-raiyan-tf-app-instance"
  }
}
```
