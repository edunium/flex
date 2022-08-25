#!/bin/bash
#by krqch

trap ctrl_c INt
clear
function ctrl_c(){
	echo "Saliendo..."
}

function helpPanel(){
	echo "panel de ayuda"
}

function dependencia(){
	echo "comprobando dependencias necesarias"
	dependencias=(fish git)
	echo "======== chequeando dependencias"
	sleep 4

	for depe in "${dependencias[@]}"; do
		test -f /usr/bin/$depe

		if [ "$(echo $?) == "0" ]; then
			echo "holahola"
		else
			echo "chauchau"
		fi; sleep 1
	done	
}

if [ "$(id -u)" == "0" ]; then
	echo "Soy ROOT"
	declare -i parameter_counter=0; while getopts "a:n:h:" arg; do
		case $arg in
			a) attack_mode=$OPTARG; let parameter_counter+=1;;
			n) networkCard=$OPTARG; let parameter_counter+=1;;
			h) helpPanel;;
		esac
	done
	if [ $parameter_counter -ne 2 ]; then
		helpPanel
		
	else
		echo "+++++++++++++++$OPTARG"
		#dependencia
		echo "Modo ataque"
	fi

else
	echo "No soy ROOT"
fi


#sleep 5

