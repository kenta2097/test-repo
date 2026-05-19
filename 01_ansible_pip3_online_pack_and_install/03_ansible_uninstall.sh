echo "       ___               _ __    __          ";
echo "      /   |  ____  _____(_) /_  / /__        ";
echo "     / /| | / __ \/ ___/ / __ \/ / _ \       ";
echo "    / ___ |/ / / (__  ) / /_/ / /  __/       ";
echo "   /_/  |_/_/ /_/____/_/_.___/_/\___/        ";
echo "               _            __        ____   ";
echo "  __  ______  (_)___  _____/ /_____ _/ / /   ";
echo " / / / / __ \/ / __ \/ ___/ __/ __ \`/ / /   ";
echo "/ /_/ / / / / / / / (__  ) /_/ /_/ / / /     ";
echo "\__,_/_/ /_/_/_/ /_/____/\__/\__,_/_/_/      ";
echo "                                             ";
#	https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=%20Ansible%0Auninstall%20


SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`

ANSIBLE_REPO_DIR=/data/repo/ansible

##	Uninstall ansible RPM packages
echo -e "${SET_COLOR}\n Uninstall ansible RPM packages \n ${RESET_COLOR}"

sudo dnf remove -y ansible \
python36 \
python3-babel \
python3-cffi \
python3-cryptography \
python3-jinja2 \
python3-jmespath \
python3-markupsafe \
python3-pip \
python3-pycparser \
python3-pytz \
sshpass


##	Delete ansible RPM packages
echo -e "${SET_COLOR}\n Delete ansible RPM packages \n ${RESET_COLOR}"
sudo rm -fv ${ANSIBLE_REPO_DIR=/}/*.rpm


##	Clear program location cache
hash -r