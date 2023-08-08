module "sharedResources" {
  source                  = "../../modules/shared-resources"
  envName                 = "prod"
  vpcId                   = ""
  privateSubnets          = []
  publicSubnets           = []
  restrictedSubnets       = []
  repoName                = ["ckan", "nginx", "datapusher", "solr"]
  autoMajorVersionUpgrade = false
  autoMinorVersionUpgrade = false
  allocatedStorage        = 5
  backupRetentionPeriod   = 0
  backupWindow            = "09:00-10:00"
  dbDeletionProtection    = false
  dbEngine                = "14.5"
  redisAtRestEncryption = true
  redisEncryptionInTransit = true
  autoMinorVersion = true
  enableAutomaticFailover = true
}