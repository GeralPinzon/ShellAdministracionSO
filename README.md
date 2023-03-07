# Taller Docker 1


***Configuración de herramientas de desarrollo***

- Crear cuenta en Github

  Se debe crear una nueva cuenta en GitHub, ingresa al siguiente enlace https://github.com/join y llena los datos correspondientes.
  
  <p align="center">
  <img src="imagenesTallerDocker/crearCuentaGitHub.png" width="400" height="200" title="Página para la creación de usuario en GitHub">
  </p>

  
- Crear cuenta en Dockerhub

  Se debe crear una nueva cuenta en Docker, ingresa al siguiente sitio https://hub.docker.com/signup y llena los datos correspondientes.
  
  <p align="center">
  <img src="imagenesTallerDocker/crearCuentaDocker.png" width="400" height="250" title="Página para la creación de usuario en dockerhub">
  </p>
  
- Creación de repositorio
  
  Para crear un repositorio nuevo se debe ingresar a la cuenta creada anteriormente en GitHub, donde debera dar clic en el cuadro rojo que indica al boton NEW
  
  <p align="center">
  <img src="imagenesTallerDocker/crearRepositorio.png" width="500" height="150" title="Página para la creación de usuario GitHub">
  </p>
  
  Luego podrá ver la siguiente pantalla, donde debera colocar el nombre del repositorio, indicar si es publico o privado y llenar demas datos.
  
  <p align="center">
  <img src="imagenesTallerDocker/crearRepositorioPaso2.png" width="500" height="200" >
  </p>

- Configuración de llaves SSH

  Primero debemos ubicarnos en el servidor que se esta trabajando, para generar las llaves SSH se debe ejecutar el comando ssh-keygen, despues de ejecutar este comando   se debe copiar la llave que se genero en la sigueinte ruta /home/ubuntu/.ssh/id_rsa.pub el archivo id_rsa.pub.
  
  
# Taller Docker 2

- Agregar modulo de instalación de Docker en menú de administración para instalación y pruebas unitarias.
  
  Para este punto se uso el mismo script de administración que se estaba construyendo, donde se le agregó la opción 8 para mostrar la opción de instalación de Docker.

```bash
 "- --------------------------------- -"        
 "-  Menu de administración           -"        
 "- --------------------------------- -"        
 "-  1. Cambiar nombre Servidor       -"        
 "- --------------------------------- -" 
 "-  2. Cambiar Partición Discos      -"        
 "- --------------------------------- -" 
 "-  3. Cambiar IP Servidor           -"        
 "- --------------------------------- -" 
 "-  4. Cambiar tabla de Host         -"        
 "- --------------------------------- -" 
 "-  5. Agregar Permisos de Firewall  -"        
 "- --------------------------------- -" 
 "-  6. Editar DNS Server             -"        
 "- --------------------------------- -" 
 "-  7. Configurar proxy              -"        
 "- --------------------------------- -" 
 "-  8. Instalación de Docker         -"        
 "- --------------------------------- -"
 "-  V. Volver Menu Principal         -"  
 "- --------------------------------- -"      
 "-  E. Exit                          -"        
 "- --------------------------------- -"
```

código del módulo para la instalación y pruebas de Docker

```bash
"-----------------------------------------------------------------------------"
"Inicia instalacion docker CE                                                " 
"-----------------------------------------------------------------------------"   
read -p">> Paso 1: Desea Instalar Docker (y/n)?" answer
if [[ $answer =~ ^[Yy]$ ]]
then                    
  cd ~/
  "-----------------------------------------------------------------------------"
  "Instalación Prerequisitios"                    
  "-----------------------------------------------------------------------------"                    
  sudo apt-get update -y                    
  sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
  sudo add-apt-repository"deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
  sudo apt update -y                    
  apt-cache policy docker-ce -y                    
  sudo apt install docker-ce -y

  "-----------------------------------------------------------------------------"                    
  "Verificar Version"                    
  "-----------------------------------------------------------------------------"                    
  docker --version

  "-----------------------------------------------------------------------------"                    
  "Iniciar docker con el sistema"                    
  "-----------------------------------------------------------------------------"                    
  sudo systemctl enable docker
  sudo systemctl start docker

  "-----------------------------------------------------------------------------"                    
  "Crear usuario de Docker"                    
  "-----------------------------------------------------------------------------"
  sudo adduser docker

  "-----------------------------------------------------------------------------"                    
  "Agregar permisos usuario ubunutu al grupo Docker"                    
  "-----------------------------------------------------------------------------"                    
  user=$(whoami)                    
  sudo usermod -G docker $user                    
  grep $user /etc/group

  "-----------------------------------------------------------------------------"                    
  "folder docker"                    
  "-----------------------------------------------------------------------------"                    
  folder=/Images
  sudo mkdir -p $folder/$user                    
  sudo mkdir -p $folder/$user/Data
  sudo chown -R $user:$user $folder/$user                    
  sudo chown -R $user:$user $folder/$user/Data
  ls -ltr $folder/
  read -p"Press [Enter] key to continue..." readEnterKey
  "-----------------------------------------------------------------------------"                   
  "Inicia instalacion Docker Compose                                           "                    
  "-----------------------------------------------------------------------------"                    
  sudo mkdir -p /usr/local/bin
  sudo curl -L"https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  "-----------------------------------------------------------------------------"                    
  "Verificar docker-compose"                    
  "-----------------------------------------------------------------------------"                    
  sudo docker-compose --version
  read -p"Press [Enter] key to continue..." readEnterKey

  "-----------------------------------------------------------------------------"                    
  "Fin instalacion Docker                                                      "                    
  "-----------------------------------------------------------------------------" 

  read -p"Press [Enter] key to continue..." readEnterKey
fi      
"-----------------------------------------------------------------------------"            
"Sin Ajustes!!"            
"-----------------------------------------------------------------------------"
 ---------- Fin del Script ----------------------------           	
read -p"Press [Enter] key to continue..." readEnterKey
```

