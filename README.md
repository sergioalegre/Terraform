
<!--
REEMPLAZAR: Buscador-Ajax-similar-a-Google, TITULO, DESCRIPCION, DESCRIPCION2, DEMO, TECNOLOGIAS
-->
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/sergioalegre/Terraform">
    <img src="http://sergioalegre.es/logo.JPG" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center"><!-- TITULO -->Practicas con Terraform en: AWS - Azure - GCP - vSphere</h3>

  <p>
    <!-- DESCRIPCION -->Terraform es una herramienta de orquestación de código abierto desarrollado por Hashicorp que nos permite definir nuestra infraestructura como código, esto quiere decir que es posible escribir en un fichero de texto la definición de nuestra infraestructura usando un lenguaje de programación declarativo y simple.
    <br>
    Terraform tiene soporte para una gran cantidad de proveedores de infraestructura local o en la nube, <b>Amazon Web Services (AWS), Microsoft Azure, Google Cloud Platform o VMware vSphere</b>.
    <br /><br />
    <a href="https://github.com/sergioalegre/Terraform"><strong>Explore the docs »</strong></a>
    ·
    <a href="https://github.com/sergioalegre/Terraform/issues">Report Bug</a>
    ·
    <a href="https://github.com/sergioalegre/Terraform/issues">Request Feature</a>
  </p>
</p>

<p align="center"><img src="http://sergioalegre.es/github_screenshots/terraform-azure.jpg" alt="Terraform Azure" width="600" ></p>

## PROYECTOS
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
  
</p>


<p>
  <b>#2: NoSQL con DynamoDB en AWS:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/8%20-%20Jobcasestudy%232%20DynamoDB" target="_blank">AQUÍ</a>
</p>


<p>
  <b>#3: KOPS + Kubernetes + Docker: Desplegar Clusters HA con Terraform:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/9%20-%20Jobcasestudy%233%20KOPS%20%2B%20Kubernetes%20%2B%20Docker" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>KOPS para orquestar el cluster de Kubernetes</li>
    <li>Kubernetes para gobernar los dockers</li>
    <li>Bucket S3 en AWS para guardar la config</li>
    <li>awscli</li>
  </ul>  
</p>


<p>
  <b>#4: Desplegar cluster Kubernetes AWS EKS (Elastic Kubernetes Service) con Terraform:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/10%20-%20Jobcasestudy%234%20AWS%20EKS%20Kubernetes%20cluster" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>kubectl: utilidad</li>
    <li>aws-iam-authenticator: para comunicar el Master con los Worked nodes</li>
  </ul>
</p>


<p>
  <b>#5: Uso de modulos desde archivo local, Github o Terraform Registry</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/11%20-%20Jobcasestudy%235%20Modules%20%2BELB%20%2B%20EC2" target="_blank">AQUÍ</a>
</p>


<p>
  <b>#6: Desplegar ELK Stack en AWS:</b>
  ver este proyecto <a href="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/13%20-%20Jobcasestudy6%23%20ELK%20Stack" target="_blank">AQUÍ</a>
  <ul style="padding-left: 10%">
    <li>Elasticsearch: es un motor de busqueda basado en NoSQL.</li>
    <li>Logstash: es un agregador de logs capaz de filtrar datos desestructurados de diferentes fuentes</li>
    <li>Kibana: es una herramienta de visualizaion tipo graphana.</li>
    <li>Filebeat: file shipper ligero con soporte SSL y TLS</li>
  </ul>
</p>


## Contact
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
