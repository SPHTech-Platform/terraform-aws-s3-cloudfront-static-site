provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
    }
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

  default_tags {
    tags = {
    }
  }
}
