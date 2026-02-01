#dynamodb
resource "aws_dynamodb_table" "portfolio-table" {
  name         = "portfolio-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "page_id"

  attribute {
    name = "page_id"
    type = "S"
  }
}