#!/bin/bash
version="18.06
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Levine <levinegurgelf@gmail.com>"

#TODO logs recorrentes, modelo/template a partir de uma hashTag
#TODO referenciar logs entre si
#TODO sincronizar e fazer o merge do myLog de dispositivos diferentes(Android, etc)

#TODO Receber parâmetro não obrigatório para inserir o myLog de um dia específico
#TODO se o parâmetro for null, então inserir o log com a data atual
#TODO Receber por parâmetro a hora (ex: #09:34:59 AM) permitindo inserir logs diferentes da hora atual
#TODO receber id temporal por parâmetro ou a data/hora separada -y(year), -m(month), -d(day), -t(time format 000000)
#TODO por ordem de prioridade, 1º idTemporal, 2º Data-Hora
#TODO se nem o idTemporal, nem a data for informado, apenas a Hora, a data assumida será a data atual. Se a apenas o dia for informado, então o mês e ano assumidos serão os atuais, e assim por diante. 


#TODO Ordenar e Inserir ordenado cronológicamente os registros do myLog
#TODO permitir alterar o formato da hora dos registros por configuração (ex: formatTime = 1, 2, 3...)

#TODO cabeçalho com mylog, diario de bordo, segunda dia 04 de Agosto de 2014

#TODO inserir logs de 201508040000 201508040600 201508041200 201508041800

#TODO implementar versões com dialog
#TODO implementar a passagem de argumentos com texto longo --vesion, --help, --id, --tag
#TODO -f find regular expression, or id, or tags from all mylogs registerd
#TODO percorrer todas as tags, e adicionar a HashTag automaticamente
#TODO atribuir tags ao log
#TODO verificar se existe os ids Temporais das horas #Angelus

#TODO verificar se já existe um idTemporal inserido no mylog
#se não houver inserir o idTemporal no myLog

#TODO Inserir a hora cronológicamente (antes de logs posteriores e depois de logs anteriores) quando a hora for passada por parâmetro
#TODO Inserir a hora de cima para baixo
#TODO cursor na linha do idTemporal

#TODO parâmetro para visualizar apenas, não inserir idTemporal algum, apenas abrir o mylog na linha do id informado

#TODO Estudar nomes DiarioDeBordo https://pt.wikipedia.org/wiki/Di%C3%A1rio_de_bordo, https://pt.wikipedia.org/wiki/Log_de_dados

#TODO tratar idTemporal se o argumento é um dígito

defaultEditor=vim.tiny

#PrintUsage
function PrintUsage() {

log="Hello World"
tags="#MylogTag #Example"
mylog="#$timeStamp $tags $log"

#recursively creates mylog directories if there is no
if [ ! -d $dir ]; then
  mkdir -p $dir	
fi

echo $mylog >> $dir$fileName

 echo "Mylog: Simple record of personal events in chronological order using timestamp as id and # for tags"
 echo ""
 echo "Using: `basename $0` <-vh>[-ilt]"
 echo ""
 echo "Example:"
 echo "mylog -t \"$tags\" -l \"$log\"" 
 echo "check this regsiter:"
 echo \""#$timeStamp $tags Hello World!\","
 echo "record on $dir$fileName"
 exit 1
}

date=$(date +%Y/%m/%d)
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)
timeStamp=$(date +%Y%m%d%H%M%S)
time=$(date +%H%M%S)

dir=$HOME"/"Documents"/"$(date +%Y/%m/)
fileName=".$(date +%Y%m%d)000000.mylog"

 while getopts "i:l:t:hv" OPTION
 do
   case $OPTION in

	h) PrintUsage
	   ;;

	v) 
	   echo "`basename $0` Version $version."
	   exit
	   ;;

	i) timeStamp=$OPTARG

	#Extract timeStamp date, year, month and day
	date=`echo $timeStamp | cut -c1-8`
	year=`echo $timeStamp | cut -c1-4`
	month=`echo $timeStamp | cut -c5-6`
	day=`echo $timeStamp | cut -c7-8`

	#Assign directory with mylog date
	dir=$HOME"/"Documents"/"$year"/"$month"/"
	fileName=".$date000000.mylog"
	;;

	l) log=$OPTARG
	;;

	t) tags=$OPTARG
	;;

   esac
 done
shift $((OPTIND-1))

mylog="#$timeStamp $tags $log"

#recursively creates mylog directories
if [ ! -d $dir ]; then
  mkdir -p $dir	
fi

#Adds mylog to the log file
echo $mylog >> $dir$fileName

#If there is no log entry, open mylog with the default editor to edit directly in the file
if [ ! -n "$log" ]; then
  $defaultEditor "$dir$fileName"
fi