packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}

variable "version" {
  type    = string
}

variable "cloud_token" {
  type    = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

locals {
  date = formatdate("YYYYMMDD", timestamp())
}

source "vagrant" "devbox" { 
  source_path                       = "ubuntu/jammy64"
  provider                          = "virtualbox"
  add_force                         = true
  communicator                      = "ssh"
  template                          = "${path.root}/Vagrantfile_init"
  package_include                   = [
    "${path.root}/Vagrantfile.tpl"
  ]
}

build {
  source "source.vagrant.devbox" {
    name = "devbox"
  }

  provisioner "file" {
    source = "${path.root}/files/.bash_aliases"
    destination = "/tmp/.bash_aliases"
  }

  provisioner "shell" {
    override = {
      devbox = {
        execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash -x '{{ .Path }}'"
        environment_vars = [
          "TARGET_USER=vagrant",
          "VERSION=${var.version}"
        ]
      }
      ssavm_image = {
        execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E bash '{{ .Path }}'"
        environment_vars = [
          "TARGET_USER=AzDevOps",
          "VERSION=${var.version}"
        ]
      }
    }

    expect_disconnect = true

    scripts = [
      "${path.root}/scripts/generic/0050_init.sh",
      "${path.root}/scripts/generic/0100_operating_system.sh",
      "${path.root}/scripts/generic/0200_repositories.sh",
      "${path.root}/scripts/generic/0300_generic_tools.sh",
      "${path.root}/scripts/generic/0400_scm_tools.sh",
      "${path.root}/scripts/generic/0500_docker.sh",
      "${path.root}/scripts/generic/0600_python.sh",
      "${path.root}/scripts/generic/0700_ansible.sh",
      "${path.root}/scripts/generic/0800_golang.sh",
      "${path.root}/scripts/generic/0900_azure_cli.sh",
      "${path.root}/scripts/generic/1000_bash.sh",
      "${path.root}/scripts/generic/2000_k8s.sh",
      "${path.root}/scripts/generic/9999_cleanup.sh"
    ]
  }

  post-processors {
    post-processor "vagrant-cloud" {
	  access_token        = "${var.cloud_token}"
      box_tag             = "jaybaws/vscode-backend-ubuntu2204"
      version             = "${var.version}"
      version_description = "See my online [README](https://github.com/jaybaws/packer-boxes/blob/main/README.md) for details!"
    }
  }

}