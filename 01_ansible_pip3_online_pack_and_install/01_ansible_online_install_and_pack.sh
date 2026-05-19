echo "       ___               _ __    __        ____        ___                      ";
echo "      /   |  ____  _____(_) /_  / /__     / __ \____  / (_)___  ___             ";
echo "     / /| | / __ \/ ___/ / __ \/ / _ \   / / / / __ \/ / / __ \/ _ \            ";
echo "    / ___ |/ / / (__  ) / /_/ / /  __/  / /_/ / / / / / / / / /  __/            ";
echo "   /_/  |_/_/ /_/____/_/_.___/_/\___/   \____/_/ /_/_/_/_/ /_/\___/             ";
echo "    _            __        ____                   __                    __      ";
echo "   (_)___  _____/ /_____ _/ / /  ____ _____  ____/ /  ____  ____ ______/ /__    ";
echo "  / / __ \/ ___/ __/ __ \`/ / /  / __ \`/ __ \/ __  /  / __ \/ __ \`/ ___/ //_/ ";
echo " / / / / (__  ) /_/ /_/ / / /  / /_/ / / / / /_/ /  / /_/ / /_/ / /__/ ,<       ";
echo "/_/_/ /_/____/\__/\__,_/_/_/   \__,_/_/ /_/\__,_/  / .___/\__,_/\___/_/|_|      ";
echo "                                                  /_/                           ";
#	https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=%20Ansible%20Online%0Ainstall%20and%20pack%20


SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`

REPO_DIR=/data/repo
ANSIBLE_REPO_DIR=${REPO_DIR}/ansible
PACKAGES_REPO_DIR=${REPO_DIR}/packages

sudo mkdir -p ${ANSIBLE_REPO_DIR}/pip3 ${PACKAGES_REPO_DIR}
sudo chmod 775 ${ANSIBLE_REPO_DIR}/pip3 ${PACKAGES_REPO_DIR}
DISTRIBUTION_VERSION_ID=`grep -ioP '^VERSION_ID=\K.+' /etc/os-release`


##	Install ansible source repository
echo -e "${SET_COLOR}\n Install ansible source repository \n ${RESET_COLOR}"

if [[ ${DISTRIBUTION_VERSION_ID} = '"8.5"' ]] || [[ ${DISTRIBUTION_VERSION_ID} = '"8.6"' ]]
then
  sudo dnf install -y centos-release-ansible-29.noarch 
elif [[ ${DISTRIBUTION_VERSION_ID} = '"9.0"' ]]
then
  echo "The ansible-core.x86_64 will be downloaded on next step for the Linux distribution version ${DISTRIBUTION_VERSION_ID}"
else
  echo -e "`tput setaf 0; tput setab 1; tput bel`\n Linux distribution installed is not a verified version \n ${RESET_COLOR}"
  exit 0
fi


##	Download ansible RPM packages
echo -e "${SET_COLOR}\n Download ansible RPM packages ${ANSIBLE_REPO_DIR} \n ${RESET_COLOR}"
sudo dnf download python3 --resolve --destdir ${ANSIBLE_REPO_DIR}

if [[ ${DISTRIBUTION_VERSION_ID} = '"8.5"' ]] || [[ ${DISTRIBUTION_VERSION_ID} = '"8.6"' ]]
then
  sudo dnf download ansible --resolve --destdir ${ANSIBLE_REPO_DIR} 
elif [[ ${DISTRIBUTION_VERSION_ID} = '"9.0"' ]]
then
  sudo dnf download ansible-core.x86_64 --resolve --destdir ${ANSIBLE_REPO_DIR}
  sudo dnf download python3-pip.noarch --resolve --destdir ${ANSIBLE_REPO_DIR}
else
  echo -e "`tput setaf 0; tput setab 1; tput bel`\n Linux distribution installed is not a verified version \n ${RESET_COLOR}"
  exit 0
fi



##	Install ansible RPM packages
echo -e "${SET_COLOR}\n Install ansible RPM packages \n ${RESET_COLOR}"
sudo dnf install -y ${ANSIBLE_REPO_DIR}/*.rpm


##	Uninstall ansible repository
echo -e "${SET_COLOR}\n Uninstall ansible repository \n ${RESET_COLOR}"

if [[ ${DISTRIBUTION_VERSION_ID} = '"8.5"' ]] || [[ ${DISTRIBUTION_VERSION_ID} = '"8.6"' ]]
then
  sudo dnf remove -y centos-release-configmanagement 
else
  echo -e "Not applicable"
fi



## Pack into a tar.gz file
echo -e "${SET_COLOR}\n Pack into a tar.gz file \n ${RESET_COLOR}"
sudo tar -zcf ${PACKAGES_REPO_DIR}/ansible_packages.tar.gz --directory ${ANSIBLE_REPO_DIR}/ .
ls -alh ${PACKAGES_REPO_DIR}/ansible_packages.tar.gz


##  Copy the tar.gz to the target machine without internet access and run offline installation script
echo -e "`tput setaf 0; tput setab 1; tput bel`\n Copy the tar.gz to the target machine without internet access \n \t and run offline installation script \n ${RESET_COLOR}"
#sudo scp <PACKAGE_NAME>.tar.gz <USER>@<SERVER_IP>:~