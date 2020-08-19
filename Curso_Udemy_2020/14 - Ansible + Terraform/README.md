Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/12782747#questions

Ansible: Plataforma de software libre para configurar y administrar ordenadores, ejecuciones de tareas ad hoc y administración de configuraciones. Adicionalmente, Ansible es categorizado como una herramienta de orquestación. Gestiona nodos a través de SSH y no requiere ningún software remoto adicional (excepto Python 2.4 o posterior) para instalarlo. Dispone de módulos que trabajan sobre JSON. Nativamente utiliza YAML para describir configuraciones reusables de los sistemas.

Comandos basicos:
- ansible --help
- ansible --version
- ansible --list-hosts all    #ver todos los hosts que Ansible tiene inventariados
- ansible --list-hosts webservers    #ver todos los hosts que Ansible tiene inventariados como webservers

Inventario: /etc/ansible/hosts donde poner los servidores agrupados por rol (webservers, dbservers, ...)

Ejemplos de comandos
<br>Nota1: si no usamos el -m es que estamos usando el modulo command
<br>Nota2: -a son los argumentos del comando
- ansible webservers -a uptime    #Aqui ejecutamos en todos los webservers el comando uptime. es equivalente a -m command -a uptime
- ansible all -m ping   #usar el modulo ping contra todos los hosts del inventario (y ver que servidores estan levantados)
- ansible-doc -l    #listar modulos preinstalados
- ansible-doc -l | grep -i netapp  #ver modulos preinstalados con la descripcion 'netapp'
- ansible-doc azure_rm_storageblob  #ver la documentacion de un modulo concreto
- ansible all -a "yum -y install httpd"   #instalar a todos el paquete httpd
- ansible <em>APP<em> -m copy -a "src=/temp/archivo.txt dest=/tmp/archivo1.txt"   #usar el modulo copy para copiar un archivo a todos los servers <em>APP<em>

Playbook: un conjunto de tareas a ejecutar en orden. Ej: instalar nginx y luego configurarlo y luego arrancarlo.

En este ejemplo usaremos Terraform con Ansible para desplegar una instancia y luego con un provisioner 'local-exec' llamar a un playbook de ansible

<img src="Terraform+AnsibleJPG.JPG">
