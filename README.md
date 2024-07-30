# Jenkins Server Deployment on AWS

This Terraform script deploys a Jenkins server on AWS EC2 instance.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS account with appropriate permissions

## Usage

1. Clone this repository or create a new directory and save the Terraform script as `main.tf`.

2. Update the following in the `main.tf` file:
   - Replace `**********` with your actual AWS access key and secret key
   - Replace `"terraform"` in the `key_name` field with your actual EC2 key pair name

3. Initialize the Terraform working directory:

   ' terraform init '

4. Review the planned changes:

   ' terraform plan '

5. Apply the Terraform configuration to create the resources:

   ' terraform apply '

   Type `yes` when prompted to confirm the action.

6. Once the deployment is complete, Terraform will output the public IP address of the EC2 instance.

7. Access Jenkins:
- Wait a few minutes for the instance to fully initialize and Jenkins to start
- Open a web browser and navigate to `http://<public-ip>:8080`
- Retrieve the initial admin password from the EC2 instance:
  ```
  ssh -i /path/to/your/key.pem ubuntu@<public-ip>
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  ```
- Use this password to unlock Jenkins and complete the setup

## Cleaning Up

To remove all resources created by this Terraform script:

  ' terraform destroy '
    
  Type `yes` when prompted to confirm the action.

## Security Note

The current configuration opens port 22 (SSH) and 8080 (Jenkins) to the entire internet (0.0.0.0/0). For production use, it's recommended to restrict these to specific IP ranges.

## Customization

You can modify the script to change:
- Instance type
- Region
- AMI ID
- Volume size
- Security group rules
- Tags

Remember to run `terraform plan` after any modifications to review the changes before applying them.
