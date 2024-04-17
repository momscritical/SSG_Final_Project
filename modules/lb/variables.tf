variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = ""
}

variable "public_subnet_id" {
  description = "Subnet ID for External LaodBalancer"
  type        = list(string)
  default     = []
}

variable "web_subnet_id" {
  description = "Subnet ID for Internal LaodBalancer"
  type        = list(string)
  default     = []
}

variable "ext_lb_name" {
  description = "External Laod Balancer Name Value"
  type = string
  default = ""
}

variable "ext_tg_name" {
  description = "External LaodBalancer Name Value"
  type = string
  default = ""
}

variable "int_lb_name" {
  description = "Internal Laod Balancer Name Value"
  type = string
  default = ""
}

variable "int_tg_name" {
  description = "External LaodBalancer Name Value"
  type = string
  default = ""
}

variable "ext_lb_type" {
  description = "External LaodBalancer Type Value"
  type = string
  default = "application"
}

variable "int_lb_type" {
  description = "Internal LaodBalancer Type Value"
  type = string
  default = "application"
}

variable "ext_default_action_type" {
  description = "Default Action Type Value for External LaodBalancer listener"
  type = string
  default = "forward"
}

variable "int_default_action_type" {
  description = "Default Action Type Value for Internal LaodBalancer listener"
  type = string
  default = "forward"
}

variable "ext_sg_id" {
  description = "External Security Group ID Values for External LaodBalancer"
  type        = list(string)
  default     = []
}

variable "int_sg_id" {
  description = "External Security Group ID Values for External LaodBalancer"
  type        = list(string)
  default     = []
}

variable "ext_listener_port" {
  description = "Port Values for External LaodBalancer Listener"
  type = string
  default = ""
}

variable "ext_listener_protocol" {
  description = "Protocol Values for External LaodBalancer Listener"
  type = string
  default = ""
}

variable "ext_tg_port" {
  description = "Port Values for External LaodBalancer Listener"
  type = string
  default = ""
}

variable "ext_tg_protocol" {
  description = "Protocol Values for External LaodBalancer Listener"
  type = string
  default = ""
}

variable "ext_listener_tg_type" {
  description = "Target Type for External LaodBalancer Listener"
  type = string
  default = "instance"
}

variable "ext_hc_matcher" {
  type = string
  default = "200,301,302"
}

variable "ext_hc_path" {
  type = string
  default = "/"
}

variable "ext_hc_healthy_threshold" {
  type = number
  default = 2
}

variable "ext_hc_unhealthy_threshold" {
  type = number
  default = 2
}

# 5초의 타임아웃
variable "ext_hc_timeout" {
  type = number
  default = 5
}

# 30초 간격으로 헬스 체크
variable "ext_hc_interval" {
  type = number
  default = 30
}

variable "int_listener_tg_type" {
  description = "Target Type for Internal LaodBalancer Listener"
  type = string
  default = "instance"
}

variable "int_hc_matcher" {
  type = string
  default = "200,301,302"
}

variable "int_hc_path" {
  type = string
  default = "/"
}

variable "int_hc_healthy_threshold" {
  type = number
  default = 2
}

variable "int_hc_unhealthy_threshold" {
  type = number
  default = 2
}

# 5초의 타임아웃
variable "int_hc_timeout" {
  type = number
  default = 5
}

# 30초 간격으로 헬스 체크
variable "int_hc_interval" {
  type = number
  default = 30
}

variable "int_listener_port" {
  description = "Port Values for External LaodBalancer Listener"
  type = string
  default = ""
}

variable "int_listener_protocol" {
  description = "Protocol Values for External LaodBalancer Listener"
  type = string
  default = ""
}

variable "int_tg_port" {
  description = "Port Values for External LaodBalancer Listener"
  type = string
  default = ""
}

variable "int_tg_protocol" {
  description = "Protocol Values for External LaodBalancer Listener"
  type = string
  default = ""
}