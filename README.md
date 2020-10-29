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

# Sources
- My [Packer Sources](https://github.com/jaybaws/packer-boxes)

Credits to Jeff Geerling, for [his repo](https://github.com/geerlingguy/packer-boxes/) that was used as a source of inspiration.

# Spinning it up

Run it using the obvious commands:

```
vagrant init jaybaws/packer-boxes
vagrant up
```

# Customize the VM

The following environment variables can be set (prior to `vagrant up`) to override any of the VM settings:

- `VSCLB_MEMORY`, default = `512`.
- `VSCLB_CPUS`, default = `2`.
- `VSCLB_SSH_PORT`, default = `22222`.
- `VSCLB_TIMEZONE`, optional. Override the local time-zone, for instance `Europe/Amsterdam`.
- `VSCLB_PS1`, optional. Customize the terminal prompt.
- `VSCLB_WORKSPACE`, optional. Specifies any local folder on the host that will be synced to `/workspace` within the guest VM.

# Integrate with VS Code

Finally, add this to your `~/.ssh/config` file:

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