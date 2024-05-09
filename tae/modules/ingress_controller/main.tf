############################# Add Kubernetes Config to AWS ##############################
# resource "null_resource" "install_ingress_ctroller" {
#   provisioner "local-exec" {
#     command = "kubectl apply -f ${var.yaml_location}"
#   }
# }

resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
    labels = {
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/instance"  = "ingress-nginx"
    }
  }
}

# Source: ingress-nginx/templates/controller-serviceaccount.yaml
resource "kubernetes_service_account" "controller-serviceaccount" {
  metadata {
    labels = {
      "helm.sh/chart"                = "ingress-nginx-4.0.15"
      "app.kubernetes.io/name"       = "ingress-nginx"
      "app.kubernetes.io/instance"   = "ingress-nginx"
      "app.kubernetes.io/version"    = "1.1.1"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/component"  = "controller"
    }
    name      = "ingress-nginx"
    namespace = "ingress-nginx"
  }
  automount_service_account_token = true
  
  # depends_on = [ kubernetes_namespace.ingress-nginx ]
}

# Source: ingress-nginx/templates/controller-configmap.yaml
resource "kubernetes_config_map" "controller-configmap" {
  metadata {
    labels = {
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/component" = "controller"
    }
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }
  data = {
    "allow-snippet-annotations" = true
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_service_account.controller-serviceaccount
  # ]
}

# Source: ingress-nginx/templates/clusterrole.yaml
resource "kubernetes_cluster_role" "clusterrole" {
  metadata {
    labels = {
      "helm.sh/chart"             = "ingress-nginx-4.0.15"
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/instance"= "ingress-nginx"
      "app.kubernetes.io/version" = "1.1.1"
      "app.kubernetes.io/managed-by" = "Helm"
    }
    name = "ingress-nginx"
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps", "endpoints", "nodes", "pods", "secrets", "namespaces"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["get"]
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "patch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses/status"]
    verbs      = ["update"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingressclasses"]
    verbs      = ["get", "list", "watch"]
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_service_account.controller-serviceaccount,
  #   kubernetes_config_map.controller-configmap
  # ]
}

# Source: ingress-nginx/templates/clusterrolebinding.yaml
resource "kubernetes_role_binding" "clusterrolebinding" {
  metadata {
    labels = {
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
    }
    name = "ingress-nginx"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "ingress-nginx"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "ingress-nginx"
    namespace = "ingress-nginx"
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_cluster_role.clusterrole
  #   ]
}

# Source: ingress-nginx/templates/controller-role.yaml
resource "kubernetes_role" "controller-role" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
    }
    name      = "ingress-nginx"
    namespace = "ingress-nginx"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["get"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps", "pods", "secrets", "endpoints"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses/status"]
    verbs      = ["update"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingressclasses"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups      = [""]
    resources       = ["configmaps"]
    resource_names  = ["ingress-controller-leader"]
    verbs           = ["get", "update"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["create"]
  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "patch"]
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_role_binding.clusterrolebinding
  # ]
}

# Source: ingress-nginx/templates/controller-rolebinding.yaml
resource "kubernetes_role_binding" "controller-rolebinding" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
    }
    name      = "ingress-nginx"
    namespace = "ingress-nginx"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "ingress-nginx"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "ingress-nginx"
    namespace = "ingress-nginx"
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_role.controller-role
  #  ]
}

# Source: ingress-nginx/templates/controller-service-webhook.yaml
resource "kubernetes_service" "controller-service-webhook" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
    }
    name      = "ingress-nginx-controller-admission"
    namespace = "ingress-nginx"
  }

  spec {
    type = "ClusterIP"

    port {
      name          = "https-webhook"
      port          = 443
      target_port   = "webhook"
      protocol      = "TCP"
      app_protocol  = "webhook"
    }

    selector = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
    }
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_role_binding.controller-rolebinding
  # ]
}

# Source: ingress-nginx/templates/controller-service.yaml
resource "kubernetes_service" "controller-service" {
  metadata {
    annotations = {}
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
    }
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }

  spec {
    type                    = "LoadBalancer"
    external_traffic_policy = "Local"
    ip_family_policy        = "SingleStack"
    ip_families             = ["IPv4"]

    port {
      name         = "http"
      port         = 80
      protocol     = "TCP"
      target_port  = "http"
      app_protocol = "http"
    }

    port {
      name         = "https"
      port         = 443
      protocol     = "TCP"
      target_port  = "https"
      app_protocol = "https"
    }

    selector = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
    }
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_service.controller-service-webhook
  # ]
}

