#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n${red}[!] Saliendo ...${end}"
  tput cnorm; exit 1
}

trap ctrl_c INT

function helpPanel(){
  echo -e "\n${yellow}[i] ${end}${gray} Uso:${end}\n"
  echo -e "\t${purple}-f${end}${gray} Indicar archivo a buscar${end}"
  echo -e "\t${purple}-t${end}${gray} Indicar tipo de archivo ${end}${blue}(Opciones disponibles: b, c, d, p, f, l, s, D)${end}"
  echo -e "\t${purple}-p${end}${gray} Indicar path donde buscar${end}"
  echo
}


function find_file(){

  filename=$1
  type=$2
  path=$3
  validate=$(cat output.tmp)
  
  tput civis
  if [ $type == "b" ]; then
    
    echo -e "\n${yellow}[+]${purple}${gray} Buscando el archivo ${end}${purple}$filename${end}${gray} de tipo ${end}${purple}bloque${end}${gray} en ${end}${purple}$path${end}\n"
    sleep 1

    find $path \-type $type -name $filename 2>/dev/null | tee output.tmp

    echo -e "\n${green}[+]${end} ${purple}$(cat output.tmp | wc -l)${end}${gray} archivos encontrados${end}"
    rm output.tmp
  elif [ $type == "c" ]; then

    echo -e "\n${yellow}[+]${purple}${gray} Buscando el archivo ${end}${purple}$filename${end}${gray} de tipo ${end}${purple}carácter especial${end}${gray} en ${end}${purple}$path${end}\n"
    sleep 1

    find $path \-type $type -name $filename 2>/dev/null | tee output.tmp

    echo -e "\n${green}[+]${end} ${purple}$(cat output.tmp | wc -l)${end}${gray} archivos encontrados${end}"
    rm output.tmp

  elif [ $type == "d" ]; then

    echo -e "\n${yellow}[+]${purple}${gray} Buscando el archivo ${end}${purple}$filename${end}${gray} de tipo ${end}${purple}directory${end}${gray} en ${end}${purple}$path${end}\n"
    sleep 1

    find $path \-type $type -name $filename 2>/dev/null | tee output.tmp

    echo -e "\n${green}[+]${end} ${purple}$(cat output.tmp | wc -l)${end}${gray} archivos encontrados${end}"
    rm output.tmp


  elif [ $type == "p" ]; then
    
    echo -e "\n${yellow}[+]${purple}${gray} Buscando el archivo ${end}${purple}$filename${end}${gray} de tipo ${end}${purple}tuberia con nombre${end}${gray} en ${end}${purple}$path${end}\n"
    sleep 1

    find $path \-type $type -name $filename 2>/dev/null | tee output.tmp

    echo -e "\n${green}[+]${end} ${purple}$(cat output.tmp | wc -l)${end}${gray} archivos encontrados${end}"
    rm output.tmp

  elif [ $type == "f" ]; then

    echo -e "\n${yellow}[+]${purple}${gray} Buscando el archivo ${end}${purple}$filename${end}${gray} de tipo ${end}${purple}archivo regular${end}${gray} en ${end}${purple}$path${end}\n"
    sleep 1

    find $path \-type $type -name $filename 2>/dev/null | tee output.tmp

    echo -e "\n${green}[+]${end} ${purple}$(cat output.tmp | wc -l)${end}${gray} archivos encontrados${end}"
    rm output.tmp

  elif [ $type == "l" ]; then

    echo -e "\n${yellow}[+]${purple}${gray} Buscando el archivo ${end}${purple}$filename${end}${gray} de tipo ${end}${purple}enlace simbólico${end}${gray} en ${end}${purple}$path${end}\n"
    sleep 1

    find $path \-type $type -name $filename 2>/dev/null | tee output.tmp

    echo -e "\n${green}[+]${end} ${purple}$(cat output.tmp | wc -l)${end}${gray} archivos encontrados${end}"
    rm output.tmp

  elif [ $type == "s" ]; then

    echo -e "\n${yellow}[+]${purple}${gray} Buscando el archivo ${end}${purple}$filename${end}${gray} de tipo ${end}${purple}socket${end}${gray} en ${end}${purple}$path${end}\n"
    sleep 1

    find $path \-type $type -name $filename 2>/dev/null | tee output.tmp

    echo -e "\n${green}[+]${end} ${purple}$(cat output.tmp | wc -l)${end}${gray} archivos encontrados${end}"
    rm output.tmp

  elif [ $type == "D" ]; then

    echo -e "\n${yellow}[+]${purple}${gray} Buscando el archivo ${end}${purple}$filename${end}${gray} de tipo ${end}${purple}door${end}${gray} en ${end}${purple}$path${end}\n"
    sleep 1

    find $path \-type $type -name $filename 2>/dev/null | tee output.tmp

    echo -e "\n${green}[+]${end} ${purple}$(cat output.tmp | wc -l)${end}${gray} archivos encontrados${end}"
    rm output.tmp

  else

    echo -e "\n${red}[!] Introduce un tipo de archivo disponible: b, c, d, p, f, l, s, D${end}"
    helpPanel
  fi
  tput cnorm

}


declare -i parameter_counter=0

while getopts "hf:t:p:" arg; do
  
  case $arg in
    h) ;;
    f) filename="$OPTARG"; let parameter_counter=1;; 
    t) type="$OPTARG"; let parameter_counter=1;;
    p) path="$OPTARG"; let parameter_counter=1;;
  esac
done

if [ $parameter_counter -eq 0 ]; then

  helpPanel
elif [ $parameter_counter -eq 1 ]; then
  touch output.tmp
  find_file "$filename" "$type" "$path"
else
  helpPanel
fi
