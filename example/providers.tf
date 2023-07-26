provider "aws" {
  region = "ap-southeast-1"

  skip_metadata_api_check = true

  allowed_account_ids = ["1234567890"]

  default_tags {
    tags = {
    }
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

  allowed_account_ids = [
    "1234567890",
  ]

  default_tags {
    tags = {
    }
  }
}
