#!/usr/bin/bash
[ -s /usr/bin/frawk ] && alias awk=frawk
[ -s /usr/bin/grep ] && alias grep=rg
DATA_DIR=$HOME/.local/bin/database/
files=$(find "$DATA_DIR" -type f ! -name '*.sh')
# vars=$(for file in $files; do head -n1 "$file"; done)
vars=($(for file in $files; do head -n1 "$file"; done))
whereVar(){ i=1
	for var in "${vars[@]}"; do
		[ "$var" = "$1" ] && echo "$i" && return
		i=$((i=i+1))
	done;}
loopFile(){ for file in $files; do
		"$@" "$file"
	done;}
whichGet(){ loopFile awk -v which="$1" 'NF {print $which}' | tail -n+2;}
getDate(){ whichGet "$(whereVar date)";}
getItem(){ whichGet "$(whereVar item)";}
getCost(){ whichGet "$(whereVar cost)";}
itemNum(){ whichGet "$(whereVar item)" | cut -d'_' -f1;}
itemNumOnly(){ itemNum | cut -d'-' -f1;}

whereWhich(){ loopFile awk -v which="$2" -v where="$(whereVar "$1")" '$where ~ which';}
whereDate(){ whereWhich date "$1";}
whereItem(){ whereWhich item "$1";}
whereCost(){ whereWhich cost "$1";}
# appendYear(){ awk '{print $1"-2022",$2,$3}'
# skipFirst(){ tail -n+2;}
