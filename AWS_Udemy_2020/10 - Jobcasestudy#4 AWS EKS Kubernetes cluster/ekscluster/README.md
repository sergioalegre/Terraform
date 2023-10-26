Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/12687957#questions

1) Requisitos:
- aws-iam-authenticator
- kubectl


2) Configurar master node con la utilidad kubeconfig:
 - Manualmente en el archivo de configuración (.kube/config)
 ó
 - Mediante la AWS CLI


3) Revisar el estado del Cluster con: kubectl get svc


4) EKS worker nodes:
  Prerequisitos:
    - IAM Role (ver eksiamrole.tf)
    - Secutity group (ver mastersg.tf)
    - Conectividad contra el master
    - ASG (auto scaling group) (no esta en este ejemplo el codigo para ello)
    - archivo de configuracion para que el Master trabaje con los workers


5) Desplegar el Cluster


6) Configurarlo para comunicarnos con el Master editando el archivo .kube/config
