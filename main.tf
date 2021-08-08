provider "azurerm"{
    version = "2.5.0"
    features {}
}

terraform{
    backend "azurerm" {
        resource_group_name     = "terraform_gp_blobstore"
        storage_account_name    = "tfstorageaccount858"
        container_name          = "tfstate"
        key                     = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "terraform_test" {
    name = "tfmainrg"
    location = "UK South"
}

resource "azurerm_container_group" "tfcg_test"{
    name                = "colorapi"
    location            = azurerm_resource_group.terraform_test.location
    resource_group_name = azurerm_resource_group.terraform_test.name
    ip_address_type     = "public"
    dns_name_label      = "yomexcolourapi"
    os_type             = "linux"

    container{
        name            = "colourapi"
        image           = "yomex4life/azureapi"
        cpu             = "1"
        memory          = "1"

        ports{
            port        = 80
            protocol    = "TCP"
        }

    }
}
