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

hashTag="#Mylog #Example"
log="Hello World"

#recursively creates mylog directories if there is no
if [ ! -d $dir ]; then
  mkdir -p $dir	
fi

echo "" >> $dir$fileName
echo "#$timeStamp $hashTag" >> $dir$fileName
echo $log >> $dir$fileName

 echo "Mylog: Simple record of personal events in chronological order using timestamp as id and # for hashTag"
 echo ""
 echo "Using: `basename $0` <-vh>[-tl]"
 echo "-t timestamp (optional, ex 20190712121500)"
 echo "-l log"
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

date=$(date +%Y/%m/%d)
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)
timeStamp=$(date +%Y%m%d%H%M%S)
time=$(date +%H%M%S)

dir=$HOME"/"Documents"/"$(date +%Y/%m/)
fileName=.$(date +%Y%m%d)"000000.mylog"

 while getopts "t:l:hv" OPTION
 do
   case $OPTION in

	h) PrintUsage
	   ;;

	v) 
	   echo "`basename $0` Version $version."
	   exit
	   ;;

	t) timeStamp=$OPTARG

	#Extract timeStamp date, year, month and day
	date=`echo $timeStamp | cut -c1-8`
	year=`echo $timeStamp | cut -c1-4`
	month=`echo $timeStamp | cut -c5-6`
	day=`echo $timeStamp | cut -c7-8`

	#Assign directory with mylog date
	dir=$HOME"/"Documents"/"$year"/"$month"/"
	fileName=.$date"000000.mylog"

	;;

	l) logArray=($OPTARG) 

	for i in "${logArray[@]}"
	do
	if [[ ${i:0:1} == '#' ]]
	then
	hashTag="$hashTag $i"
	else
	log="$log $i"
	fi
	done
	;;

	# o)openLog=$OPTARG
   esac
 done
shift $((OPTIND-1))

#recursively creates mylog directories
if [ ! -d $dir ]; then
  mkdir -p $dir	
fi


if [ $timeStamp != $date"000000" ]; then

#Adds mylog to the log file
echo "" >> $dir$fileName
echo "#$timeStamp $hashTag" >> $dir$fileName
echo $log >> $dir$fileName

fi

#If there is no log entry, open mylog with the default editor to edit directly in the file
if [ ! -n "$log" ]; then
  $defaultEditor "$dir$fileName"
fi