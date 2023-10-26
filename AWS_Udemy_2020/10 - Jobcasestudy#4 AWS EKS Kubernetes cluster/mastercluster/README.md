Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/12687713#questions

Para desplegar un EKS con Terraform tenemos varios prerequisitos que haber creado en AWS:
- IAM Controler (ver eksiamrole.tf)
- 1 VPC con 3 subnets (ver eksvpc.tf)
- 1 Security Group (ver mastersg.tf)
