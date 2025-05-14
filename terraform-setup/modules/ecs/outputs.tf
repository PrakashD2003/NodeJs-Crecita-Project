output "cluster_id" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.this.id
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.this.arn
}

output "service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.this.id
}

resource "local_file" "ecs_metedata" {
    content = jsonencode({
        cluster_id = aws_ecs_cluster.this.id
        task_definition_arn = aws_ecs_task_definition.this.arn
        service_id = aws_ecs_service.this.id
    })
    filename = var.ecs_output_filepath
}