# Source: ingress-nginx/templates/controller-deployment.yaml
resource "kubernetes_deployment" "controller-deployment" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
    }
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }

  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance"  = "ingress-nginx"
        "app.kubernetes.io/name"      = "ingress-nginx"
      }
    }
    revision_history_limit = 10
    min_ready_seconds      = 0

    template {
      metadata {
        labels = {
          "app.kubernetes.io/component" = "controller"
          "app.kubernetes.io/instance"  = "ingress-nginx"
          "app.kubernetes.io/name"      = "ingress-nginx"
        }
      }
      spec {
        dns_policy = "ClusterFirst"

        container {
          name            = "controller"
          image           = "k8s.gcr.io/ingress-nginx/controller:v1.1.1@sha256:0bc88eb15f9e7f84e8e56c14fa5735aaa488b840983f87bd79b1054190e660de"
          image_pull_policy = "IfNotPresent"

          lifecycle {
            pre_stop {
              exec {
                command = ["/wait-shutdown"]
              }
            }
          }

          args = [
            "/nginx-ingress-controller",
            "--publish-service=$(POD_NAMESPACE)/ingress-nginx-controller",
            "--election-id=ingress-controller-leader",
            "--controller-class=k8s.io/ingress-nginx",
            "--configmap=$(POD_NAMESPACE)/ingress-nginx-controller",
            "--validating-webhook=:8443",
            "--validating-webhook-certificate=/usr/local/certificates/cert",
            "--validating-webhook-key=/usr/local/certificates/key"
          ]

          security_context {
            capabilities {
              drop = ["ALL"]
              add  = ["NET_BIND_SERVICE"]
            }
            run_as_user                = 101
            allow_privilege_escalation = true
          }

          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }

          env {
            name  = "LD_PRELOAD"
            value = "/usr/local/lib/libmimalloc.so"
          }

          liveness_probe {
            http_get {
              path   = "/healthz"
              port   = 10254
              scheme = "HTTP"
            }
            initial_delay_seconds = 10
            period_seconds        = 10
            failure_threshold     = 5
            success_threshold     = 1
            timeout_seconds       = 1
          }

          readiness_probe {
            http_get {
              path   = "/healthz"
              port   = 10254
              scheme = "HTTP"
            }
            initial_delay_seconds = 10
            period_seconds        = 10
            failure_threshold     = 3
            success_threshold     = 1
            timeout_seconds       = 1
          }

          port {
            name        = "http"
            container_port = 80
            protocol    = "TCP"
          }

          port {
            name        = "https"
            container_port = 443
            protocol    = "TCP"
          }

          port {
            name        = "webhook"
            container_port = 8443
            protocol    = "TCP"
          }

          volume_mount {
            name       = "webhook-cert"
            mount_path = "/usr/local/certificates/"
            read_only  = true
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "90Mi"
            }
          }
        }

        node_selector = {
          "kubernetes.io/os" = "linux"
        }

        service_account_name = "ingress-nginx"
        termination_grace_period_seconds = 300

        volume {
          name = "webhook-cert"
          secret {
            secret_name = "ingress-nginx-admission"
          }
        }
      }
    }
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_service.controller-service
  # ]
}

# Source: ingress-nginx/templates/controller-ingressclass.yaml
# We don't support namespaced ingressClass yet
# So a ClusterRole and a ClusterRoleBinding is required
resource "kubernetes_ingress_class" "controller-ingressclass" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
    }
    name = "nginx"
    # namespace = "ingress-nginx"
  }
  
  spec {
    controller = "k8s.io/ingress-nginx"
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_deployment.controller-deployment
  # ]
}

