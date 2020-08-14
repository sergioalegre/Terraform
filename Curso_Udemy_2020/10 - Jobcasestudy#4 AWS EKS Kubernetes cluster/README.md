Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/12505742#questions

- Kubernetes : orquesta la infraestructura de cómputo, redes y almacenamiento para que las cargas de trabajo de los usuarios no tengan que hacerlo. Esto ofrece la simplicidad de las Plataformas como Servicio (PaaS) con la flexibilidad de la Infraestructura como Servicio (IaaS) y permite la portabilidad entre proveedores de infraestructura.

- Amazon EKS: es un servicio gestionado que facilita la ejecución de Kubernetes en AWS sin necesidad de instalar, operar y mantener su propio plano de control o nodos de Kubernetes-


Componentes de un Cluster Kubernetes: 1 Master + N nodos

Componentes del Master (el director del cluster):
- API server: gestiona el cluster mediante comandos kubectl
- Controler manager: revisa y asegura el DSC (desired starte configuration)
- Scheduler: Identifica pods sin nodo que sea susceptibles de asignar a un nodo
- etcd: almacena la info del cluster: estado de los nodos, que nodos deberian estar en ejecución


-EKS: Si se usa Amazon EKS, el control de Master lo tiene Amazon, lo despliega en 3 AZs (availability zones)
