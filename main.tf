terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_instance" "todo" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = ["webport-allow"]

  credit_specification {
    cpu_credits = "unlimited"
  }

  provisioner "remote-exec" {
         inline = [
                       "sudo yum install httpd -y",
                       "sudo yum install git -y",
                       "sudo systemctl enable httpd",
                       "sudo git clone https://github.com/chirap123/todo_application_code.git,
                       "sudo systemctl start httpd"
                  ]
  }
}
