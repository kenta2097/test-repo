echo "       ___               _ __    __               ";
echo "      /   |  ____  _____(_) /_  / /__             ";
echo "     / /| | / __ \/ ___/ / __ \/ / _ \            ";
echo "    / ___ |/ / / (__  ) / /_/ / /  __/            ";
echo "   /_/  |_/_/ /_/____/_/_.___/_/\___/             ";
echo "    _          ____             __                ";
echo "   (_)___     / __ \____  _____/ /_____  _____    ";
echo "  / / __ \   / / / / __ \/ ___/ //_/ _ \/ ___/    ";
echo " / / / / /  / /_/ / /_/ / /__/ ,< /  __/ /        ";
echo "/_/_/ /_/  /_____/\____/\___/_/|_|\___/_/         ";
echo "                                                  ";
#	https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=%20Ansible%0Ain%20Docker%20

SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`


##	Setting global profile ansible in Docker aliases 
echo -e "${SET_COLOR}\n Setting global profile ansible in Docker aliases \n ${RESET_COLOR}"
sudo cp 00_server_configuration/files/10-ansible-docker-aliases.sh /etc/profile.d/

cat /etc/profile.d/10-ansible-docker-aliases.sh

##  Docker Hub access and Docker installes are required to use ansible aliases
echo -e "`tput setaf 0; tput setab 1; tput bel`\n Docker Hub access and Docker installed are required to use ansible aliases \n ${RESET_COLOR}"