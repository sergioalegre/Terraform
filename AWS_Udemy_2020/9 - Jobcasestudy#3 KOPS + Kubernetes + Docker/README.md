Escenario: KOPS + Kubernetes + Docker: Desplegar Clusters HA con Terraform

- KOPS : helps you create, destroy, upgrade and maintain production-grade, highly available, Kubernetes clusters from the command line
- Kubernetes : orquesta la infraestructura de cómputo, redes y almacenamiento para que las cargas de trabajo de los usuarios no tengan que hacerlo. Esto ofrece la simplicidad de las Plataformas como Servicio (PaaS) con la flexibilidad de la Infraestructura como Servicio (IaaS) y permite la portabilidad entre proveedores de infraestructura.


1) Install KOPS

  wget https://github.com/kubernetes/kops/releases/download/1.10.0/kops-linux-amd64
  chmod +x kops-linux-amd64
  mv kops-linux-amd64 /usr/local/bin/kops


2) Install Kubectl

  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl


3) Setup S3 bucket #necesitamos un bucket para almacenar la config, le llamamos kbdatacorp

4) Setup hosted Zone en AWS #poner tu nombre de dominio y los nameservers de tu hosting provider

5) Public keys

  ssh-keygen -f ~/.ssh/kbdatacorplogin


6) awscli setup

  ver como se instala en internet
  comprobar que funciona con el comando: aws s3 ls | wc -l


7) Terraform setup

8) Crear el cluster KOPS #aunque no lo parezca es todo un solo comando

  kops create cluster \
    --name=kbdatacorp.com \
    --state=s3://kbdatacorp\
    --authorization RBAC \
    --zones=us-east-2a \
    --node-count=2 \
    --node-size=t2.micro \
    --master-size=t2.micro \
    --master-count=1 \
    --dns-zone=kbdatacorp.com \
    --out=aws_terraform \
    --target=terraform \
    --ssh-public-key=~/.ssh/kbdatacorplogin.pub


#KOPS habra creado en /aws_terraform/kubernetes.tf el codigo generado por KOPS para crear el cluster

9) terraform init y terraform apply #desplegar el cluster que KOPS ha preparado para nosotros

10) Revisar el estado del cluster

  [root@ip-172-31-32-211 devopsinuse_terraform]# kops validate cluster

  Using cluster from kubectl context: kbdatacorp.com

  Validating cluster kbdatacorp.com

  INSTANCE GROUPS
  NAME                    ROLE    MACHINETYPE     MIN     MAX     SUBNETS
  master-us-east-2a       Master  t2.micro        1       1       us-east-2a
  nodes                   Node    t2.micro        2       2       us-east-2a

  NODE STATUS
  NAME                                            ROLE    READY
  ip-172-20-34-212.us-east-2.compute.internal     node    True
  ip-172-20-35-251.us-east-2.compute.internal     node    True
  ip-172-20-45-162.us-east-2.compute.internal     master  True


  Your cluster kbdatacorp.com is ready

11) Cuando ya no necesitemos el cluster podemos usar: kops delete cluster --name kbdatacorp.com --yes
