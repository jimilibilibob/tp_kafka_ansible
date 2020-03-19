variable "subscription_id" {
    description = "Id de la souscription"
}

variable "location" {
    default = "westeurope"
    description = "Localisation des ressources"
}

variable "nombre_ressource" {
    description = "Nombre de ressource voulue"
}

variable "sig_gallery_name" {
    description = "Nom de la Shared Image Gallery"
}

variable "sig_gallery_resource_group" {
    description = "Groupe de ressource de la Shared Image Gallery"
}

variable "env" {
  description = "Variable d'envrionnement"
}
