Este es un deploy para:
- Un balanceador Elastic (ELB) para 2 Webservers
- 2 Webservers (Instancias EC2) para alta disponibilidad
- Un balanceador para 2 aplication Appservers (ELB)
- 2 Appservers para alta disponibilidad
- Un RDS (alta disponibilidad replica sincrona base de datos)
- Autoscaling group (ASG): para ajuste automático de webservers y Appservers
- Los grupos de seguridad necesarios para trabajar todo esto junto


Notas:
- VPC subfolder can be used to test VPC code independently to create vpc using terraform
- RDS subfolder can be used to test RDS code independently to create RDS using terraform
- Fullstack subfolder can be used to deploy all the stack components - VPC,RDS,Appservers,Webservers in one go
