RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

reset

for x in `cat ~/bin/omen.host`
do
	echo -e "${BLUE}=======================================================[ Server IP address ]====${NC}"
	printf ${BLUE}
	figlet -f future -r $x
	printf ${GREEN}
	ssh $USER@$x -i ~/.ssh/id_rsa $1	
done

echo -e "${RED}===================================================[ OmenShell by incognia ]====${NC}"