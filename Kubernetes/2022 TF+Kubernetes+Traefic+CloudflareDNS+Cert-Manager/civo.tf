# Kubernetes Cluster

data "civo_size" "xsmall" {
    filter {
        key = "name"
        values = ["g4s.kube.xsmall"] #cogemos el mas pequeño de todos
        match_by = "re"
    }
}

resource "civo_kubernetes_cluster" "k8s_demo_1" { #recurso cluster
    name = "k8s_demo_1"
    applications = ""
    num_target_nodes = 2 #2 nodos
    target_nodes_size = element(data.civo_size.xsmall.sizes, 0).name
    firewall_id = civo_firewall.fw_demo_1.id
}

resource "civo_firewall" "fw_demo_1" {
    name = "fw_demo_1"
    create_default_rules = false #si no ponemos esto será accesible de manera predeterminada desde cualquier sitio
}

resource "civo_firewall_rule" "kubernetes_http" { #exponemos el puerto 80
    firewall_id = civo_firewall.fw_demo_1.id
    protocol = "tcp"
    start_port = "80"
    end_port = "80"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    action = "allow"
    label = "kubernetes_http"
}

resource "civo_firewall_rule" "kubernetes_https" { #exponemos el puerto 443
    firewall_id = civo_firewall.fw_demo_1.id
    protocol = "tcp"
    start_port = "443"
    end_port = "443"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    action = "allow"
    label = "kubernetes_https"
}

resource "civo_firewall_rule" "kubernetes_api" { # para que TF se comunique con el cluster o via kubectl
    firewall_id = civo_firewall.fw_demo_1.id
    protocol = "tcp"
    start_port = "6443"
    end_port = "6443"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    action = "allow"
    label = "kubernetes_api"
}

resource "time_sleep" "wait_for_kubernetes" {

    depends_on = [
        civo_kubernetes_cluster.k8s_demo_1
    ]

    create_duration = "20s"
}

data "civo_loadbalancer" "traefik_lb" {

    depends_on = [
        helm_release.traefik
    ]

    name = "k8s_demo_1-traefik-traefik" #el nombre del balanceador generado
}
