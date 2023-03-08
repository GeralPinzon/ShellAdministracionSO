function changeServerName(){
	echo -e "\n--------------------------------------------------------------------------------"            
	echo "   Nombre Server Actual                :$(hostname) "
	echo -e "\n--------------------------------------------------------------------------------"    
	read -p "Desea cambiar el nombre del servidor actual (y/n)? " answer
	if [[ $answer =~ ^[Yy]$ ]]
		then
			read -p "Digite el nuevo nombre del servidor: " var2
			sudo hostnamectl set-hostname $var2
			echo "El nombre fue cambiado exitosamente:[$(hostnamectl)]"
			echo -e "\n----- Fin del Script -----------------------------------------------------------"
		elif [[ $answer =~ ^[Nn]$ ]]
			then
				main
		else
			echo "Opcion invalida"
			changeServerName
	fi            
	read -p "Press [Enter] key to continue..." readEnterKey
}
function diskPartition(){
	echo -e "\n--------------------------------------------------------------------------------"            
	echo "   Cambiar particion de discos "
	echo -e "\n--------------------------------------------------------------------------------" 
	echo "   Información discos actuales "
	echo -e "\n--------------------------------------------------------------------------------"
	sudo fdisk -l
	echo -e "\n--------------------------------------------------------------------------------"
	read -p "Desea cambiar la partición de los discos (y/n)? " answer
		if [[ $answer =~ ^[Yy]$ ]]
			then
				read -p "Digite el nombre del disco a cambiar " nameDisk
				sudo fdisk /dev/$nameDisk
		elif [[ $answer =~ ^[Nn]$ ]]
			then
				main
		else
			echo "Opcion invalida"
		fi         
	read -p "Press [Enter] key to continue..." readEnterKey
}
function changeServerIP(){
	echo -e "\n--------------------------------------------------------------------------------"            
	echo "   Direcciones IP                :$(ip addr show) "
	echo -e "\n--------------------------------------------------------------------------------"    
	read -p "Desea cambiar la IP del servidor actual (y/n)? " answer
	if [[ $answer =~ ^[Yy]$ ]]
		then
			read -p "Digite el nombre de la red la cual desea modificar: " red
			read -p "Digite la nueva IP: " ip
			read -p "Digite la nueva mascara de red: " mask
			sudo ifconfig $red $ip netmask $mask
			echo "La IP fue modificada exitosamente"
			echo -e "\n-------------------------------------------------------------------------"   
			ip addr show
		elif [[ $answer =~ ^[Nn]$ ]]
				then
					main
		else
			echo "Opcion invalida"
	fi         
	read -p "Press [Enter] key to continue..." readEnterKey

}
function changeHostTable(){
	echo -e "\n--------------------------------------------------------------------------------"            
	echo "   Cambiar tabla de Host "
	echo -e "\n--------------------------------------------------------------------------------"    
	read -p "Desea cambiar la tabla de Host (y/n)? " answer
	if [[ $answer =~ ^[Yy]$ ]]
		then
			echo -e "\n--------------------------------------------------------------------------------"
			echo "   tabla de Host actual "
			cat /etc/hosts
			echo -e "\n--------------------------------------------------------------------------------"
			read -p "Digite la IP del host que desea agregar: " ip
			read -p "Digite el nombre del servidor: " servername
			sudo -- sh -c "echo "$ip" "$servername" >> /etc/hosts"
			echo "La tabla de host fue modificada exitosamente"
			echo -e "\n--------------------------------------------------------------------------------"
			cat /etc/hosts
			echo -e "\n----- Fin del Script -----------------------------------------------------------"   
	elif [[ $answer =~ ^[Nn]$ ]]
		then
			main
		else
			echo "Opcion invalida"
	fi         
	read -p "Press [Enter] key to continue..." readEnterKey
}
function options(){
	echo "- --------------------------------- -"        
	echo "-  Menu de administración           -"        
	echo "- --------------------------------- -"        
	echo "-  1. Cambiar nombre Servidor       -"        
	echo "- --------------------------------- -" 
	echo "-  2. Cambiar Partición Discos      -"        
	echo "- --------------------------------- -" 
	echo "-  3. Cambiar IP Servidor           -"        
	echo "- --------------------------------- -" 
	echo "-  4. Cambiar tabla de Host         -"        
	echo "- --------------------------------- -" 
	echo "-  5. Agregar Permisos de Firewall  -"        
	echo "- --------------------------------- -" 
	echo "-  6. Editar DNS Server             -"        
	echo "- --------------------------------- -" 
	echo "-  7. Configurar proxy              -"        
	echo "- --------------------------------- -" 
	echo "-  8. Instalación de Docker         -"        
	echo "- --------------------------------- -"
	echo "-  V. Volver Menu Principal         -"  
	echo "- --------------------------------- -"      
	echo "-  E. Exit                          -"        
	echo "- --------------------------------- -"
}
function firewallMain(){
	echo -e "\n--------------------------------------------------------------------------------"            
	echo "   Agregar permisos de firewall "
	echo -e "\n--------------------------------------------------------------------------------" 
	while :
		do
			clear          
			unset choiceFirewall
			echo "- --------------------------------- -"        
			echo "-  Menu Firewall                    -"        
			echo "- --------------------------------- -"        
			echo "-  1. Habilitar servicio            -"        
			echo "- --------------------------------- -" 
			echo "-  2. Ver estado Firewall	          -"        
			echo "- --------------------------------- -" 
			echo "-  3. Habilitar puerto TCPs         -"        
			echo "- --------------------------------- -" 
			echo "-  4. Habilitar puerto UDP          -"        
			echo "- --------------------------------- -" 
			echo "-  5. Habilitar rango puerto TCP    -"        
			echo "- --------------------------------- -" 
			echo "-  6. Habilitar rango puerto UDP    -"        
			echo "- --------------------------------- -" 
			echo "-  V. Volver Menu Principal         -"               
			echo "- --------------------------------- -"
			read -p "Digite la opccion " choiceFirewall
			case $choiceFirewall in
				1)
					echo -e "\n--------------------------------------------------------------------------------"            
					echo "   Habilitar servicio de firewall "
					echo -e "\n--------------------------------------------------------------------------------"    
					read -p "Desea habilitar el servicio de firewall (y/n)? " answer
					if [[ $answer =~ ^[Yy]$ ]]
						then
							sudo ufw enable
							echo "Servicio de firewall habilitado "
					elif [[ $answer =~ ^[Nn]$ ]]
						then
							firewallMain
					else
						echo "Opcion invalida"
					fi         
					read -p "Press [Enter] key to continue..." readEnterKey
					;;
				2)
					echo -e "\n--------------------------------------------------------------------------------"            
					echo "   Estado Firewal "
					echo -e "\n--------------------------------------------------------------------------------"    
					sudo ufw status
					read -p "Press [Enter] key to continue..." readEnterKey
					;;
				3)
					echo -e "\n--------------------------------------------------------------------------------"            
					echo "   Habilitar puerto TCP "
					echo -e "\n--------------------------------------------------------------------------------"    
					read -p "Desea habilitar un puerto TCP (y/n)? " answer
					if [[ $answer =~ ^[Yy]$ ]]
						then
							read -p "Ingrese el puerto que desea habilitar: " port
							sudo ufw allow $port/tcp
							echo "Puerto $port/TCP habilitado "
					elif [[ $answer =~ ^[Nn]$ ]]
						then
							firewallMain
					else
						echo "Opcion invalida"
					fi         
					read -p "Press [Enter] key to continue..." readEnterKey
					;;
				4)
					echo -e "\n--------------------------------------------------------------------------------"            
					echo "   Habilitar puerto UDP "
					echo -e "\n--------------------------------------------------------------------------------"            
					read -p "Desea habilitar un puerto UDP (y/n)? " answer
					if [[ $answer =~ ^[Yy]$ ]]
						then
							read -p "Ingrese el puerto que desea habilitar: " port
							sudo ufw allow $port/udp
							echo "Puerto $port/UDP habilitado "
					elif [[ $answer =~ ^[Nn]$ ]]
						then
							firewallMain
					else
						echo "Opcion invalida"
					fi         
					read -p "Press [Enter] key to continue..." readEnterKey
					;;
				5)
					echo -e "\n--------------------------------------------------------------------------------"            
					echo "   Habilitar rango puerto TCP "
					echo -e "\n--------------------------------------------------------------------------------"            
					read -p "Desea habilitar rango de puertos TCP (y/n)? " answer
					if [[ $answer =~ ^[Yy]$ ]]
						then
							read -p "Ingrese el rango de puertos que desea habilitar: (puerto:puerto)" port
							sudo ufw allow $port/tcp
							echo "Puerto $port/TCP habilitado "
					elif [[ $answer =~ ^[Nn]$ ]]
						then
							firewallMain
					else
						echo "Opcion invalida"
					fi         
					read -p "Press [Enter] key to continue..." readEnterKey
					;;
				6)
					echo -e "\n--------------------------------------------------------------------------------"            
					echo "   Habilitar rango puerto UDP "
					echo -e "\n--------------------------------------------------------------------------------"            
					read -p "Desea habilitar rango de puertos UDP (y/n)? " answer
					if [[ $answer =~ ^[Yy]$ ]]
						then
							read -p "Ingrese el rango de puertos que desea habilitar: (puerto:puerto)" port
							sudo ufw allow $port/udp
							echo "Puerto $port/UDP habilitado "
					elif [[ $answer =~ ^[Nn]$ ]]
						then
							firewallMain
					else
						echo "Opcion invalida"
					fi         
					read -p "Press [Enter] key to continue..." readEnterKey
					;;
				V)
					main
				;;

				*)
					echo "Error: Invalid option..."                
					read -p "Press [Enter] key to continue..." 
					readEnterKey
				;;

		esac
	done
}
function addDNSServer(){
	echo -e "\n--------------------------------------------------------------------------------"            
	echo "   Editar DNS Server "
	echo -e "\n--------------------------------------------------------------------------------"
	echo "   Informacion actual de DNS"
	cat /etc/resolv.conf
	echo -e "\n--------------------------------------------------------------------------------"
	read -p "Desea agregar un nuevo DNS (y/n)? " answer
			if [[ $answer =~ ^[Yy]$ ]]
				then
					read -p "Ingrese la IP del servidor DNS: " ip
					sudo -- sh -c "echo nameserver "$ip" >> /etc/resolv.conf"
					echo "DNS agregado exitosamente"
					echo -e "\n--------------------------------------------------------------------------------"
					cat /etc/resolv.conf
			elif [[ $answer =~ ^[Nn]$ ]]
				then
					main
			else
				echo "Opcion invalida"
			fi         
	read -p "Press [Enter] key to continue..." readEnterKey
}
function configureProxy(){
	echo -e "\n--------------------------------------------------------------------------------"            
	echo "   Configurar proxy "
	echo -e "\n--------------------------------------------------------------------------------"
	echo '   PROXY_ENABLED="yes"'
	echo '   HTTP_PROXY="IP:Puerto"'
	echo '   HTTPS_PROXY="IP:Puerto"'
	echo '   FTP_PROXY="IP:Puerto"'
	echo '   NO_PROXY="localhost,IP,"'
	echo -e "\n--------------------------------------------------------------------------------"
	read -p "Desea editar configuracion del proxy (y/n)? " answer
		if [[ $answer =~ ^[Yy]$ ]]
			then
				cd
				sudo -- sh -c "echo ##PROXY>> .bashrc"
				sudo -- sh -c 'echo PROXY_ENABLED="yes" >> .bashrc'
				read -p "Ingrese el HTTP_PROXY: (IP:Puerto) " httpProxy
				sudo -- sh -c "echo HTTP_PROXY="$httpProxy" >> .bashrc"
				read -p "Ingrese el HTTPS_PROXY: (IP:Puerto) " httpsProxy
				sudo -- sh -c "echo HTTPS_PROXY="$httpsProxy" >> .bashrc"
				read -p "Ingrese el FTP_PROXY: (IP:Puerto) " ftpProxy
				sudo -- sh -c "echo FTP_PROXY="$ftpProxy" >> .bashrc"
				read -p "Ingrese el NO_PROXY: (localhost, IP): " noProxy
				sudo -- sh -c "echo NO_PROXY="$noProxy" >> .bashrc"
				echo "Proxy modificado exitosamente"
				echo -e "\n--------------------------------------------------------------------------------"
				cat .bashrc
				echo -e "\n--------------------------------------------------------------------------------"
		elif [[ $answer =~ ^[Nn]$ ]]
			then
				main
		else
			echo "Opcion invalida"
		fi         
	read -p "Press [Enter] key to continue..." readEnterKey
}

