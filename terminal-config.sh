#!/bin/bash

#Colores
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
morado="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
gris="\e[0;37m\033[1m"
fin="\033[0m\e[0m"

#Variables
USUARIO=${SUDO_USER:-$USER}
DIRNAME="$( dirname "$( readlink -f "$0" )" )"
TEMAS=$DIRNAME/themes.txt

#Interaccion con el Usuario
echo -e "Hola necesito saber que sistema operativo usas"
sleep 1
echo -e " "
echo -e " "
echo -e "~${amarillo}Esta basado en Debian o en Arch ->${fin} ${turquesa}( debian / arch )${fin}"
read SISTEMA
echo -e " "
echo -e " "
sleep 1
echo -e "${amarillo}Vamos a proceder a configurar Kitty para ello necesito el nombre del tema que deseas usar.${fin}"
sleep 2
echo -e " "
echo -e " "
echo -e "${amarillo}¿Deseas ver el listado de temas? -> ${fin}${turquesa}(y/n)${fin}"
read RESPUESTA
if [[ $RESPUESTA == "y" ]]; then
    clear
    cat $TEMAS
elif [[ $RESPUESTA == "n" ]]; then
    clear
fi

echo -e "${amarillo}Escribe el nombre exacto del tema que deseas configurar en kitty ejemplo ->${fin} ${turquesa}AdventureTime.conf${fin}"
read TEMA

#Actualizar repositorios e instalar kitty y fish 
if [[ $SISTEMA == "y" ]]; then
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y git neovim xclip xsel kitty fish python3-pip
elif [[ $SISTEMA == "n" ]]; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S git neovim xclip xsel kitty fish python-pip --noconfirm
fi

#Establecer fish como shell predeterminada
chsh -s /usr/bin/fish

#Eliminar saludo de fish
echo -e "set -g -x fish_greeting ' '" >> /home/$USUARIO/.config/fish/config.fish

#Configurar neovim
sudo python3 -m pip install neovim
sudo python3 -m pip install --upgrade neovim
mkdir /home/$USUARIO/.config/nvim
echo -e "set title" >> /home/$USUARIO/.config/nvim/init.vim
echo -e "set nu" >> /home/$USUARIO/.config/nvim/init.vim

#Descargar repositorio de kitty-themes
git clone --depth 1 https://github.com/dexpota/kitty-themes.git /home/$USUARIO/.config/kitty/kitty-themes

#Enlace simbolico al teme del reposiotrio
ln -s /home/$USUARIO/.config/kitty/kitty-themes/themes/$TEMA /home/$USUARIO/.config/kitty/theme.conf

#Añadir linia al archivo de configuracion de kitty
echo -e "include ./theme.conf" >> /home/$USUARIO/.config/kitty/kitty.conf

#Mensaje final
echo -e "${verde} Instalacion finalizada ${fin}"
exit
