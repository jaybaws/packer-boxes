# VS Code Backend - centos 7
Are you a developer whose solutions are targeted at Linux runtimes? Does your company force you to use a Windows laptop?

Yep, so much for [Shift-left testing](https://en.wikipedia.org/wiki/Shift-left_testing)...

I personally like writing code in VS Code, directly on my laptop. However, testing locally proved to be problematic. Even the Windows Subsystem for Linux (v1 and v2) in combination with Docker Desktop did not tackle all my challenges.

For testing, I have settled on defering all tests to a (local) VM that can be easily set up and disposed of. Ergo, this Vagrant box.

This (centos-7) box ships with:

- Yamllint
- Ansible
- Ansible-lint
- Molecule
- Docker
- Testinfra
- Azure CLI
  - Azure DevOps extension (and it's dependencies)

# Sources
- My [Packer Sources](https://github.com/jaybaws/packer-boxes)

Credits to Jeff Geerling, for [his repo](https://github.com/geerlingguy/packer-boxes/) that was used as a source of inspiration.

# Operation

## Set up a customizable Vagrantfile

Running `vagrant init` will result in a working VM, but you may want to use the customize Vagrantfile.

On Cygwin, or any Linux like command shell:
```
mkdir myFolder
cd myFolder
export BOX_VER=1.0.4
vagrant box add --box-version $BOX_VER jaybaws/vscode-backend-centos7
cp ~/.vagrant.d/boxes/jaybaws-VAGRANTSLASH-vscode-backend-centos7/$BOX_VER/virtualbox/Vagrantfile .
```

On the Windows command prompt:
```
md myFolder
cd myFolder
set BOX_VER=1.0.4
vagrant box add --box-version %BOX_VER% jaybaws/vscode-backend-centos7
copy %USERPROFILE%\.vagrant.d\boxes\jaybaws-VAGRANTSLASH-vscode-backend-centos7\%BOX_VER%\virtualbox\Vagrantfile
```

### Customize the VM (optional)

The following environment variables can be set (prior to `vagrant up`) to override any of the VM settings:

- `VSCLB_MEMORY`, default = `512`.
- `VSCLB_CPUS`, default = `2`.
- `VSCLB_SSH_PORT`, default = `22222`.
- `VSCLB_TIMEZONE`, optional. Override the local time-zone, for instance `Europe/Amsterdam`.
- `VSCLB_PS1`, optional. Customize the terminal prompt.
- `VSCLB_WORKSPACE`, optional. Specifies any local folder on the host that will be synced to `/workspace` within the guest VM.
- `VSCLB_PKEY`, optional. Specifies the location to your local private SSH key. It wil be copied to `/home/vagrant/.ssh/id_rsa`, so GIT automatically works.
- `VSCLB_KH`, optional. Specifies the location to your local `known_hosts` file. It will be copied to `/home/vagrant/.ssh/known_hosts`, so GIT automatically works.
- `VSCLB_SCRIPT`, optional. Specifies the location to a local script. This script will be executed at the end of the provisioning phase. Use it to do final post-configuration.

## Spin it up

```
vagrant up
```

# Integrate with VS Code

Finally, add the output of `vagrant ssh-config` to your `~/.ssh/config`. That could look like this:

```yaml
Host dev.linux.backend.local
  HostName localhost
  User vagrant
  Port 22222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile ~/.vagrant.d/insecure_private_key
  IdentitiesOnly yes
  LogLevel ERROR
```