# Source: ingress-nginx/templates/admission-webhooks/validating-webhook.yaml
# before changing this value, check the required kubernetes version
# https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#prerequisites
resource "kubernetes_validating_webhook_configuration" "validating-webhook" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/managed-by"= "Helm"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.1.1"
      "helm.sh/chart"               = "ingress-nginx-4.0.15"
    }
    name = "ingress-nginx-admission"
  }

  webhook {
    name            = "validate.nginx.ingress.kubernetes.io"
    match_policy    = "Equivalent"

    rule {
      api_groups     = ["networking.k8s.io"]
      api_versions   = ["v1"]
      operations     = ["CREATE", "UPDATE"]
      resources      = ["ingresses"]
    }

    failure_policy              = "Fail"
    side_effects                = "None"
    admission_review_versions   = ["v1"]

    client_config {
      service {
        name      = "ingress-nginx-controller-admission"
        namespace = "ingress-nginx"
        path      = "/networking/v1/ingresses"
      }
    }
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_ingress_class.controller-ingressclass
  # ]
}

# Source: ingress-nginx/templates/admission-webhooks/job-patch/serviceaccount.yaml
resource "kubernetes_service_account" "serviceaccount" {
  metadata {
    name        = "ingress-nginx-admission"
    namespace   = "ingress-nginx"
    annotations = {
      "helm.sh/hook"              = "pre-install,pre-upgrade,post-install,post-upgrade"
      "helm.sh/hook-delete-policy"= "before-hook-creation,hook-succeeded"
    }
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"   = "ingress-nginx"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "ingress-nginx"
      "app.kubernetes.io/version"    = "1.1.1"
      "helm.sh/chart"                = "ingress-nginx-4.0.15"
    }
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_validating_webhook_configuration.validating-webhook
  # ]
}

# Source: ingress-nginx/templates/admission-webhooks/job-patch/clusterrole.yaml
resource "kubernetes_cluster_role" "webhooks_clusterrole" {
  metadata {
    name = "ingress-nginx-admission"
    annotations = {
      "helm.sh/hook"              = "pre-install,pre-upgrade,post-install,post-upgrade"
      "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
    }
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"   = "ingress-nginx"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "ingress-nginx"
      "app.kubernetes.io/version"    = "1.1.1"
      "helm.sh/chart"                = "ingress-nginx-4.0.15"
    }
  }

  rule {
    api_groups = ["admissionregistration.k8s.io"]
    resources  = ["validatingwebhookconfigurations"]
    verbs      = ["get", "update"]
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_service_account.serviceaccount
  # ]
}

