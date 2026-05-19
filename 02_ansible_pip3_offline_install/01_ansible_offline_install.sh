echo "         ___               _ __    __                            ";
echo "        /   |  ____  _____(_) /_  / /__                          ";
echo "       / /| | / __ \/ ___/ / __ \/ / _ \                         ";
echo "      / ___ |/ / / (__  ) / /_/ / /  __/                         ";
echo "     /_/  |_/_/ /_/____/_/_.___/_/\___/                          ";
echo "   ____  ___________               _            __        ____   ";
echo "  / __ \/ __/ __/ (_)___  ___     (_)___  _____/ /_____ _/ / /   ";
echo " / / / / /_/ /_/ / / __ \/ _ \   / / __ \/ ___/ __/ __ \`/ / /   ";
echo "/ /_/ / __/ __/ / / / / /  __/  / / / / (__  ) /_/ /_/ / / /     ";
echo "\____/_/ /_/ /_/_/_/ /_/\___/  /_/_/ /_/____/\__/\__,_/_/_/      ";
echo "                                                                 ";
#	https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=%20%20Ansible%20%0AOffline%20install%20


SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`

REPO_DIR=/data/repo
ANSIBLE_REPO_DIR=${REPO_DIR}/ansible
PACKAGES_REPO_DIR=${REPO_DIR}/packages


sudo mkdir -p ${ANSIBLE_REPO_DIR}
sudo chmod 775 ${ANSIBLE_REPO_DIR}


##  Unpack the tar.gz file to /data/repo/ansible in the target machine
echo -e "${SET_COLOR}\n Unpack the tar.gz file to ${ANSIBLE_REPO_DIR} in the target machine \n ${RESET_COLOR}"
sudo tar -zxf ${PACKAGES_REPO_DIR}/ansible_packages.tar.gz --directory ${ANSIBLE_REPO_DIR} .
tree ${ANSIBLE_REPO_DIR}


##	Install ansible RPM packages
echo -e "${SET_COLOR}\n Install ansible RPM packages \n ${RESET_COLOR}"
sudo dnf install -y --disablerepo=* ${ANSIBLE_REPO_DIR}/*.rpm