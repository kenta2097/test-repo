echo "       ____                                                           ";
echo "      / __ \_________  _  ____  __                                    ";
echo "     / /_/ / ___/ __ \| |/_/ / / /                                    ";
echo "    / ____/ /  / /_/ />  </ /_/ /                                     ";
echo "   /_/   /_/   \____/_/|_|\__, /                                      ";
echo "                    _____/____/                  __  _                ";
echo "  _________  ____  / __(_)___ ___  ___________ _/ /_(_)___  ____      ";
echo " / ___/ __ \/ __ \/ /_/ / __ \`/ / / / ___/ __ \`/ __/ / __ \/ __ \   ";
echo "/ /__/ /_/ / / / / __/ / /_/ / /_/ / /  / /_/ / /_/ / /_/ / / / /     ";
echo "\___/\____/_/ /_/_/ /_/\__, /\__,_/_/   \__,_/\__/_/\____/_/ /_/      ";
echo "                      /____/                                          ";
#	https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=%20Proxy%0Aconfiguration%20

SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`

SET_SHORT_PROXY_URL="gateway.schneider.zscaler.net:9480"
SET_PROXY_URL="http://${SET_SHORT_PROXY_URL}/"
SET_NO_PROXY_URL="127.0.0.1,localhost,172.*,139.160.*,139.158.*,157.198.*,192.*,192.168.*,10.*,github.schneider-electric.com,artifactory-dev.se.com,artifactory.se.com"

DNF_CONFIG="/etc/dnf/dnf.conf"
PROXY_SCRIPTS="/etc/profile.d/proxy*"

EXTERNAL_URL="www.google.es"


##	Setting global profile proxy configuration 
echo -e "${SET_COLOR}\n Setting global profile proxy configuration \n ${RESET_COLOR}"
sudo cp 00_server_configuration/files/proxy* /etc/profile.d/
sudo sed -i "/NO_PROXY_URL=NOT_SET/c\NO_PROXY_URL=\"${SET_NO_PROXY_URL}\"" ${PROXY_SCRIPTS}
sudo sed -i "/PROXY_URL=NOT_SET/c\PROXY_URL=\"${SET_PROXY_URL}\"" ${PROXY_SCRIPTS}

cat ${PROXY_SCRIPTS}


##	Setting proxy configuration for dnf package manager
echo -e "${SET_COLOR}\n Setting proxy configuration for dnf package manager \n ${RESET_COLOR}"

if  grep -q "proxy=" "${DNF_CONFIG}" ; then
        sudo sed -i "/.*proxy=.*/c\proxy=${SET_SHORT_PROXY_URL}" ${DNF_CONFIG} ; 
else
        echo "proxy=${SET_SHORT_PROXY_URL}" | sudo tee --append ${DNF_CONFIG} ; 
fi

cat ${DNF_CONFIG}


####	Check if ${EXTERNAL_URL} is accessible
##echo -e "${SET_COLOR}\n Check if ${EXTERNAL_URL} is accessible \n ${RESET_COLOR}"
##
##wget -q --spider ${EXTERNAL_URL}
##if [ $? = 1 ]
##then
##        echo -e "`tput setaf 0; tput setab 1; tput bel` \n Proxy isn't working \n \t ${EXTERNAL_URL} is NOT accessible \n ${RESET_COLOR}"
##else
##        echo -e "`tput setaf 2` \n Proxy is working \n \t ${EXTERNAL_URL} is accessible \n ${RESET_COLOR}"
##fi
