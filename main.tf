resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.vpc_id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = var.auto_accept
  tags        = merge(var.tags, { Name = var.name })

  requester {
    allow_remote_vpc_dns_resolution = var.vpc_allow_dns
  }

  accepter {
    allow_remote_vpc_dns_resolution = var.peer_vpc_allow_dns
  }
}

resource "aws_route" "vpc" {
  for_each                  = {for i, v in var.vpc_route_table_ids : i => v}
  route_table_id            = each.value
  destination_cidr_block    = var.peer_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "peer_vpc" {
  for_each                  = {for i, v in var.peer_vpc_route_table_ids : i => v}
  route_table_id            = each.value
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
