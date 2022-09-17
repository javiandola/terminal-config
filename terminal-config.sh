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

echo -e "${amarillo}Escribe el nombre exacto del tema que deseas configurar en kitty ejemplo ->${fin} ${turquesa}AdventureTime.conf${fin}"
read TEMA

#Actualizar repositorios e instalar kitty y fish 
sudo apt update
sudo apt upgrade -y
sudo apt install -y git neovim xclip xsel kitty fish python3-pip

#Establecer fish como shell predeterminada
chsh -s /usr/bin/fish

#Eliminar saludo de fish
echo -e "set -g -x fish_greeting ' '" >> /home/$USUARIO/.config/fish/config.fish

#Configurar neovim
sudo python3 -m pip install neovim
sudo python3 -m pip install --upgrade neovim
mkdir /home/$USUARIO/.config/nvim
touch /home/$USUARIO/.config/nvim/init.vim
echo -e "set title" >> /home/$USUARIO/.config/nvim/init.vim
echo -e "set nu" >> /home/$USUARIO/.config/nvim/init.vim

#Descargar repositorio de kitty-themes
git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes

#Enlace simbolico al teme del reposiotrio
ln -s /home/$USUARIO/.config/kitty/kitty-themes/themes/$TEMA /home/$USUARIO/.config/kitty/theme.conf

#Añadir linia al archivo de configuracion de kitty
echo -e "include ./theme.conf" >> /home/$USUARIO/.config/kitty/kitty.conf

#Mensaje final
echo -e "${verde} Instalacion finalizada ${fin}"
exit
