# Proiect_practica
Realizatori: Popa + Sumanariu (C112 C)

Ziua 1:
Ne-am documentat in legatura cu folosirea wireshark-ului pe VM si a comenzii "tshark"

Ziua 2:
#!/bin/bash
echo -n "Introduceti timpul in secunde pentru efectuarea capturii de ecran: "
read timp
echo -n "Introduceti numele protocolului pentru filtrare (sau \"all\" pentru a afisa toata captura de trafic): "
read protocol
echo -n "Introduceti numele fisierului in care salvati captura de trafic: "
read fisier
touch "$fisier"
cat "$fisier"

Ziua 3:
In aceasta zi, am adaugat si conditiile pentru filtrare:
  - numele protocolului pt filtrare
  - "all" pentru a afisa toata captura

echo -n "Introduceti timpul in secunde pentru efectuarea capturii de ecran: "
        read timp
          echo -n "Introduceti numele protocolului pentru filtrare (sau \"all\" pentru a afisa toata captura de trafic): "
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

Ziua 4:

Ne-am documentat pentru etapa in care trebuie sa "blocam" trafic de la un anumit port sau adresa etc
Am descoperit comanda "iptables", impreuna cu optiunile si atributele acestora
Sursa de documentare: https://www.geeksforgeeks.org/iptables-command-in-linux-with-examples/ 

Ziua 5:

Am implementat optiunea pentru "blocarea" traficului de pe un port:

echo -n "Tipul de pachete pe care doresti sa le blochezi: "
        read protocol 
        echo -n "Portul destinatie: "
        read port
        
        sudo iptables -A INPUT -p "$protocol" --dport "$port" -j DROP
        sudo iptables -L --line-numbers


Ziua 6:

Am implementat optiunea pentru "blocarea" traficului de la o anumita adresa IP sau mai multe:

echo -n "Numarul de adrese IP pe care doresti sa le blochezi: "
        read nr_adr
        for ((i=1; i<=nr_adr; i++))
        do
        	echo -n "Introduceti adresa"$i" IP pe care doriti sa o blocati: "
        	read adr_IP
        	sudo iptables -A INPUT -s "$adr_IP" -j DROP
        	sudo iptables -L --line-numbers	
        done


Ziua 7:

