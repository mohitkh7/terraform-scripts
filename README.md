# AWS Infrastructure with Terraform

This repository contains Terraform scripts to provision AWS resources for S3, EC2, Serverless (Lambda & API Gateway), and ECS (Fargate).

## Table of Contents
- [Directory Structure](#directory-structure)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Common Terraform Commands](#common-terraform-commands)
- [Contributing](#contributing)
- [License](#license)

## Directory Structure

- `s3/`: Terraform scripts for provisioning S3 buckets.
- `ec2/`: Terraform scripts for provisioning EC2 instances.
- `serverless/`: Terraform scripts for provisioning serverless functions (Lambda).
- `container/`: Terraform scripts for provisioning ECS (Elastic Container Service) resources.

## Prerequisites

1. **AWS Credentials:**
   Ensure you have AWS credentials configured with the necessary permissions. You can set these up using the AWS CLI or by configuring environment variables.

2. **Terraform Installation:**
   Make sure Terraform is installed on your machine. You can download it from [Terraform Downloads](https://www.terraform.io/downloads.html).

## Usage

1. Navigate to the respective directory for the resource you want to provision (e.g., `cd s3/`).
2. Initialize Terraform: `terraform init`
3. Review and modify the variables in `terraform.tfvars` as needed.
4. Execute the Terraform plan: `terraform plan`
5. If the plan looks good, apply the changes: `terraform apply`
6. Confirm by typing `yes` when prompted.

## Common Terraform Commands

- `terraform init`: Initializes the working directory, downloads providers, and sets up backend.
- `terraform plan`: Creates an execution plan showing what Terraform will do.
- `terraform apply`: Applies the changes required to reach the desired state.
- `terraform destroy`: Destroys the Terraform-managed infrastructure.
- `terraform validate`: Validates the configuration files in a directory.
- `terraform fmt`: Rewrites Terraform configuration files to a canonical format.
- `terraform state`: Used for advanced state management.

For more information on Terraform commands, refer to the [Terraform CLI Documentation](https://www.terraform.io/docs/cli/commands/index.html).

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
