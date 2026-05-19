echo "    ____                                                              ";
echo "   / __ \_________  _  ____  __                                       ";
echo "  / /_/ / ___/ __ \| |/_/ / / /                                       ";
echo " / ____/ /  / /_/ />  </ /_/ /                                        ";
echo "/_/   /_/   \____/_/|_|\__, /                                         ";
echo "                      /____/                                          ";
echo "                    _____                        __  _                ";
echo "  _________  ____  / __(_)___ ___  ___________ _/ /_(_)___  ____      ";
echo " / ___/ __ \/ __ \/ /_/ / __ \`/ / / / ___/ __ \`/ __/ / __ \/ __ \   ";
echo "/ /__/ /_/ / / / / __/ / /_/ / /_/ / /  / /_/ / /_/ / /_/ / / / /     ";
echo "\___/\____/_/ /_/_/ /_/\__, /\__,_/_/   \__,_/\__/_/\____/_/ /_/      ";
echo "                      /____/                                          ";
# https://patorjk.com/software/taag/#p=display&v=1&c=echo&f=Slant&t=Proxy%0Aconfiguration%20

SET_COLOR=`tput setaf 0;tput setab 2`
RESET_COLOR=`tput sgr 0`

SET_SHORT_PROXY_URL="gateway.schneider.zscaler.net:9480"
SET_PROXY_URL="http://${SET_SHORT_PROXY_URL}/"
SET_NO_PROXY_URL="127.0.0.1,localhost,172.*,139.160.*,139.158.*,157.198.*,192.*,192.168.*,10.*"

DNF_CONFIG="/etc/dnf/dnf.conf"
PROXY_SCRIPTS="/etc/profile.d/proxy*"

EXTERNAL_URL="www.google.es"


##	Check if ${EXTERNAL_URL} is accessible
echo -e "${SET_COLOR}\n Check if ${EXTERNAL_URL} is accessible \n ${RESET_COLOR}"

wget -q --spider ${EXTERNAL_URL}
if [ $? = 1 ]
then
        echo -e "`tput setaf 0; tput setab 1; tput bel` \n Proxy isn't working \n \t ${EXTERNAL_URL} is NOT accessible \n ${RESET_COLOR}"
else
        echo -e "`tput setaf 2` \n Proxy is working \n \t ${EXTERNAL_URL} is accessible \n ${RESET_COLOR}"
fi
