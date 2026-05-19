echo "           _      _____          ___________               _            __        ____   ";
echo "    ____  (_)___ |__  /   ____  / __/ __/ (_)___  ___     (_)___  _____/ /_____ _/ / /   ";
echo "   / __ \/ / __ \ /_ <   / __ \/ /_/ /_/ / / __ \/ _ \   / / __ \/ ___/ __/ __ \`/ / /   ";
echo "  / /_/ / / /_/ /__/ /  / /_/ / __/ __/ / / / / /  __/  / / / / (__  ) /_/ /_/ / / /     ";
echo " / .___/_/ .___/____/   \____/_/ /_/ /_/_/_/ /_/\___/  /_/_/ /_/____/\__/\__,_/_/_/      ";
echo "/_/     /_/                                                                              ";
echo "       __                          __                _                                   ";
echo "  ____/ /__  ____  ___  ____  ____/ /__  ____  _____(_)__  _____                         ";
echo " / __  / _ \/ __ \/ _ \/ __ \/ __  / _ \/ __ \/ ___/ / _ \/ ___/                         ";
echo "/ /_/ /  __/ /_/ /  __/ / / / /_/ /  __/ / / / /__/ /  __(__  )                          ";
echo "\__,_/\___/ .___/\___/_/ /_/\__,_/\___/_/ /_/\___/_/\___/____/                           ";
echo "         /_/                                                                             ";
#	https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=pip3%20offline%20install%20%0Adependencies%0A

##	It's required the pip3_packages.tar.gz in the user local home folder

SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`

REPO_DIR=/data/repo
ANSIBLE_REPO_DIR=${REPO_DIR}/ansible
PACKAGES_REPO_DIR=${REPO_DIR}/packages


##  Unpack the tar.gz file to /data/repo/ansible/pip3 in the target machine
echo -e "${SET_COLOR}\n Unpack the tar.gz file to ${ANSIBLE_REPO_DIR}/pip3 in the target machine \n ${RESET_COLOR}"
sudo tar -zxf ${PACKAGES_REPO_DIR}/pip3_packages.tar.gz --directory ${ANSIBLE_REPO_DIR}
tree ${ANSIBLE_REPO_DIR}/pip3


##  Update pip
echo -e "${SET_COLOR}\n Update pip \n ${RESET_COLOR}"
pip3 install --user ${ANSIBLE_REPO_DIR}/pip3/pip*


##  Install pip3 packages
echo -e "${SET_COLOR}\n Install pip3 packages \n ${RESET_COLOR}"
pip3 install --user -r ${ANSIBLE_REPO_DIR}/pip3/requirements.txt --no-index --find-links ${ANSIBLE_REPO_DIR}/pip3/


##  Uninstall pip3 packages
#pip3 uninstall -y -r /data/repo/ansible/pip3/requirements.txt
#pip3 uninstall -y pywinrm wheel certifi cffi charset-normalizer cryptography idna ntlm-auth pycparser requests requests-ntlm setuptools six urllib3 xmltodict