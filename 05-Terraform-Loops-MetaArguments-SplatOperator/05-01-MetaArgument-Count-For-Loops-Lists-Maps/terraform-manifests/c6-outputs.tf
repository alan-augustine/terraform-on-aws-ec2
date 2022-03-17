# Terraform Output Values
/* Concepts Covered
1. For Loop with List
2. For Loop with Map
3. For Loop with Map Advanced
4. Legacy Splat Operator (latest) - Returns List
5. Latest Generalized Splat Operator - Returns the List
*/

# Output - For Loop with List
output "for_output_list" {
  description = "For loop with list"
  # similar to list comprehension
  value = [for instance in aws_instance.myec2vm: instance.public_dns ]
  # or value = [for a in aws_instance.myec2vm: a.public_dns ]
}

# Output - For loop with map
output "for_output_map1" {
  description = "For loop with map"
  # similar to dictionary comprehension
  # key is instance.id & value is instance.public_dns in the Map
  value = { for instance in aws_instance.myec2vm: instance.id => instance.public_dns }
  
}

# Output - For loop with map - Advanced
output "for_output_map2" {
  description = "For loop with map - Advanced"
  # similar to dictionary comprehension
  # key is c & value is instance.public_dns in the Map
  # c is like index
  value = { for c, instance in aws_instance.myec2vm: c => instance.public_dns }
  
}

# Output Legacy Splat Operator (Legacy) - Returns the List
/*
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Operator"
  value = aws_instance.myec2vm.*.public_dns
}
*/

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized latest Splat Operator"
  value = aws_instance.myec2vm[*].public_dns
}