variable "version" {
  type    = string
}

source "vagrant" "devbox" {
  source_path          = "generic/centos8s"
  box_version          = "4.2.16"
  provider             = "virtualbox"
  add_force            = true
  communicator         = "ssh"
  template             = "Vagrantfile_init"
  vagrantfile_template = "Vagrantfile.tpl"
}

build {
  sources = ["source.vagrant.devbox"]

  provisioner "shell" {
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    expect_disconnect = true
    environment_vars = [
      "TARGET_USER=vagrant"
    ]
    scripts = [
		"${path.root}/scripts/repos.sh",
		"${path.root}/scripts/scm_tools.sh",
		"${path.root}/scripts/docker.sh",
		"${path.root}/scripts/python.sh",
		"${path.root}/scripts/golang.sh",
		"${path.root}/scripts/ansible.sh",
		"${path.root}/scripts/azure.sh"
	]
  }

  post-processors {
    post-processor "vagrant-cloud" {
      box_tag             = "jaybaws/vscode-backend-centos8s"
      version             = "${var.version}"
      version_description = "See my online [README](https://github.com/jaybaws/packer-boxes/blob/main/README.md) for details!"
    }
  }
}