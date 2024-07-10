#!/bin/bash

# Definir las opciones por defecto
reboot=false
shutdown=false
do_nothing=false

# Función para mostrar ayuda
show_help() {
  echo "Uso: $0 [-r] [-o] [-n]"
  echo "  -r  Reiniciar la PC después de actualizar"
  echo "  -o  Apagar la PC después de actualizar"
  echo "  -n  No hacer nada después de actualizar"
}

# Parsear las opciones de la línea de comandos
while getopts "ronh" opt; do
  case $opt in
    r) reboot=true ;;
    o) shutdown=true ;;
    n) do_nothing=true ;;
    h) show_help
       exit 0 ;;
    *) show_help
       exit 1 ;;
  esac
done

# Ejecutar las actualizaciones con pacman
sudo pacman -Syy --noconfirm
sudo pacman -Syu --noconfirm

# Tomar acción basada en las opciones
if $reboot; then
  echo "Reiniciando la PC..."
  sudo reboot
elif $shutdown; then
  echo "Apagando la PC..."
  sudo shutdown now
elif $do_nothing; then
  echo "No se tomará ninguna acción adicional."
else
  echo "Actualización completa. No se tomará ninguna acción adicional."
fi
