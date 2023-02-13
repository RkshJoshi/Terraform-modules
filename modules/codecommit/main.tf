
#Create New codecommit repo to store terraform code and config
resource "aws_codecommit_repository" "new_terraform_repo" {
  count           = var.need_new_repo ? 1 : 0
  repository_name = var.source_repo_name
  description     = "This repo will be used to store terraform code for demo application"
}

# Define Template Rule for pull request

resource "aws_codecommit_approval_rule_template" "repo_pr_approval_template" {
  count       = var.need_new_repo ? 1 : 0
  name        = "${var.source_repo_name}-pr-template-rule"
  description = "This rule will approve PR request for repo ${var.source_repo_name}"
  content     = <<EOF
  {
    "Version": "2018-11-08",
    "DestinationReferences": ["refs/heads/master"],
    "Statements" : [{
      "Type" : "Approvers",
      "NumberOfApprovalsNeeded": 1,
      "ApprovalPoolMembers": ["${var.approval_pool_membersARN}"]
    }]
  }
  EOF
}

# Attach template rules with repository

resource "aws_codecommit_approval_rule_template_association" "repo_approval_template_associate" {
  count                       = var.need_new_repo ? 1 : 0
  approval_rule_template_name = aws_codecommit_approval_rule_template.repo_pr_approval_template[0].name
  repository_name             = aws_codecommit_repository.new_terraform_repo[0].repository_name


}