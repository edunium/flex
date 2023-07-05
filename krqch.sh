#!/bin/bash
clear
rm octeto.txt 2>/dev/null
rm ipfind.txt 2>/dev/null
sudo rm puertos
rm  puerto 2>/dev/null
trap ctrl_c INT
function ctrl_c(){
  echo "Saliendo..."
  exit 1
}

ifconfig | grep "flags" |awk '{print $1}' | tr -d ":" > interfaces.txt
echo "Buscando..."
sleep 1

echo "INTERFACES DISPONIBLES: " $(cat interfaces.txt)
read -p "Elija una opcion: " op

while IFS= read -r interface
do
  if [ $op = $interface ]
  then
      ifconfig $interface | grep "netmask" | awk '{print $2}' | cut -d "." -f 1,2,3 >> octeto.txt
    fi
done < interfaces.txt
echo -n "Procesando:...["
porcentaje=0
for ip in {1..254}
do
  while IFS= read -r contador
  do
    ping -c 1 $contador.$ip | grep "64 bytes" | awk '{print $4}' | tr -d ":" >> ipfind.txt &
    porcentaje=$((porcentaje + 1))
    echo -n "#"
  done < octeto.txt
  #echo -e "espere... $ip "
done
echo -n "] Completado >> 100% IP Recorridas... $porcentaje"
sleep 3
clear
echo "ESCANEO TERMINADO..."
sleep 2
clear
echo "Lista de ip encontradas"
echo ""
echo -e "$(cat ipfind.txt)\n"
echo ""
read -p "Que desea hacer...Salir > 1 Ataque con IP > 2 >> " option

if [ $option == 1 ]
then
    exit 1
else
    echo "ej. -p- --open -sS --min-rate 5000 -vvv -n -nP ip -oG * -sC -sV -p22,xx ip -oN o -oG text"
    echo ""
    read -p "Ingrese la host: " host
    sudo nmap -p- -sCSV --min-rate 5000 -vvv -n $host -oN puertos
    exit 1
fi
bat puertos
#ifconfig | grep "flags=" | awk '{print $1}' | tr -d ":" > interfaces.txt
# ifconfig wlan0 | grep "netmask" | awk '{print $2}' | cut -d ":" -f 1,2,3 > ip.txt
