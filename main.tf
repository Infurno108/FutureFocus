terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

resource "aws_key_pair" "deployer" {
  key_name   = "FF-key"
  public_key = "ssh-rsa MIIEpAIBAAKCAQEAwpItiC2ZyA05B8DXFEUMX0h3M0Zo1sKOKWW2AqgblgqgLhak3SfFTRFDZKFxLWGhxu0tEg3J+FZbSILiTeyc/cVHX43hWb9oFh29ClOteAIDl88+4WBafuR7QcQj6yMB1mQaZvpMDZrPVkEt4vT617o5OYQBlq3spUXBtjrS00JUriLypV9teJEkoic/XzK7mGe6MCZ/ahWr3ma8Ot3akM6/R/eTTYlClmMm+PPntTAX3H+e/oKXfC2kGrYIzaJrVtk+Ijx6fJgxFkX0vDsqmFUYmf1Vg2s84BrP1qEyoEXuk9AVSghfofSeq0k/UvXuf7q8nLiqtBQ/n8LNReLxjwIDAQABAoIBAHvNTzNq8IKeBz+rsC6xkKHAFjiGAIdF2/bzRNCD7qmVsT4iIlylxaC3703Ee6MIkEtm9lqac3yUVhjZTu2ONIY0VKm0OUNFyxDnczVy8Nl/TpH1yGjXSj2bW+IIz2H6MF0d7L7BXEr7yhlz96KFhmZlk6vJFsmtePngXNV6sFLCseJL2vhzW53AWS6v8dxrlDM/nWkTdDq/B4C0y5RQQVrohbAw8DisrxX4QBSKWAQvQQND/pt5+DLwvZff4qfXNzJeqdPKHMyUnQRIB1fRks5n2x/kMB9Ikp2bAMb+vt4eN9QZ/snF+tXPRIjKXebzE9Tl1f0SqFw058iWMKwI6aECgYEA35t/56zv/mBagulYQdyyvlnq4np48++a4B3ElQUCRK0wUMIfh7IiSuxW4z5WXhVz7j8uf8LDWnIbcRhWLDukafDQcMsZqV7WsQQ+sx2R0Gw+xV9tY7tCnBpYXOfGuOblYql0r8DPPWxv1nIWwvg/PdIekOdZVIQefgSIbjFwS3UCgYEA3sHcQFqle2pBo7eGUxxpDL8Q3UFTGIRB9W0djA54aqzSdoYZEWrAIg6JXdohgAHEubIcJHeWWqYSZHZFePis5tfqU5MtOaLXtsbIAF/dhLQ2F3XL4u2ze4gc+T530jhNYXF6vML5mkQwwqxfjgCV9sllyQXwFmvk72tbBgynXHMCgYB0Qgr8T2PwI/SrP9tNUwv0ABgpbHfajGc/wvpkaFhHkKwgMO3nxWwi/EIooE6TWCAQbPUmJAMh0VYHNRoIoXHYSwZ0voQ3FUIWgxh+VA9uB/mS8QyU39XAB8qNc0xU8metJmGux1Z4nxp+qo6/DAcFg2u09zPwx0h7SKwObtHtyQKBgQC3fTjQSdrGLmCjWylqjJx7w2dA2e5443jxkVAlbkYCmRlESHGdxzE83HyKsoOlzc8ep3hHEbroMKQ13LadTzodbP24miNGtry58kQNCuqNxWRJLt8jrmmJ+DTlmm9Y2sfi3Hcdxf2U9Va1BQgxEIp3Hq6ZSCrcTUPnc6cm9IVnwQKBgQCPTZuoyIbjA1KOl2RLCBKCx0hAhyIf9VMlK78DM/T6d5aP6KS1m82Ok4UiCh/UlkQdVT87KzirvQg+7L68skK6Y19lpCylU47gONdpma1rd1OC+eFyBsMRZQYm2OR4KxBgvy+J0b1YTycMZiJCc2IitpJluydIseUEdMWinBou+Q== oliverflintrose@gmail.com"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
    tags = {
    Name = "FutureFocus"
    
}
}


