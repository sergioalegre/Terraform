
<!--
REEMPLAZAR: Buscador-Ajax-similar-a-Google, TITULO, DESCRIPCION, DESCRIPCION2, DEMO, TECNOLOGIAS
-->
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/sergioalegre/Terraform">
    <img src="https://sergioalegre.es/logo.JPG" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center"><!-- TITULO -->Proyectos Terraform en: AWS - Azure - GCP - VMWare - Kubernetes</h3>

  [#AWS](#AWS)

  [#Azure](#Azure)

  [#GCP](#GCP)

  [#VMWare](#VMWare)

  [#Kubernetes](#Kubernetes)

  ------------
</p>


## AWS
<p>
  <b>#1: Webapp cluster en AWS:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/7%20-%20Jobcasestudy%231%20Webapp%20Cluster" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>Un balanceador Elastic (ELB) para 2 Webservers</li>
    <li>2 Webservers (Instancias EC2) para alta disponibilidad</li>
    <li>Un balanceador para 2 aplication Appservers</li>
    <li>2 Appservers para alta disponibilidad</li>
    <li>Autoscaling group (ASG): para ajuste automático de webservers y Appservers</li>
    <li>Un RDS (alta disponibilidad replica sincrona base de datos)</li>
    <li>Los grupos de seguridad necesarios para trabajar todo esto junto</li>
  </ul>
</p><br>


<p>
  <b>#2: NoSQL con DynamoDB en AWS y terraform:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/8%20-%20Jobcasestudy%232%20DynamoDB" target="_blank">AQUÍ</a>
</p><br>


<p>
  <b>#3: KOPS + Kubernetes + Docker: Clusters HA con Terraform:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/9%20-%20Jobcasestudy%233%20KOPS%20%2B%20Kubernetes%20%2B%20Docker" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>KOPS para orquestar el cluster de Kubernetes</li>
    <li>Kubernetes para gobernar los dockers</li>
    <li>Bucket S3 en AWS para guardar la config</li>
    <li>awscli</li>
  </ul>  
</p><br>


<p>
  <b>#4: Cluster Kubernetes AWS EKS (Elastic Kubernetes Service) con Terraform:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/10%20-%20Jobcasestudy%234%20AWS%20EKS%20Kubernetes%20cluster" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>kubectl: utilidad</li>
    <li>aws-iam-authenticator: para comunicar el Master con los Worked nodes</li>
  </ul>
</p><br>


<p>
  <b>#5: Uso de 'modules' desde archivo local, Github o Terraform Registry</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/11%20-%20Jobcasestudy%235%20Modules%20%2BELB%20%2B%20EC2" target="_blank">AQUÍ</a>
</p><br>


<p>
  <b>#6: ELK Stack (agregador de logs) en AWS:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/13%20-%20Jobcasestudy6%23%20ELK%20Stack" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>Elasticsearch: es un motor de busqueda basado en NoSQL.</li>
    <li>Logstash: es un agregador de logs capaz de filtrar datos desestructurados de diferentes fuentes</li>
    <li>Kibana: es una herramienta de visualizaion tipo graphana.</li>
    <li>Filebeat: file shipper ligero con soporte SSL y TLS</li>
  </ul>
</p><br>


<p>
  <b>#7: Aurora Cluster: DBaaS de alto rendimiento</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/16%20-%20Jobcasestudy%237%20Aurora%20DB%20Cluster" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>Aurora Cluster: Aurora forma parte del servicio de bases de datos administradas Amazon Relational Database Service (Amazon RDS). Recomendado para alto performance y muy seguro debido a las 6 copias que distribuye en 3 zonas de disponisblidad diferentes.</li>
    <li>Beneficios:</li>
    <ul>
      <li>Hasta 5x veces mas potente gracias al log-based-storage</li>
      <li>es una arquitectura sin apenas lag de replicación</li>
      <li>Multi AZ (availability zone) deploy</li>
      <li>Backup automáticos</li>
      <li>Si necesita espacio se extiende automáticamente, hasta 64Tb.</li>
      <li>Autoscaling</li>
      <li>Escribir en MySQL implica: 1º escribir en log, 2º escribir en binlog, 3º escribir en FRM, 4º doble escritura en buffer. Aurora directamente escribe en el almacenamiento (log-based-storage) no en ficheros.</li>
      <li>Failover minimo comparado con el de MySQL.</li>
  </ul>
 </ul>
</p><br>


<p>
  <b>#8: WebApp cluster en Google Cloud Platform con Terraform</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/19%20-%20Jobcasestudy%238%20Google%20Cloud%20Platform%20%2B%20Terraform" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>1x balanceador HTTP (load_balancer.tf)</li>
    <li>1x instance_group + nx instancias + opciones de Autoscaling (instance_group.tf + instance template.tf)</li>
    <li>1x google_sql_database_instance 'Master' + 1x google_sql_database_instance 'Replica' (sql.tf)</li>
    <li>1x VPC network (network.tf)</li>
    <li>Reglas de firewall (firewall.tf)</li>
    <li>ejecutaremos scripts postproceso sobre las instancias una vez desplegadas (userdata.sh)</li>
  </ul>
</p><br>


<p>
  <b>#9: WebApp stack en Azure con Terraform</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/20%20-%20Jobcasestudy%239%20Azure%20%2B%20Terraform" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>1x resource group: azurerm_resource_group</li>
    <li>1x virtual network (el equivalente a VPC de Amazon): azurerm_virtual_network</li>
    <li>1x security group</li>
    <li>1x balanceador HTTP y sus tests</li>
    <li>1x IP publica para el frontend del balanceador: azurerm_public_ip</li>
    <li>2x VM</li>
    <li>1x backend MySQL</li>
  </ul>
</p><br>

## Azure

## GCP

## VMWare

## Kubernetes

### Contact
Email: sergio.alegre.arribas EN gmail.com
<br>
LinkedIn: https://www.linkedin.com/in/sergioalegre
<br>
My certificates: http://certificates.sergioalegre.es
<br>
Website: http://me.sergioalegre.es

### Built With
<!-- TECNOLOGIAS -->
* IaC: Terraform y Ansible
* Plataformas: Amazon AWS - Google Cloud Platform - Microsoft Azure - VMware vSphere
* Kubernets y Dockers

## Getting Started
---

### Prerequisites
---

### Installation
---

## Usage
---

## Roadmap
---

## Contributing
Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License
Distributed under the MIT License. See `LICENSE` for more information.


[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/sergioalegre
