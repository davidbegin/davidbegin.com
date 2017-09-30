provider "aws" {
  region = "${var.region}"
}

variable "packer_built_bastion_ami" {}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "bastion" {
  ami                         = "${var.packer_built_bastion_ami}"
  key_name                    = "${aws_key_pair.bastion_key.key_name}"
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.bastion-sg.name}"]
  associate_public_ip_address = true
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "your_key_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC48H/E6H6pV7esbFh/qls5QM1s0+itFVYXj2rRzBpnQVim/jBxuexI22Ac1GpdFV2xQp0eMoSAh9mBdZ+/W+OWcYiJ+zHChq1WxhGyCWmbzD9XjJWBMqtZdARBWS50NQXuChXcfvSt4xgKu0kZY3GsTwsvFopLQ/zYys+5R7hNPvbuiRFaAJrjalDZOvIXEzZfRCWagiqLa40YYXvHWhJ/62XHULOSPbKBVk3eLK0kVJ/m743pKo0biTViJpp06IqwZFluRaDMHaDiQuguX4Fu+paScdI89/zfTfL7Ps80+WEQEQdGture7nX4445Df3Kaz9VWt2zKN8PbBYxUh8V9uAkviED7qu5DlqI9Vlh+lTjeeWWmL5jlFz4zFpSTOPXjE3rdaSmVkhTqEqAVDpkpf4VtUtQU819HpTXQFWDu6tyFz6qG3UcG2w0TKG2YfYzZT16idfFTykqI1RgIv5gcW65jGkJ+KWOVYA2q/JS25X+XZeHBhOK2rmD82DnZ7nHjFKOMJf44zvCWICup1XienVGmXc+0GCk5A/kjjcJrbfFWuCbJz5IbiaNgDQ9nuAFQVAGqulpVASIo5Hk9h6HThoT7jsnLBZgGWsPlPg+e1zszMOREI6yX35ItAhhx+oui9n8rWxLlvkg0BvL4WA2a03xVRN6X+26sUMHVav+gdw== your_email@example.com"
}

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
