#!/bin/bash
version="19.07
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Levine <levinegurgelf@gmail.com>"

defaultEditor=vim.tiny

#PrintUsage
function PrintUsage() {

setTimeStamp
setLog "#Mylog #Example Hello World"
setDir

echo "" >> $dir$fileName
echo "#$timeStamp $hashTag" >> $dir$fileName
echo $log >> $dir$fileName

 echo "Mylog: Simple record of personal events in chronological order using timestamp as id and # for hashTag"
 echo ""
 echo "Using: `basename $0` <-vh>[-tls]"
 echo "-t timestamp (optional, ex: 20190712121500. The current timestamp is set when null)"
 echo "-l log (optional, the default editor is opened when null)"
 echo ""
 echo "Example:"
 echo "mylog -l \"$hashTag $log\"" 
 echo ""
 echo "check this regsiter:"
 echo ""
 echo "#$timeStamp $hashTag"
 echo "$log"
 echo ""
 echo "record on $dir$fileName"
 exit 1
}

function setTimeStamp() {

#only number

timeStamp=$1

if [ -z "$timeStamp" ]; 
then
	timeStamp=$(date +%Y%m%d%H%M%S)
	date=$(date +%Y%m%d)
	year=$(date +%Y)
	month=$(date +%m)
	day=$(date +%d)
	time=$(date +%H%M%S)
else
	if [ ${#timeStamp} == 8 ]; then
		timeStamp=$timeStamp"000000"
	fi
	
	#Extract timeStamp date, year, month and day
	date=`echo $timeStamp | cut -c1-8`
	year=`echo $timeStamp | cut -c1-4`
	month=`echo $timeStamp | cut -c5-6`
	day=`echo $timeStamp | cut -c7-8`
fi

}

function setLog() {
	
logArray=($1)

	for i in "${logArray[@]}"
	do
	if [[ ${i:0:1} == '#' ]]
	then
	hashTag="$hashTag $i"
	else
	log="$log $i"
	fi
	done

}

function setDir() {

if [ -z $year ] || [ -z $month ]; then
	setTimeStamp
fi
#Assign directory with mylog date
dir=$HOME"/"Documents"/"$year"/"$month"/"
fileName=.$date"000000.mylog"

#recursively creates mylog directories if there is no
if [ ! -d $dir ]; then
  mkdir -p $dir	
fi

}

function logRegister(){

if [ $timeStamp != $date"000000" ]; then

#Adds mylog to the log file
echo "" >> $dir$fileName
echo "#$timeStamp $hashTag" >> $dir$fileName
echo $log >> $dir$fileName

fi
}

function showLog(){
#If there is no log entry, open mylog with the default editor to edit directly in the file
if [ ! -n "$log" ] && [ ! -n "$hashTag" ]; then
  $defaultEditor "$dir$fileName"
fi
}

 while getopts "t:l:s:hv" OPTION
 do
   case $OPTION in

	h) PrintUsage
	   ;;

	v) 
	   echo "`basename $0` Version $version."
	   exit
	   ;;

	t) timeStampArg=$OPTARG
	;;

	l) setLog "$OPTARG"
	;;

	s) setTimeStamp $OPTARG
	setDir
	showLog
	exit
   esac
 done
shift $((OPTIND-1))

setTimeStamp $timeStampArg
setDir
logRegister
showLog