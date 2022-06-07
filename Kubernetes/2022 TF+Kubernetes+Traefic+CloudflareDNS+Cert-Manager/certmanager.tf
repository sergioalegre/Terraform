#otra APP desplegada por HELM para la gestion del certificado HTTPS

resource "kubernetes_namespace" "certmanager" {
    depends_on = [
        time_sleep.wait_for_kubernetes
    ]

    metadata {
        name = "certmanager"
    }
  
}

resource "helm_release" "certmanager" {

    depends_on = [
        kubernetes_namespace.certmanager
    ]

    name = "certmanager"
    namespace = "certmanager"

    repository = "https://charts.jetstack.io"
    chart = "cert-manager"

    # Install Kubernetes CRDs
    set {
        name  = "installCRDs"
        value = "true"
    }    
}

resource "time_sleep" "wait_for_certmanager" { #esperamos para que los despliegues esten listos antes de seguir

    depends_on = [
        helm_release.certmanager
    ]

    create_duration = "10s"
}

# Create a ClusterIssuer que obtendra los certificados SSL. CertManager no tiene soporte para TF pero TF puede invocar comandos con kubectl y es lo que haremos para tener CertManager
resource "kubectl_manifest" "cloudflare_prod" {

    depends_on = [
        time_sleep.wait_for_certmanager
    ]

    # aqui metemos el manifiesto de lo que queremos
    yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: cloudflare-prod
spec:
  acme:
    email: your-mail-address
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: cloudflare-prod-account-key
    solvers:
    - dns01:
        cloudflare:
          email: your-mail-address
          apiKeySecretRef:
            name: cloudflare-api-key-secret
            key: api-key
    YAML
}

resource "time_sleep" "wait_for_clusterissuer" { #otra pausa

    depends_on = [
        kubectl_manifest.cloudflare_prod
    ]

    create_duration = "30s"
}