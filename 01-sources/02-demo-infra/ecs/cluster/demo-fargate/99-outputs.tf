output "cluster_arn" {
  description = "Arn of the ecs cluster"
  value       = module.ecs_cluster.arn
}
