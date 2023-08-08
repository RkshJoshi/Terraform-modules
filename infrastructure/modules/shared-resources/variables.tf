# Common variables

variable "envName" {
  type = string
  default = ""
  description = "Provide the environment name"
}

variable "vpcId"{
  type = string
  description = "Provide the VPCID to deploy"
}

variable "publicSubnets"{
  type = list(string)
  description = "List the public subnets"
  }

variable "privateSubnets"{
  type = list(string)
  description = "List the private subnets"
}

variable "restrictedSubnets"{
  type = list(string)
  description = "list of the restricted subnets to deploy database"
}

variable "repoName" {
  type = set(string)
  default = ["ckan","nginx","datapusher","solr"]
  description = "Specify the list of repository"
}

# Database variables
variable "autoMajorVersionUpgrade" {
  type = bool
  default = false
  description = "Enable auto upgrade of Major Version"
}

variable "allocatedStorage" {
  type = number
  description = "Storage to allocate to RDS database"
}

variable "autoMinorVersionUpgrade" {
  type = bool
  description = "Enable Auto minor version upgrade in DB"
}

variable "backupRetentionPeriod" {
  type = number
  description = "Backup retention in days"
  validation {
    condition = var.backupRetentionPeriod <= 35
    error_message = "The retention period must be less than 35 days"
  }
}

variable "backupWindow" {
  type = string
  description = "Specify the backup window during which automated backups are created"
}

variable "dbDeletionProtection"{
  type = bool
  description = "Enable or disable deletion protection"
}

variable "dbEngine"{
  type = string
  default = "postgres"
  description = "Specify the DB engine Name"
}

variable "dbEngineVersion"{
  type = string
  default= "14.5"
  description = "Database engine version"
}

# Elasticache Redis variables

variable "redisAtRestEncryption"{
  type = bool
  description = "Enable encryption at rest"
}

variable "redisEncryptionInTransit"{
  type = bool
  description = "Enable encryption in transit"
}

variable "autoMinorVersion"{
  type = bool
  description = "Enable Auto minor version upgrade"
}

variable "enableAutomaticFailover"{
  type= bool
  description = "Enable automatic failover"
}



