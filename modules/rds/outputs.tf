output "db_addresses" {
    value = [aws_db_instance.wp_db.address]
}