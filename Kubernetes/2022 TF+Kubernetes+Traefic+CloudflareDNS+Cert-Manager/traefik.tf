# Traefik Deployment: balanceador de tráfico

resource "kubernetes_namespace" "traefik" { #creamos su propio namespace para que no se despliegue en el namespace default
    depends_on = [
        time_sleep.wait_for_kubernetes
    ]

    metadata {
        name = "traefik"
    }
}

resource "helm_release" "traefik" {
    depends_on = [ #asi nos aseguramos que no sigue hasta que la dependencia no este creada y no de error
        kubernetes_namespace.traefik
    ]

    name = "traefik"
    namespace = "traefik"

    repository = "https://helm.traefik.io/traefik"
    chart = "traefik"

    # Set Traefik as the Default Ingress Controller
    set {
        name  = "ingressClass.enabled"
        value = "true"
    }
    set {
        name  = "ingressClass.isDefaultClass"
        value = "true"
    }
    
    # Default Redirect
    set {
        name  = "ports.web.redirectTo"
        value = "websecure"
    }

    # Enable TLS on Websecure
    set {
        name  = "ports.websecure.tls.enabled"
        value = "true"
    }

}