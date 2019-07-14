output "public-subnet-ids" {
  description = "List of public subnet ids"
  value       = aws_subnet.public.*.id
}

output "private-subnet-ids" {
  description = "List of private subnet ids"
  value       = aws_subnet.private.*.id
}