- Clonar repositorio
  
  Para clonar el repositorio se debe ubicar dentro del repositorio, y elegir la opción de la parte superior derecha dar clic en code -> SSH -> y copiar el enlace. 

   <p align="center">
    <img src="imagenesTallerDocker/Taller2_ClonarRepositorio.png" width="500" height="300" >
   </p>

    Con el enlace copiado debemos ir a la maquina para ejecutar el comando que permitirá clonar el repositorio, como se muestra en la imagen:

   <p align="center">
    <img src="imagenesTallerDocker/Taller2_ClonarRepositorio_2.png" width="600" height="220" >
   </p>

    Finalmente se realiza la configuración de las variables globales:

   <p align="center">
    <img src="imagenesTallerDocker/Taller2_ClonarRepositorio_3.png" width="600" height="80" >
   </p>
 

- Instalar Shell en servidor de AWS

  Para instalar el Shell en el servidor AWS, nos ubicamos en la carpeta del repositorio que se clono anteriormente, luego debemos ubicarnos en la rama que se creo para el taller 2 -> adminDocker-sh. 
  
  <p align="center">
    <img src="imagenesTallerDocker/Taller2_instalarShell.png" width="600" height="220" >
  </p>
  
  Finalmente, subimos el script que se desarrollo por medio de mobaxterm en la carpeta del repositorio que se clono anteriormente. 
  <p align="center">
    <img src="imagenesTallerDocker/Taller2_instalarShell_2.png" width="600" height="300" >
  </p>

- Subir cambios a repositorio
  
  Despues de haber instalado la shell, se procedera a subir los cambios, para esto se ejecutan los siguientes comandos:
  
  <p align="center">
    <img src="imagenesTallerDocker/Taller2_SubirCambios.png" width="600" height="350" >
  </p>
  
  Si revisamos el repositorio debe visualizarse el nuevo archivo script.sh, como se visualiza en la siguiente imagen:
  
  <p align="center">
    <img src="imagenesTallerDocker/Taller2_SubirCambios_Repositorio.png" width="600" height="350" >
  </p>  


- Pruebas (docker –versión y Docker-compose --version)
  
  Para iniciar las pruebas, primero se debe de dar permisos al script desde el servidor AWS, por medio del siguiente comando:
  
  <p align="center">
    <img src="imagenesTallerDocker/Taller2_Pruebas.png" width="500" height="120" >
  </p>  
  
  Luego se podrá ejecutar el script con el comando ./script.sh, esto nos permitirá ver el menu que se mostrara a continuación, el cual contiene la opción 8 Instalación Docker, al elegir esta opción se le pedira al usuario afirmar si desea instalar docker
  
  <p align="center">
    <img src="imagenesTallerDocker/Taller2_Pruebas_2.png" width="500" height="300" >
  </p>  
  
  Al confirmar la acción, se empieza a evidenciar en pantalla el paso a paso de la instalación, y también se podrá visualizar la versión de Docker como se muestra en la siguiente imagen:
  
  <p align="center">
    <img src="imagenesTallerDocker/Taller2_Pruebas_InstalacionPrerequisitos.png" width="500" height="600" >
  </p>  
  
  Finalmente, se visualizará la instalación de Docker Compose:
  
  <p align="center">
    <img src="imagenesTallerDocker/Taller2_Pruebas_InstalacionDockerCompose.png" width="500" height="250" >
  </p> 
  
  
  
  
  
  
  




