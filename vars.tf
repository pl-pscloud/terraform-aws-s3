variable "pscloud_env" {}
variable "pscloud_company" {}
variable "pscloud_purpouse" {}
variable "pscloud_acl" { default = "private" } 
variable "pscloud_versioning" { default = false}
variable "pscloud_lifecycle_enbaled" { default = false }

variable "pscloud_transition_days_ia" { default = 30 }
variable "pscloud_transition_days_glacier" { default = 60 }
variable "pscloud_transition_days_expiration" { default = 180 }

variable "pscloud_kms_key_arn" { default = ""}

variable "pscloud_block_access" { default = true }