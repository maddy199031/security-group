module "official_tags" {
  source = "git::ssh://source.syncron.team:29418/op/terraform/modules/official-tags//src?ref=master"
  tags   = var.tags
}
