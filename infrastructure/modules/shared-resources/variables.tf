variable "envName" {
  type = string
  default = ""
  description = "Provide the environment name"
}

variable "repoName" {
  type = set(string)
  default = ["ckan","nginx","datapusher","solr"]
  description = "Specify the list of repository"
}