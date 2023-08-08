output "kmsKeyARN" {
  description = "ARN of KMS Key"
  value       = module.sharedResources.kmsKeyArn
}

output "kmsKeyId" {
  description = "KeyId of the KMS Key"
  value = module.sharedResources.kmsKeyId
}

output "repoURIs"{
  description = "URIs of the repository"
  value = module.sharedResources.repoURIs
}

output "testURI"{
  value=module.sharedResources.myURIs
}