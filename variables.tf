#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-cloudwatch-alarms"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

#Module      : Synthetic canaries
#Description : Terraform Synthetic canaries module variables.

variable "s3_artifact_bucket" {
  type        = string
  description = "Location in Amazon S3 where Synthetics stores artifacts from the test runs of this canary"
}

variable "schedule_expression" {
  type        = string
  description = "Expression defining how often the canary runs"
}

variable "endpoints" {
  type = map(object({
    url = string
  }))
}

variable "alarm_email" {
  type        = string
  description = "Email address to send alarms to"
}

variable "alarm_evaluation_periods" {
  type        = number
  default     = 1
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "alarm_period" {
  type        = number
  default     = 60
  description = "The period in seconds over which the specified statistic is applied"
}
variable "subnet_ids" {
  default     = null
  type        = list(string)
  description = "IDs of the subnets where this canary is to run"
}

variable "security_group_ids" {
  default     = null
  type        = list(string)
  description = "IDs of the security groups for this canary"
}

variable "canary_iam_role_name" {
  type        = string
  description = "Name of the IAM role for the canary"
}

variable "canary_iam_policy_name" {
  type        = string
  description = "Name of the IAM policy for the canary"
}

variable "canary_sns_topic_name" {
  type        = string
  description = "Name of the SNS topic for the canary"
}

variable "runtime_version" {
  type        = string
  default     = "syn-nodejs-puppeteer-7.0"
  description = "The runtime version to use for the canary"
}
