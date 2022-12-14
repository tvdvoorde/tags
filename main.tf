variable "oidc_request_token" {}
variable "oidc_request_url" {}
variable "githubsha" {}
variable "githubref" {}
variable "githubrepositoryurl" {}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "ea757669-674b-44c1-bf87-bd0fd0880294"
  client_id       = "f7e86211-cfae-496d-8e86-4508b92f77d2"
  tenant_id       = "e2a4b012-36ad-45f2-8c5c-169f06c2f970"
  use_oidc        = true
  oidc_request_token = var.oidc_request_token
  oidc_request_url   = var.oidc_request_url
}

resource "azurerm_resource_group" "taggroup1" {
  name     = "rg-taggroup1"
  location = "West Europe"
}

terraform {
  cloud {
    organization = "tedv1138"
    workspaces {
      name = "workspace1"
    }
  }
}

resource "random_id" "server" {
  byte_length = 8
}

module "vnet" {
  source              = "app.terraform.io/tedv1138/vnet/azurerm"
  version             = "1.0.5"
  name                = "vnet2"
  resource_group_name = azurerm_resource_group.taggroup1.name
  location            = azurerm_resource_group.taggroup1.location
  githubsha           = var.githubsha
  githubref           = var.githubref
  githubrepositoryurl = var.githubrepositoryurl
}
  
  
