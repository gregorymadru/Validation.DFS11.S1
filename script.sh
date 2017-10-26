#!/usr/bin/env bash
clear



#Start
#--------------------------------------------------------------------------------------------------------------------
echo "============Installation et configuration de virtualbox et vagrant============"
echo "\nEntrée pour commencer"
read wait

#Début du script
#-------------------------------------------------------------------------------------------------------------------
echo "Verifications :"
echo "\nVirtualbox est-il installé ?"
 
	dpkg -l | grep virtualbox-5.0 > /dev/null




if [ $? = 1 ] 
	then 
	echo "\n=>  Non, Installation...."
	sudo apt-get install virtualbox-5.0 -y -qq > /dev/null
	else 
	echo "\n=>  Oui, Déja installé"
fi






sleep 2
echo "\n \nVagrant est-il installé ?"

	dpkg -l | grep vagrant > /dev/null




if [ $? = 1 ]
	then 
	echo "\n=>  Non, Installation ...."

	sudo wget https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb
	sudo dpkg -i vagrant_2.0.0_x86_64.deb	> /dev/null
	else
	echo "\n=>  Oui, Déja installé"
fi


# Configuration basique de Vagrant
#--------------------------------------------------------------------------------------------------------------------
sleep 5
clear
echo "Avez-vous déja configuré Vagrant préalablement ? (O/N)"
read answer
if [ "$answer" = "N" ]

	then
		echo "Pour Vagrant, choisir le chemin du répertoire vagrant ($PWD) :"
		read file
		    if [ -z "$file" ]
	    	then
	    	    file="data"
	    fi
		mkdir vagrant
		sleep 2
			cd vagrant/
	
		sudo vagrant init



		sed -i 's/# config.vm.network/config.vm.network/g' Vagrantfile
		sed -i 's/# config.vm.synced_folder/config.vm.synced_folder/g' Vagrantfile
	
	
	
#Configuration propre à l'utilisateur de Vagrant
#--------------------------------------------------------------------------------------------------------------------
		echo '\n'
		echo '\n'
		echo '\n'
		echo 'Comment voulez vous nommer votre fichier local synchronisé avec la machine hôte ? (data)'
		    read file
	
		    if [ -z "$file" ]
		    then
			        file="data"
		    fi

		    mkdir $file
		    sed -i "s|../data|$file|" Vagrantfile
		    echo 'Quel chemin de sync folder voulez vous utiliser ? (default:/var/www/html)'
		    read file

		    if [ -z "$file" ]
		    then	
			        file="/var/www/html"
			    fi
			    sed -i "s|/vagrant_data|$file|" Vagrantfile
	
			    echo "==> Configuration du Vagrantfile terminée avec succès !"

#Interface d'utilisation de Vagrant
#-------------------------------------------------------------------------------------------------------------------
	else
	sleep 1

fi
var=""
		while [ "$var" != '1' ]		
		do
		echo    "1. Lister les Machines en fonctionnement"
		echo    "2. Créer une Machine"
		echo    "3. Supprimer une machine"
		echo    "4. Démarrer la machine"
		echo    "5. Connexion a la machine"
		echo    "6. Terminer le script "

		read newSelection

		      case $newSelection in
		1)
		  vagrant status
		    ;;
		2)
		    echo "Quel Machine voulez-vous créer ?"
		    echo "1-xenial"
		    echo "1-xenial"
	            echo "1-xenial"
	            read var
		    sed -i 's/base/xenial.box/g' Vagrantfile
	            echo "Veiller à bien mettre xenial.box dans le répertoir $PWD avant de démarrer la machine"
		     ;;
		3)
		    echo "quel est le nom de la machine à supprimer ?"
		    read varmv
		    sudo vagrant halt 
		    sudo vagrant box remove $varmv
		     ;;
		4)
		    sudo vagrant up
		     ;;
		5)
		    sudo vagrant ssh
		     ;;
		6)
			var="1"
		     ;;
		esac
		done

clear

