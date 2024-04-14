variable "web_asg_name" {
  description = "Auto Scaling Group Name Values for Web"
  type        = string
  default     = ""
}

variable "web_min_size" {
  description = "Minimum Number for Web by Auto Scaling Group"
  type        = number
  default     = 1
}

variable "web_desired_capacity" {
  description = "Desired number for Web by Auto Scaling Group"
  type        = number
  default     = 2
}

variable "web_max_size" {
  description = "Maximum Mumber for Web by Auto Scaling Group"
  type        = number
  default     = 4
}

variable "ext_tg_arns" {
  description = "ARN of External Target Group"
  type        = list(string)
  default     = []
}

variable "web_subnet_id" {
  description = "Subnet IDs for Web Service"
  type        = list(string)
  default     = []
}

variable "was_asg_name" {
  description = "Auto Scaling Group Name Values for Web"
  type        = string
  default     = ""
}

variable "was_min_size" {
  description = "Minimum Number for WAS by Auto Scaling Group"
  type        = number
  default     = 1
}

variable "was_desired_capacity" {
  description = "Desired number for WAS by Auto Scaling Group"
  type        = number
  default     = 2
}

variable "was_max_size" {
  description = "Maximum Mumber for WAS by Auto Scaling Group"
  type        = number
  default     = 4
}

variable "int_tg_arns" {
  description = "ARN of Internal Target Group"
  type        = list(string)
  default     = []
}

variable "was_subnet_id" {
  description = "Subnet IDs for WAS Service"
  type        = list(string)
  default     = []
}