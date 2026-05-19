## Ansible in docker container aliases

export DOCKER_ANSIBLE_VERSION=2.13
export DOCKER_IMAGE_VERSION=ubuntu-22.04

base_ansible() {
    docker run -it --rm --name ansible-in-docker --env ANSIBLE_REMOTE_USER=${USER} --env ANSIBLE_CONFIG=${PWD}/deployer/ansible.cfg --volume $SSH_AUTH_SOCK:/ssh-agent --env SSH_AUTH_SOCK=/ssh-agent -v ${PWD}:${PWD} -v ${HOME}/.ssh/known_hosts:/root/.ssh/known_hosts -w ${PWD} nikolamilosa/ansible-schneider:0.1.0 $@
}

alias ansible='base_ansible ansible'
alias ansible-playbook='base_ansible ansible-playbook'
alias ansible-vault='base_ansible ansible-vault'
alias ansible-galaxy='base_ansible ansible-galaxy'
alias ansible-doc='base_ansible ansible-doc'
