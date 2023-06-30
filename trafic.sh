#!/bin/bash
#fis=./1.txt
PS3="Alege o optiune din meniu: " 
select ITEM in "Captura trafic" "Blocare port interfata" "Blocare adresa IP" "Alerte" "Exit" 
do 
    case $REPLY in 
        1) 
        echo -n "Introduceti timpul in secunde pentru efectuarea capturii de ecran: "
        read timp
          echo -n "Introduceti numele protocolului pentru filtrare: "
          read protocol
        echo -n "Introduceti numele fisierului in care salvati captura de trafic: "
        read fisier
        touch "$fisier"
        if [  "$protocol" = "all" ]
        then
        	sudo tshark -a duration:"$timp" > "$fisier"
	else
		sudo tshark -a duration:"$timp" | egrep "$protocol" > "$fisier"
	fi	
        cat "$fisier"
        
        ;; 
        
        2)
        echo -n "Tipul de pachete pe care doresti sa le blochezi: "
        read protocol 
        echo -n "Portul destinatie: "
        read port
        
        sudo iptables -A INPUT -p "$protocol" --dport "$port" -j DROP
        sudo iptables -L --line-numbers
        ;; 
        
        3)
        echo -n "Numarul de adrese IP pe care doresti sa le blochezi: "
        read nr_adr
        for ((i=1; i<=nr_adr; i++))
        do
        	echo -n "Introduceti adresa"$i" IP pe care doriti sa o blocati: "
        	read adr_IP
        	sudo iptables -A INPUT -s "$adr_IP" -j DROP
        	sudo iptables -L --line-numbers	
        done
        ;;
        
        4) echo  "Introduceti o regula pentru care doriti alerta"
        echo -n  "Protocol: "
        read prot_alerta
        echo -n "IP sursa: "
        read IP_alerta_s
        echo -n "Port sursa: "
        read port_alerta_s
        echo -n "IP destinatie: "
        read IP_alerta_d
        echo -n "Port destinatie: "
        read port_alerta_d
        message="Alerta trafic: IP sursa: $IP_alerta_s, Port sursa: $port_alerta_s, IP destinatie: $IP_alerta_d, Port destinatie: $port_alerta_d, Protocol: $prot_alerta"
        echo "Timp pentru inregistrare trafic"
        read time
        sudo timeout $time tcpdump -n
        verificare=$(sudo timeout "$time" tcpdump -n > "tr.txt")
        while read line
        do
        	verificare2=$(echo "$line" | egrep "$prot_alerta" | egrep "$IP_alerta_s > $IP_alerta_d")
        	if [ -n "$verificare2" ] 
        	then 
           		echo "$message"
        	fi
        done <"tr.txt"
        ;;
        5) exit 0 ;;   
        
        *) echo "Optiune incorecta" 
    esac
done