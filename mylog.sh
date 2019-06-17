#!/bin/bash
version="18.06
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Levine <levinegurgelf@gmail.com>"

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
if [ ! $log ]; then
  $defaultEditor "$dir$fileName"
fi