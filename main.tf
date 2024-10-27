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
  public_key = "ssh-rsa MIIEpAIBAAKCAQEAwpItiC2ZyA05B8DXFEUMX0h3M0Zo1sKOKWW2AqgblgqgLhak
3SfFTRFDZKFxLWGhxu0tEg3J+FZbSILiTeyc/cVHX43hWb9oFh29ClOteAIDl88+
4WBafuR7QcQj6yMB1mQaZvpMDZrPVkEt4vT617o5OYQBlq3spUXBtjrS00JUriLy
pV9teJEkoic/XzK7mGe6MCZ/ahWr3ma8Ot3akM6/R/eTTYlClmMm+PPntTAX3H+e
/oKXfC2kGrYIzaJrVtk+Ijx6fJgxFkX0vDsqmFUYmf1Vg2s84BrP1qEyoEXuk9AV
SghfofSeq0k/UvXuf7q8nLiqtBQ/n8LNReLxjwIDAQABAoIBAHvNTzNq8IKeBz+r
sC6xkKHAFjiGAIdF2/bzRNCD7qmVsT4iIlylxaC3703Ee6MIkEtm9lqac3yUVhjZ
Tu2ONIY0VKm0OUNFyxDnczVy8Nl/TpH1yGjXSj2bW+IIz2H6MF0d7L7BXEr7yhlz
96KFhmZlk6vJFsmtePngXNV6sFLCseJL2vhzW53AWS6v8dxrlDM/nWkTdDq/B4C0
y5RQQVrohbAw8DisrxX4QBSKWAQvQQND/pt5+DLwvZff4qfXNzJeqdPKHMyUnQRI
B1fRks5n2x/kMB9Ikp2bAMb+vt4eN9QZ/snF+tXPRIjKXebzE9Tl1f0SqFw058iW
MKwI6aECgYEA35t/56zv/mBagulYQdyyvlnq4np48++a4B3ElQUCRK0wUMIfh7Ii
SuxW4z5WXhVz7j8uf8LDWnIbcRhWLDukafDQcMsZqV7WsQQ+sx2R0Gw+xV9tY7tC
nBpYXOfGuOblYql0r8DPPWxv1nIWwvg/PdIekOdZVIQefgSIbjFwS3UCgYEA3sHc
QFqle2pBo7eGUxxpDL8Q3UFTGIRB9W0djA54aqzSdoYZEWrAIg6JXdohgAHEubIc
JHeWWqYSZHZFePis5tfqU5MtOaLXtsbIAF/dhLQ2F3XL4u2ze4gc+T530jhNYXF6
vML5mkQwwqxfjgCV9sllyQXwFmvk72tbBgynXHMCgYB0Qgr8T2PwI/SrP9tNUwv0
ABgpbHfajGc/wvpkaFhHkKwgMO3nxWwi/EIooE6TWCAQbPUmJAMh0VYHNRoIoXHY
SwZ0voQ3FUIWgxh+VA9uB/mS8QyU39XAB8qNc0xU8metJmGux1Z4nxp+qo6/DAcF
g2u09zPwx0h7SKwObtHtyQKBgQC3fTjQSdrGLmCjWylqjJx7w2dA2e5443jxkVAl
bkYCmRlESHGdxzE83HyKsoOlzc8ep3hHEbroMKQ13LadTzodbP24miNGtry58kQN
CuqNxWRJLt8jrmmJ+DTlmm9Y2sfi3Hcdxf2U9Va1BQgxEIp3Hq6ZSCrcTUPnc6cm
9IVnwQKBgQCPTZuoyIbjA1KOl2RLCBKCx0hAhyIf9VMlK78DM/T6d5aP6KS1m82O
k4UiCh/UlkQdVT87KzirvQg+7L68skK6Y19lpCylU47gONdpma1rd1OC+eFyBsMR
ZQYm2OR4KxBgvy+J0b1YTycMZiJCc2IitpJluydIseUEdMWinBou+Q== oliverflintrose@gmail.com"
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


