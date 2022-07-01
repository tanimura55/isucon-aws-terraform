variable "standalone_ami_image_id" {
  type        = string
  description = "AMI ID"
}

variable "access_cidr_blocks" {
  type        = string
  default     = "0.0.0.0/0" # "0.0.0.0/0,255.255.255.255/32" のようにカンマ区切りで複数指定可
  description = "cidr for access"
}

variable "vpc_net_mask" {
  type        = string
  default     = "10.1.0.0"
  description = "VPC network subnet mask"
}

variable "ec2_members" {
  type = map
  default = { # デフォルトではベンチマーカー役も含んだ4台のEC2が同じAMIで構築される
    "0" = "worker-01"
    "1" = "worker-02"
    "2" = "worker-03"
    "3" = "benchmark-instance"
  }
  description = "EC2 instances for isucon practice"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "ec2_volume_size" {
  type        = number
  default     = 20
  description = "EC2 EBS volume size"
}
