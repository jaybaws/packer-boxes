node_name = "dev.linux.backend.local"
node_memory = ENV["VSCLB_MEMORY"] || "512"
node_cpus = ENV["VSCLB_CPUS"] || "2"
node_ssh_port = ENV["VSCLB_SSH_PORT"] || 22222

node_pkey = ENV["VSCLB_PKEY"]
node_kh = ENV["VSCLB_KH"]
node_timezone = ENV["VSCLB_TIMEZONE"]
node_ps1 = ENV["VSCLB_PS1"]
node_workspace_syncfolder = ENV["VSCLB_WORKSPACE"]

Vagrant.configure("2") do |config|

  # Stick to the default (insecure) key provided by Vagrant, so it is easy to integrate with VS Code.
  config.ssh.insert_key = false

  config.vm.define node_name do |instance|
    # Pick our Vagrant box!
    instance.vm.box = "jaybaws/vscode-backend-centos7"

    # Set the hostname and IP address.
    instance.vm.hostname = node_name
    instance.vm.network :private_network, type: "dhcp"

    # Assure SSH daemon is on the expected port.
	instance.vm.network :forwarded_port, guest: 22, host: node_ssh_port, id: 'ssh'

    # Customize VirtualBox VM size.
    instance.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", node_memory]
      vb.customize ["modifyvm", :id, "--cpus", node_cpus]
      vb.customize ["modifyvm", :id, "--name", node_name]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    # If set, set to local time-zone.
    if node_timezone
      config.vm.provision "shell" do |s|
        s.inline = "sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/$1 /etc/localtime"
        s.args   = [node_timezone]
      end
	end

    # If set, customize the Bash prompt.
    if node_ps1
      config.vm.provision "shell" do |s|
        s.inline = "echo export PS1=\"$1\" > /etc/profile.d/colorbash.sh"
        s.args   = ['"' + node_ps1 + '"']
      end
	end

    # If set, sync a workspace folder into the guest VM.
    if node_workspace_syncfolder
      instance.vm.synced_folder node_workspace_syncfolder, "/workspace"
    end

    # If set, provision an SSH private key (so GIT will work right away).
    if node_pkey
      config.vm.provision "file", source: node_pkey, destination: "/home/vagrant/.ssh/id_rsa"
      config.vm.provision "shell" do |s|
        s.inline = "sudo chmod 600 /home/vagrant/.ssh/id_rsa"
       end
	end

    # If set, provision an known_hosts file (so GIT will work right away).
    if node_kh
      config.vm.provision "file", source: node_kh, destination: "/home/vagrant/.ssh/known_hosts"
      config.vm.provision "shell" do |s|
        s.inline = "sudo chmod 644 /home/vagrant/.ssh/known_hosts"
       end
	end

  end
end
