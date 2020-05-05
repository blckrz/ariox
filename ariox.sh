#!/bin/bash

#Outil requit : "namp"


cat << !
          _            _  _  _  _        _  _  _        _  _  _  _        _           _    
        _(_)_         (_)(_)(_)(_) _    (_)(_)(_)     _(_)(_)(_)(_)_     (_)_       _(_)   
      _(_) (_)_       (_)         (_)      (_)       (_)          (_)      (_)_   _(_)     
    _(_)     (_)_     (_) _  _  _ (_)      (_)       (_)          (_)        (_)_(_)       
   (_) _  _  _ (_)    (_)(_)(_)(_)         (_)       (_)          (_)         _(_)_        
   (_)(_)(_)(_)(_)    (_)   (_) _          (_)       (_)          (_)       _(_) (_)_      
   (_)         (_)    (_)      (_)_      _ (_) _     (_)_  _  _  _(_)     _(_)     (_)_    
   (_)         (_)    (_)        (_)    (_)(_)(_)      (_)(_)(_)(_)      (_)         (_) 

!
sleep 0.5
echo "   			Appuier sur [ ENTRER ] pour continuer !"
read
echo "Bienvenu $USER"
sleep 0.5
echo "choisir un nombre [1-3]"
select option in "- Envoyer un ping -" "- Test de connectivité/24h -" "- Hôte disponible sur le réseau -" 

do
echo "Vous avez choisi l'option $REPLY : $option"

jour=$(date +%F)
heure=$(date +%Hh%Mm%Ss)
date="Le "$jour" à "$heure


        if [ "$option" = "- Envoyer un ping -" ]; then
		echo "Nous allons envoyer un ping"
		sleep 0.5
		read -p 'Quelle adresse IP souhaite-tu tester ? ' ip
		if ping -i 1 -c 4 $ip
		then
			echo "Ping reçu avec succès"
			echo $date

		else
			echo "Ping non reçu"
			echo $date
		fi
		break 


	elif [ "$option" = "- Test de connectivité/24h -" ]; then
		echo "Nous allons superviser la connexion pendant 24h"
		sleep 0.5
		read -p 'Quelle adresse IP ou site internet est à tester ? ' ip

		for ((var=0; var<=48; var++))
		do
			if ping -i 1800 -c 1 $ip
		then
			echo "Ping reçu avec succès"
			echo $date
		else
			echo "Ping non reçu"
			echo $date
		fi
		done
                break


        elif [ "$option" = "- Hôte disponible sur le réseau -" ]; then
		echo "Nous allons afficher le nombre d'hôte"
		sleep 0.5
		read -p 'Saisir l adresse du réseau à scanner [ex->192.168.1.0]: ' adr
		read -p 'Saisir le masque correspondant au réseau à scanner [ex->24]: ' msk
		echo "Cela peut prendre un peu de temps..."
                nmap $adr/$msk -sP
		echo ""
		echo "Voici les hôtes disponibles :"
		arp -a
		echo $date
                break
        else
                echo "mauvaise option"
        fi
done
