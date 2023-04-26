# VS Code Backend - centos 8 stream
Are you a developer whose solutions are targeted at Linux runtimes? Does your company force you to use a Windows laptop?

Yep, so much for [Shift-left testing](https://en.wikipedia.org/wiki/Shift-left_testing)...

I personally like writing code in VS Code, directly on my laptop. However, testing locally proved to be problematic. Even the Windows Subsystem for Linux (v1 and v2) in combination with Docker Desktop did not tackle all my challenges.

For testing, I have settled on defering all tests to a (local) VM that can be easily set up and disposed of. Ergo, this Vagrant box.

This (centos8s) box ships with:

- Python 3.11
- Golang 1.19.4
- Ansible 2.14.2
- Ansible-lint 6.15.0
- Molecule 5.0.0
- Docker 23.0.4
- Azure CLI 2.48.1
- Testinfra

# Sources
- My [Packer Sources](https://github.com/jaybaws/packer-boxes)

# Operation

## Set up a customizable Vagrantfile

Running `vagrant init` will result in a working VM, but you may want to use the customize Vagrantfile.

On Cygwin, or any Linux like command shell:
```
mkdir myFolder
cd myFolder
export BOX_VER=1.0.0
vagrant box add --box-version $BOX_VER jaybaws/vscode-backend-centos8s
cp ~/.vagrant.d/boxes/jaybaws-VAGRANTSLASH-vscode-backend-centos8s/$BOX_VER/virtualbox/Vagrantfile .
```

On the Windows command prompt:
```
md myFolder
cd myFolder
set BOX_VER=1.0.0
vagrant box add --box-version %BOX_VER% jaybaws/vscode-backend-centos8s
copy %USERPROFILE%\.vagrant.d\boxes\jaybaws-VAGRANTSLASH-vscode-backend-centos8s\%BOX_VER%\virtualbox\Vagrantfile
```

### Customize the VM (optional)

The following environment variables can be set (prior to `vagrant up`) to override any of the VM settings:

- `VSCLB_FQDN`, default = `dev.linux.backend.local`.
- `VSCLB_MEMORY`, default = `512`.
- `VSCLB_CPUS`, default = `2`.
- `VSCLB_SSH_PORT`, default = `22222`.
- `VSCLB_TIMEZONE`, optional. Override the local time-zone, for instance `Europe/Amsterdam`.
- `VSCLB_PS1`, optional. Customize the terminal prompt.
- `VSCLB_WORKSPACE`, optional. Specifies any local folder on the host that will be synced to `/workspace` within the guest VM.
- `VSCLB_PKEY`, optional. Specifies the location to your local private SSH key. It wil be copied to `/home/vagrant/.ssh/id_rsa`, so GIT automatically works.
- `VSCLB_KH`, optional. Specifies the location to your local `known_hosts` file. It will be copied to `/home/vagrant/.ssh/known_hosts`, so GIT automatically works.
- `VSCLB_SCRIPT`, optional. Specifies the location to a local script. This script will be executed at the end of the provisioning phase. Use it to do final post-configuration.
- `VSCLB_FORWARDS_TCP`, optional. Specifies which TCP ports should be forwarded to the host. Format: `{ "443":443, "14140":14140, "14150":14150 }`
- `VSCLB_FORWARDS_UDP`, optional. Specifies which UDP ports should be forwarded to the host. Simliar format as for TCP.

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
