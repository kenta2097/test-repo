echo "       ____  _      _____    ____        ___                                                   ";
echo "      / __ \(_)___ |__  /   / __ \____  / (_)___  ___                                          ";
echo "     / /_/ / / __ \ /_ <   / / / / __ \/ / / __ \/ _ \                                         ";
echo "    / ____/ / /_/ /__/ /  / /_/ / / / / / / / / /  __/                                         ";
echo "   /_/   /_/ .___/____/   \____/_/ /_/_/_/_/ /_/\___/                                          ";
echo "          /_/         __          __                          __                _              ";
echo "    ____  ____ ______/ /__   ____/ /__  ____  ___  ____  ____/ /__  ____  _____(_)__  _____    ";
echo "   / __ \/ __ \`/ ___/ //_/  / __  / _ \/ __ \/ _ \/ __ \/ __  / _ \/ __ \/ ___/ / _ \/ ___/   ";
echo "  / /_/ / /_/ / /__/ ,<    / /_/ /  __/ /_/ /  __/ / / / /_/ /  __/ / / / /__/ /  __(__  )     ";
echo " / .___/\__,_/\___/_/|_|   \__,_/\___/ .___/\___/_/ /_/\__,_/\___/_/ /_/\___/_/\___/____/      ";
echo "/_/                                 /_/                                                        ";
#	https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=%20Pip3%20Online%20%0Apack%20dependencies%20

SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`

REPO_DIR=/data/repo
PACKAGES_REPO_DIR=${REPO_DIR}/packages


##	Create and activate python3 virtual env 
echo -e "${SET_COLOR}\n Create and activate python3 virtual env \n ${RESET_COLOR}"

python3 -m venv ~/python3_venv
source ~/python3_venv/bin/activate
ls -alh ~/ | grep python3_venv


##  Install packages and list dependencies in python3 virtual env
echo -e "${SET_COLOR}\n Install packages and list dependencies in python3 virtual env \n ${RESET_COLOR}"

pip3 install --upgrade pip setuptools
pip3 install pywinrm wheel
echo -e "\n"
pip3 list


##  Generate requirements.txt with the packages including pip3 and wheel
mkdir ~/pip3
echo -e "${SET_COLOR}\n Generate requirements.txt with the packages including pip3 and wheel \n ${RESET_COLOR}"
pip3 freeze --all > ~/pip3/requirements.txt
ls -alh ~/pip3/requirements.txt


##  Download the packages from requirements.txt
echo -e "${SET_COLOR}\n Download the packages from requirements.txt \n ${RESET_COLOR}"
pip3 download -d ~/pip3 -r ~/pip3/requirements.txt


##  Deactivate and delete Python3 virtual env
echo -e "${SET_COLOR}\n Deactivate and delete Python3 virtual env \n ${RESET_COLOR}"
deactivate && rm -rf ~/python3_venv


## Pack into a tar.gz file
echo -e "${SET_COLOR}\n Pack into a tar.gz file \n ${RESET_COLOR}"
sudo tar -zcf ${PACKAGES_REPO_DIR}/pip3_packages.tar.gz --directory ~/ pip3
ls -alh ${PACKAGES_REPO_DIR}/pip3_packages.tar.gz


## Delete pip3 package download temp folder
echo -e "${SET_COLOR}\n Delete pip3 package download temp folder \n ${RESET_COLOR}"
rm -rf ~/pip3


##  Copy the tar.gz to the target machine without internet access and run offline installation script
echo -e "`tput setaf 0; tput setab 1; tput bel`\n Copy the tar.gz to the target machine without internet access \n \t and run offline installation script \n ${RESET_COLOR}"
#sudo scp <PACKAGE_NAME>.tar.gz <USER>@<SERVER_IP>:~