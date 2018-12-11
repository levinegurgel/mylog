#!/bin/bash

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
#TODO percorrer todas as tags, e adicionar a HashTag automáticamente
#TODO atribuir tags ao log
#TODO verificar se existe os ids Temporais das horas #Angelus

#TODO verificar se já existe um idTemporal inserido no mylog
#se não houver inserir o idTemporal no myLog

#TODO Inserir a hora cronológicamente (antes de logs posteriores e depois de logs anteriores) quando a hora for passada por parâmetro
#TODO Inserir a hora de cima para baixo
#TODO cursor na linha do idTemporal

#TODO parâmetro para visualizar apenas, não inserir idTemporal algum, apenas abrir o mylog na linha do id informado

#TODO Estudar nomes DiarioDeBordo https://pt.wikipedia.org/wiki/Di%C3%A1rio_de_bordo, https://pt.wikipedia.org/wiki/Log_de_dados

versao="17.02
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Levine <contato@levine.eti.br>"

data=$(date +%Y/%m/%d)

#PrintUsage
function PrintUsage() {
 echo "Mylog: Registro de eventos relevantes"
 echo "Uso: `basename $0` <-vh>[-ilt]"
 exit 1
}

 while getopts "i:l:t:hv" OPTION
 do
   case $OPTION in

	h) PrintUsage
	   ;;

	v) 
	   echo "`basename $0` Versão $versao."
	   exit
	   ;;

	#TODO tratar idTemporal se o argumento é um dígito
	i) idTemporal=$OPTARG

	#extrai o ano, mês e dia do idTemporal
	ano=`echo $idTemporal | cut -c1-4`
	mes=`echo $idTemporal | cut -c5-6`
	dia=`echo $idTemporal | cut -c7-8`

	#atribui a data com as variáveis, ano, mes e dia
	data="$ano/$mes/$dia"

	#atribui o nome do arquivo com a data do idTemporal
	nomeArquivo=$ano$mes$dia"000000.mylog"
	;;

	l) log=$OPTARG
	;;

	t) tags=$OPTARG
	;;
		
	?)PrintUsage
	;;	
   esac
 done
shift $((OPTIND-1))

#Se o idTemporal não estiver informado
#então atribuir o idTemporal do instante atual
# atribuir o nome do arquivo com a data atual
if [ ! -n "$idTemporal" ]; then
 idTemporal=$(date +%Y%m%d%H%M%S)
 nomeArquivo=$(date +%Y%m%d)000000.mylog
 data=$(date +%Y/%m/%d)
fi

mylog="#$idTemporal"

echo $tags

#se houver opções com argumentos de tags atribuir ao mylog
if [ -n "$tags" ]; then
  mylog="$mylog, $tags"
fi

#se houver opções com argumentos de log atribuir ao mylog
if [ -n "$log" ]; then
 mylog="$mylog, $log"
fi

#Atribui o diretório com a data do mylog
#dir="$HOME/Documentos/$data/"
 dir="$HOME/Desktop/Tempo/$data/"

#cria recursivamente os diretórios do mylog caso não exista
if [ ! -d $dir ]; then
  mkdir -p $dir	

#se não houver, inserir
#  echo "#000000" >> "$dir.mylog"
#  echo "#060000" >> "$dir.mylog"
#  echo "#120000" >> "$dir.mylog"
#  echo "#180000" >> "$dir.mylog"
fi

echo $mylog >> $dir$nomeArquivo

#Abre o mylog de hoje com o editor default
defaultEditor=vim.tiny
$defaultEditor "$dir$nomeArquivo"

