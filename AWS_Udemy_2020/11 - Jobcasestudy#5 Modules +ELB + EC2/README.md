Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/10933470#questions

Los módulos son trozos de código reutilizables, como las funciones en C.

Los modulos puede ser:
  - un enlace a github
  - ruta a un archivo local
  - registry: un repo de codigo reutilizable desde la web de Terraform: https://registry.terraform.io/

En estos ejemplos se desplegara un balanceador ELB desde un module de github, y dos instancias EC2 desde Terraform Registry y desde un archivo local
