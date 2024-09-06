# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

box_ver() {
    echo $BOX_VERSION
}

# Custom bash prompt
export PS1="\[$(tput setaf 239)\]devbox \$(box_ver) \[$(tput setaf 6)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 2)\]\h\[$(tput sgr0)\]\[$(tput setaf 7)\]:\[$(tput sgr0)\]\[$(tput setaf 5)\]\W\[$(tput sgr0)\]\[$(tput bold)\]\[$(tput setaf 3)\]\$(parse_git_branch)\[$(tput sgr0)\]\[$(tput setaf 7)\] \\$ \[$(tput sgr0)\]"

# Molecule/Ansible aliases
molecule() {
    source ~/.venv/ansible-stable/bin/activate
    ANSIBLE_COLLECTIONS_PATH=~/.ansible-stable ~/.venv/ansible-stable/bin/molecule "$@"
    deactivate
}

molecule-experimental() {
    source ~/.venv/ansible-experimental/bin/activate
    ANSIBLE_COLLECTIONS_PATH=~/.ansible-experimental ~/.venv/ansible-experimental/bin/molecule "$@"
    deactivate
}

ansible-playbook() {
    source ~/.venv/ansible-stable/bin/activate
    ANSIBLE_COLLECTIONS_PATH=~/.ansible-stable ~/.venv/ansible-stable/bin/ansible-playbook "$@"
    deactivate
}

ansible-playbook-experimental() {
    source ~/.venv/ansible-experimental/bin/activate
    ANSIBLE_COLLECTIONS_PATH=~/.ansible-experimental ~/.venv/ansible-experimental/bin/ansible-playbook "$@"
    deactivate
}

ansible() {
    source ~/.venv/ansible-stable/bin/activate
    ANSIBLE_COLLECTIONS_PATH=~/.ansible-stable ~/.venv/ansible-stable/bin/ansible "$@"
    deactivate
}

ansible-experimental() {
    source ~/.venv/ansible-experimental/bin/activate
    ANSIBLE_COLLECTIONS_PATH=~/.ansible-experimental ~/.venv/ansible-experimental/bin/ansible "$@"
    deactivate
}

ansible-lint() {
    source ~/.venv/ansible-stable/bin/activate
    ANSIBLE_COLLECTIONS_PATH=~/.ansible-stable ~/.venv/ansible-stable/bin/ansible-lint "$@"
    deactivate
}

ansible-lint-experimental() {
    source ~/.venv/ansible-experimental/bin/activate
    ANSIBLE_COLLECTIONS_PATH=~/.ansible-experimental ~/.venv/ansible-experimental/bin/ansible-lint "$@"
    deactivate
}