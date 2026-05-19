echo "       __  _______  __________     ";
echo "      /  |/  / __ \/_  __/ __ \    ";
echo "     / /|_/ / / / / / / / / / /    ";
echo "    / /  / / /_/ / / / / /_/ /     ";
echo "   /_/  /_/\____/ /_/ /_____/      ";
echo "                                   ";
#	https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=%20MOTD%20

SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`


##	Setting MOTD message in the server 
echo -e "${SET_COLOR}\n Setting MOTD message in the server \n ${RESET_COLOR}"
sudo cp 00_server_configuration/files/00-motd.sh /etc/profile.d/

cat /etc/profile.d/00-motd.sh

##  MOTD message will be displayed on next logon
echo -e "`tput setaf 0; tput setab 1; tput bel`\n MOTD message will be displayed on next logon \n ${RESET_COLOR}"