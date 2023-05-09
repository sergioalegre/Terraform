## Description
This is the repository containing the files required to automate the creation of the infrastructure of the startup using terraform.

## Project Requirements
The infrastructure includes 4 web servers and 2 databases. The requirements are:
- High availability
- Unique naming of each instance
- Installation of apache webserver on the instances

## Architecture diagram
To meet the requirements, the 4 web servers will be created in 2 public subnets in 2 different 
availability zones while the database instances will be created in 2 private subnets in 2 availabilty zones as the web servers. 

Here's the architecture diagram:

![Architectural Diagram for Startup)](https://github.com/sergioalegre/Terraform/AWS+Terraform+Github+Jenkins CICD.png)

## Introduction
In this project, I set up infrastructure on the AWS cloud using Terraform. The infrastructure includes 4 web servers and 2 database instances. The specific tasks done include:

### Tasks:
- Writing a Terraform Script that provisions the servers and databases in a highly available environment.
- Uniquely naming each instance and Install Apache on the instances
- Pushing the Terraform script to GitHub for version control.
- Creating a Jenkins job that automatically detects changes in the terraform script on GitHub and deploys the changes.


## Project Execution

### Infrastructure Architecture Design:
The very first step done was to determine the AWS resources required to meet the design needs and then designing the infrastructure architecture of the system. This step includes deciding on the AWS services required for the task, defining the infrastructure components, and their relationships.

Here is the architecture diagram of the resources required in AWS cloud to meet the requirements:

architecture diagram

In this diagram, the resources represented are defined below:

1. Virtual Private Cloud:

With Amazon Virtual Private Cloud (Amazon VPC), you can launch AWS resources in a logically isolated virtual network that you've defined. This virtual network closely resembles a traditional network that you'd operate in your own data center, with the benefits of using the scalable infrastructure of AWS.
Tap here for more.

Using terraform, I defined the VPC resource for the startup and assigned a CIDR block of 10.0.0.0/16 to the VPC. This means IP addresses that fall within this range can be assigned to resources used in this VPC.

VPC CIDR Block

2. Region:

AWS has the concept of a Region, which is a physical location around the world where we cluster data centers. We call each group of logical data centers an Availability Zone. Each AWS Region consists of a minimum of three, isolated, and physically separate AZs within a geographic area.
Tap here for more

The selected region for the deployment of the startup’s cloud architecture is eu-west-2(London) as seen below:

AWS Regions

3. Availability zones:

An Availability Zone (AZ) is one or more discrete data centers with redundant power, networking, and connectivity in an AWS Region.
Tap here for more.

I defined it as shown below:

Availability zones

4. Public subnets:
A public subnet is a subnet that has a route to the internet gateway. It allows resources within the subnet to communicate with the internet via the internet gateway.

In order to ensure high availability, 2 subnets were chosen in which the web servers were deployed and the subnets were placed in the created VPC which was defined above.

public subnet

5. Private Subnet:
A private subnet is a subnet that is not accessible from the Internet because it has no route to the internet via the internet gateway. Private subnets are used to house resources such as databases and other services that should not be accessible by the pubic.

The private subnets used in this project were used to house the database instances created because access to a database should not be allowed over the internet except otherwise stated.

private subnets

6. EC2 Instances (Web servers):
EC2 instances are virtual servers that can be launched within a VPC. They can be configured with various operating systems and come in different sizes and configurations to meet different workload requirements. The chosen instance type in this project is t2.micro with ubuntu amis selected.

EC2 instances

The instances created serve as the web servers for this project. 2 were created in each availability zone to ensure high availability. Apache installation data was also included in the user data resource so that when the instances are created, they are created with apache installed immediately the instance spins up. These instances are placed in the public subnet so that they can be accessed over the internet.

web servers

User data

7. RDS Databases:

Amazon Relational Database Service (RDS) is a fully-managed database service that provides easy scalability, high availability, and security for relational databases such as MySQL, PostgreSQL, Oracle etc. Tap here for more.

MySQL engine with a t2.micro instance class and an allocated storage of 5 gigabytes were provisioned in 2 availability zones to ensure high availability.

MySQL engine

Relational Database

8. Route Tables:

A route table contains routes used for the direction of traffic to or from the resources within a VPC. It can be associated with one or more subnets. Route tables directing traffic from the public web servers to the internet, from the database instances to the web servers and among the web servers in the VPC as well.

This route table routes IP addresses of the web servers in the VPC to the internet gateway.

route table

This is the route table for the database instances.

route table for the database instances

The route tables are now associated with the IP addresses in the subnets in which they direct traffic.

Associated RTB

9. Security groups:
Security groups act as a virtual firewall that controls inbound and outbound traffic for EC2 instances and other resources within a VPC. They are associated with one or more instances and can be configured to allow or deny specific types of traffic.

This security group allows access from the internet using HTTP to the EC2 instance hosting the apache server and allows the exit of any protocol type from the instance to the internet.

security group

Here, one of the web servers is accessed over the internet using the HTTP protocol.

web server

11. Internet Gateway:
An internet gateway is responsible for allowing traffic in a VPC to the public internet.

internet gateway

12. Application load balancer:
A Load Balancer is a service that is responsible for distributing incoming traffic to specified targets within a VPC.

This ensures that load is evenly distributed across the web server resources.

13. User browser:
A user browser is the application through which users access and interact with web-based applications running on EC2 instances or other resources within a VPC. It sends HTTP requests to the application and receives HTTP responses in return.

user browser

### Set up the AWS account:
Once the infrastructure design is ready, the next step is to set up an AWS account, create a Virtual Private Cloud (VPC), and launch the necessary resources such as subnets, route tables, internet gateway, and security groups. It is important to follow the best practices and ensure that the resources are distributed across multiple availability zones (AZs) for high availability.

This is done using AWS configure on using AWS CLI commands.

AWS configure

### Configure Terraform:
Initialize Terraform: Once the Terraform script is written, it needs to be initialised using the "terraform init" command. This command downloads the necessary plugins and modules.

terraform init

Plan the changes: The "terraform plan" command is used to create an execution plan. It shows the resources that Terraform will create, update or delete.

terraform plan

Apply the changes: Finally, the "terraform apply" command is used to apply the changes to the AWS infrastructure. This creates the instances, installs Apache, and configures them as per the Terraform script.

terraform apply

Destroy infrastructure: After the infrastructure has come to end of life, it is destroyed using “terraform destroy”.

terraform destroy

Push to GitHub: Once the Terraform script is tested and verified, it needs to be pushed to a GitHub repository for version control. This ensures that any changes made to the script are tracked and can be rolled back if required. The codes used are “git pull origin main”, “git add .”, “git commit -m ‘your commit message’ and “git push -u main”.

GitHub

The link to the github repository containing the terraform files can be found here.

After “terraform apply” completes, the created VPC, subnets, route tables and their associations and the database instances are shown in the images below:

Resources created

Resources created 2

Resources created 3

## Jenkins Pipeline:
I created a pipeline named “startup-terraform-cicd-pipeline” and checked the Github project box and then pasted the link to the repository being used.

pipeline

I then chose the build trigger which will lead to the automation of the integration and deployment of infrastructure. Jenkins monitors the GitHub repo for changes and then builds accordingly by applying whatever changes have been committed to the repo for the new build and it does this continuously.

build trigger

The pipeline script contains 3 stages for the build to go through before the infrastructure changes are applied. The stages are “git checkout”, “Terraform init”, “Terraform apply”.

pipeline script

After these settings are applied and saved, I ran the build and a screenshot of the stages passed through to completion is shown below:

completion

completion

The resources are successfully deployed in the AWS account and in the selected region as provisioned in the terraform script.

success

Resources

Resources

## Conclusion:
In conclusion, this project involved creating a highly available environment with Terraform, uniquely naming each instance, and installing Apache on the instances. The Terraform script was pushed to GitHub for version control, and a Jenkins job was created to automatically detect changes in the Terraform script and deploy them.

By completing this project, skill in using Terraform to provision infrastructure, working with version control in GitHub, and creating a CI/CD pipeline with Jenkins was displayed. This project provides a practical example of how these tools can be used together to streamline the deployment process and ensure that the infrastructure of the startup is highly available and reliable.