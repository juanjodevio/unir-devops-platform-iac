output "db_name"{
    value= aws_db_instance.main.name
}
output "username"{
    value= aws_db_instance.main.username
}
output "password"{
    value= aws_db_instance.main.password
}
output "address"{
    value= aws_db_instance.main.address
}
output "port"{
    value= aws_db_instance.main.port
}