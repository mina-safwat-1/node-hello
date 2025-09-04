terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.57.0" # or a newer version
    }

    helm = {
      source  = "hashicorp/helm"
      version = "= 2.7.1" # or a newer version
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.18.1" # or a newer version
    }
  }

}

provider "aws" {
  region = "us-east-1"
}




provider "kubernetes" {
  host                   = local.cluster_endpoint
  cluster_ca_certificate = base64decode(local.cluster_ca)
  token                  = local.cluster_token
}

provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = base64decode(local.cluster_ca)
    token                  = local.cluster_token
  }
}
