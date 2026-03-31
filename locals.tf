locals {
  ingress_rules1 = [
    {
      port        = 22
      description = "Ingress for SSH"
    },
    {
      port        = 80
      description = "Ingress for HTTP"
    },
    {
      port        = 443
      description = "Ingress for HTTPS"
    },

    {
      port        = 53
      description = "Ingress for DNS"
    },
  ]
  ingress_rules2 = [
    {
      port        = 8080
      description = "Ingress for Apache/TomCat, Jenkins"
    },
    {
      port        = 22
      description = "Ingress for ssh"
    },
    {
      port        = 9090
      description = "Ingress for prometheus"
    },
    {
      port        = 3000
      description = "Ingress for Grafana"
    },
  ]
  ingress_rules3 = [
    {
      port        = 5432
      description = "Ingress for Postgresql"
    },
    {
      port        = 22
      description = "Ingress for SSH"
    },
    {
      port        = 1433
      description = "Ingress for MSSql"
    },
    {
      port        = 3306
      description = "Ingress for MYSQL"
    },
  ]
}