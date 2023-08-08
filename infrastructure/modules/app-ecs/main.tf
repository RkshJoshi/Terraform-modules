data "aws_caller_identity" "current"{}

resource "aws_security_group" "ckanSvcSg"{
  name = "ckan-service-${var.envName}-sg"
  description = "security group for ckan service in ${var.envName}"
  ingress {
    description = "Allow access to "
  }
  egress {
    protocol = "-1"
    to_port = 1
    from_port = 1
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow outboud access from ckan Service"
  }



}