resource "local_file" "hosts_cfg" {
  content = templatefile("hosts.tpl",
    {
      server1 = aws_instance.demoinstance.0.public_ip
      server2 = aws_instance.demoinstance.1.public_ip
      server3 = aws_instance.demoinstance.2.public_ip
      server4 = aws_instance.demoinstance.3.public_ip
      server5 = aws_instance.demoinstance.4.public_ip
      server6 = aws_instance.demoinstance.5.public_ip
    }
  )
  filename = "/home/ansibleadmin/infra/invfile"
}