# Source: ingress-nginx/templates/admission-webhooks/job-patch/clusterrolebinding.yaml
resource "kubernetes_cluster_role_binding" "webhooks_clusterrolebinding" {
  metadata {
    name = "ingress-nginx-admission"
    annotations = {
      "helm.sh/hook"              = "pre-install,pre-upgrade,post-install,post-upgrade"
      "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
    }
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"   = "ingress-nginx"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "ingress-nginx"
      "app.kubernetes.io/version"    = "1.1.1"
      "helm.sh/chart"                = "ingress-nginx-4.0.15"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "ingress-nginx-admission"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "ingress-nginx-admission"
    namespace = "ingress-nginx"
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_cluster_role.webhooks_clusterrole
  # ]
}

# Source: ingress-nginx/templates/admission-webhooks/job-patch/role.yaml
resource "kubernetes_role" "webhooks_role" {
  metadata {
    name        = "ingress-nginx-admission"
    namespace   = "ingress-nginx"
    annotations = {
      "helm.sh/hook"              = "pre-install,pre-upgrade,post-install,post-upgrade"
      "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
    }
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"   = "ingress-nginx"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "ingress-nginx"
      "app.kubernetes.io/version"    = "1.1.1"
      "helm.sh/chart"                = "ingress-nginx-4.0.15"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "create"]
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_cluster_role_binding.webhooks_clusterrolebinding
  # ]
}

# Source: ingress-nginx/templates/admission-webhooks/job-patch/rolebinding.yaml
resource "kubernetes_role_binding" "webhooks_rolebinding" {
  metadata {
    name        = "ingress-nginx-admission"
    namespace   = "ingress-nginx"
    annotations = {
      "helm.sh/hook"              = "pre-install,pre-upgrade,post-install,post-upgrade"
      "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
    }
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"   = "ingress-nginx"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "ingress-nginx"
      "app.kubernetes.io/version"    = "1.1.1"
      "helm.sh/chart"                = "ingress-nginx-4.0.15"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "ingress-nginx-admission"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "ingress-nginx-admission"
    namespace = "ingress-nginx"
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_role.webhooks_role
  # ]
}

# Source: ingress-nginx/templates/admission-webhooks/job-patch/job-createSecret.yaml
resource "kubernetes_job" "job-createSecret" {
  metadata {
    name = "ingress-nginx-admission-create"
    namespace = "ingress-nginx"
    annotations = {
      "helm.sh/hook"              = "pre-install,pre-upgrade"
      "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
    }
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"   = "ingress-nginx"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "ingress-nginx"
      "app.kubernetes.io/version"    = "1.1.1"
      "helm.sh/chart"                = "ingress-nginx-4.0.15"
    }
  }

  spec {
    template {
      metadata {
        name = "ingress-nginx-admission-create"
        labels = {
          "app.kubernetes.io/component" = "admission-webhook"
          "app.kubernetes.io/instance"   = "ingress-nginx"
          "app.kubernetes.io/managed-by" = "Helm"
          "app.kubernetes.io/name"       = "ingress-nginx"
          "app.kubernetes.io/version"    = "1.1.1"
          "helm.sh/chart"                = "ingress-nginx-4.0.15"
        }
      }
      spec {
        container {
          name  = "create"
          image = "k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1@sha256:64d8c73dca984af206adf9d6d7e46aa550362b1d7a01f3a0a91b20cc67868660"
          image_pull_policy = "IfNotPresent"
          args = [
            "create",
            "--host=ingress-nginx-controller-admission,ingress-nginx-controller-admission.$(POD_NAMESPACE).svc",
            "--namespace=$(POD_NAMESPACE)",
            "--secret-name=ingress-nginx-admission"
          ]
          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }
          security_context {
            run_as_non_root        = true
            run_as_user            = 2000
            allow_privilege_escalation = false
          }
        }
        restart_policy = "OnFailure"
        service_account_name = "ingress-nginx-admission"
        node_selector = {
          "kubernetes.io/os" = "linux"
        }
      }
    }
  }

  # depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_role_binding.webhooks_rolebinding
  # ]
}

# Source: ingress-nginx/templates/admission-webhooks/job-patch/job-patchWebhook.yaml
resource "kubernetes_job" "job-patchWebhook" {
  metadata {
    name = "ingress-nginx-admission-patch"
    namespace = "ingress-nginx"
    annotations = {
      "helm.sh/hook"              = "post-install,post-upgrade"
      "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
    }
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"   = "ingress-nginx"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "ingress-nginx"
      "app.kubernetes.io/version"    = "1.1.1"
      "helm.sh/chart"                = "ingress-nginx-4.0.15"
    }
  }

  spec {
    template {
      metadata {
        name = "ingress-nginx-admission-patch"
        labels = {
          "app.kubernetes.io/component" = "admission-webhook"
          "app.kubernetes.io/instance"   = "ingress-nginx"
          "app.kubernetes.io/managed-by" = "Helm"
          "app.kubernetes.io/name"       = "ingress-nginx"
          "app.kubernetes.io/version"    = "1.1.1"
          "helm.sh/chart"                = "ingress-nginx-4.0.15"
        }
      }
      spec {
        container {
          name  = "patch"
          image = "k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1@sha256:64d8c73dca984af206adf9d6d7e46aa550362b1d7a01f3a0a91b20cc67868660"
          image_pull_policy = "IfNotPresent"
          args = [
            "patch",
            "--webhook-name=ingress-nginx-admission",
            "--namespace=$${POD_NAMESPACE}",
            "--patch-mutating=false",
            "--secret-name=ingress-nginx-admission",
            "--patch-failure-policy=Fail"
          ]
          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }
          security_context {
            allow_privilege_escalation = false
            run_as_non_root           = true
            run_as_user               = 2000
          }
        }
        restart_policy = "OnFailure"
        service_account_name = "ingress-nginx-admission"
        node_selector = {
          "kubernetes.io/os" = "linux"
        }
      }
    }
  }

  #   depends_on = [
  #   kubernetes_namespace.ingress-nginx,
  #   kubernetes_job.job-createSecret
  # ]
}