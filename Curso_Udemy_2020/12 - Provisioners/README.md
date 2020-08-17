Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11073128#questions

Provisioners:Para ejecutar comandos locales o remotos para configurar servidores una vez desplegados. Tambien se pueden ejecutar Ansible playbooks para alcanzar la configuración deseada.

Tipos:
- local-exec: ejecutados en local
- file: copiar archivos de local a la instancia desplegada
- remote-exec: ejecutados en la instancia desplegada
- Null resource: aquellos no asociados a una instancia concreta, genéricos
- Chef: u otra herramienta de terceros de provisioner.

1º - Ejemplo de local-exec:<br>
<p><img src="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/12%20-%20Provisioners/ejemplo_local-exec.JPG"></p>

2º - Ejemplo de remote-exec:<br>
<p><img src="https://github.com/sergioalegre/Terraform/tree/master/Curso_Udemy_2020/12%20-%20Provisioners/ejemplo_remote-exec.JPG"></p>

