variable "spark_enabled" { 
  type    = bool
  default = false
}
variable "spark_release_config" {
  type    = map
  default = {}
}
variable "kafka_enabled" { 
  type    = bool
  default = false
}
variable "kafka_release_config" {
  type    = map
  default = {}
}
variable "kafdrop_enabled" { 
  type    = bool
  default = false
}
variable "kafdrop_release_config" {
  type    = map
  default = {
    tagVersion    = "3.27.0"
    kafkaServer   = "kafka.kafka.svc.cluster.local:9092"
  }
}
