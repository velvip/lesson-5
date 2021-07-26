resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey" # Create "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "pg_sql" {
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.kp.key_name
  instance_type          = "t2.micro"
  private_ip             = "192.168.0.199" #Create ip address in private network
  subnet_id              = aws_subnet.subnet_public.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  tags = {
    Name = "pg_sql"
  }
  provisioner "remote-exec" {
    inline = [ #install pgSQL
      "sudo apt -y upgrade",
      "sudo apt -y install postgresql postgresql-contrib ",
    ]
  }
  provisioner "file" { #copy file to VM
    source      = "./sql_init_file/init.sql"
    destination = "./init.sql"
  }
  provisioner "remote-exec" {
    inline = [ #start file intro psql and backup base to *.dump
      "sudo -u postgres psql -f ./init.sql",
      "sudo -u postgres pg_dump test_database > backup_file.dump",
    ]
  }
  connection { #Connect to VM
    host        = aws_instance.pg_sql.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.pk.private_key_pem
  }
}