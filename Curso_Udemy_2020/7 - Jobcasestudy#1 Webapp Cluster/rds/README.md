Amazon Relational Database Service (RDS)

https://aws.amazon.com/es/rds/features/multi-az/

Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/10930274#questions

NOTE : Variables file has all variables - RDS,VPC,EC2,.. Ideally you will have only RDS variables here but we did not separate as this is test case

NOTE : VPC_ID in sg_rds_prod.tf has to be replaced with an existing VPC in your account

NOTE : Subnetids have to be replaced in rds_instance_production.tf with existing ones in your account