function installDocker(){
	# Ejecucion            
	echo "-----------------------------------------------------------------------------"
	echo "Inicia instalacion docker CE                                                 " 
	echo "-----------------------------------------------------------------------------"   
	read -p ">> Paso 1: Desea Instalar Docker (y/n)? " answer
	if [[ $answer =~ ^[Yy]$ ]]
		then                    
			cd ~/
			echo "-----------------------------------------------------------------------------"
			echo "Instalación Prerequisitios"                    
			echo "-----------------------------------------------------------------------------"                    
			sudo apt-get update -y                    
			sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
			sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
			sudo apt update -y                    
			apt-cache policy docker-ce -y                    
			sudo apt install docker-ce -y

			echo "-----------------------------------------------------------------------------"                    
			echo "Verificar Version"                    
			echo "-----------------------------------------------------------------------------"                    
			docker --version

			echo "-----------------------------------------------------------------------------"                    
			echo "Iniciar docker con el sistema"                    
			echo "-----------------------------------------------------------------------------"                    
			sudo systemctl enable docker
			sudo systemctl start docker

			echo "-----------------------------------------------------------------------------"                    
			echo "Crear usuario de Docker"                    
			echo "-----------------------------------------------------------------------------"
			sudo adduser docker

			echo "-----------------------------------------------------------------------------"                    
			echo "Agregar permisos usuario ubunutu al grupo Docker"                    
			echo "-----------------------------------------------------------------------------"                    
			user=$(whoami)                    
			sudo usermod -G docker $user                    
			grep $user /etc/group

			echo "-----------------------------------------------------------------------------"                    
			echo "folder docker"                    
			echo "-----------------------------------------------------------------------------"                    
			folder=/Images
			sudo mkdir -p $folder/$user                    
			sudo mkdir -p $folder/$user/Data
			sudo chown -R $user:$user $folder/$user                    
			sudo chown -R $user:$user $folder/$user/Data
			ls -ltr $folder/
			read -p "Press [Enter] key to continue..." readEnterKey
			echo "-----------------------------------------------------------------------------"                   
			echo "Inicia instalacion Docker Compose                                            "                    
			echo "-----------------------------------------------------------------------------"                    
			sudo mkdir -p /usr/local/bin
			sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
			sudo chmod +x /usr/local/bin/docker-compose

			echo "-----------------------------------------------------------------------------"                    
			echo "Verificar docker-compose"                    
			echo "-----------------------------------------------------------------------------"                    
			sudo docker-compose --version
			read -p "Press [Enter] key to continue..." readEnterKey

			echo "-----------------------------------------------------------------------------"                    
			echo "Fin instalacion Docker                                                       "                    
			echo "-----------------------------------------------------------------------------" 

			read -p "Press [Enter] key to continue..." readEnterKey
		fi      
		echo "-----------------------------------------------------------------------------"            
		echo "Sin Ajustes!!"            
		echo "-----------------------------------------------------------------------------"
		echo ---------- Fin del Script ----------------------------           	
		read -p "Press [Enter] key to continue..." readEnterKey

}


function main(){
	while :
	do           
	clear    # Limpiar pantalla       
	unset choice # Limpieaza de variables 
    options        
	read -p "Digite la opccion " choice
    case $choice in
		1)
            changeServerName
            ;;
        2)  
			diskPartition
			;;	
		3)  
            changeServerIP
            ;;  
		4)  
			changeHostTable
			;;
			
		5)  
            firewallMain
            ;;
		6)  
			addDNSServer
			;;
		7)  
            configureProxy
			;;
		8)  

			installDocker
			;;
		E)  
            exit
			;;
		V)  
            main
			;;
        *)
			echo "Error: Invalid option..."                
			read -p "Press [Enter] key to continue..." 
			readEnterKey
		;;
        esac
	done		
}
main