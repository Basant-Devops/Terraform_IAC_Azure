variable "resource_group_name" {
    type = list(string)
    default = ["rg"]
}
variable "location" {
    type = string
    default = "eastus2"
}