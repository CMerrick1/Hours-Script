#!/bin/bash

# hours script
#variables month date  send  stime etime ttime payp
#<username>|startdate|starttime|enddate|endtime|totalhours(rounded to nearest .25)|paycode|billable(y/n)|emergency(y/n)|

echo -n "What pay period is it? 
"
read month

test -e '"$month"payperiod.txt'
if [ $? = 1 ]
then
	touch "$month"payperiod.txt
fi

echo -n "Please enter start time:
 "
read stime

echo -n "Please enter end time:
 "
read etime

echo -n "Please enter total time worked today(please round to the nearest 0.25): 
"
read ttime


echo -e `date +%A%F` \ "Start: "$stime \  "End:" $etime \  "MGHPCC Intern" \ "(y)" \ "(n)" \  "Total: "$ttime  >> "$month"payperiod.txt

#set up email with postfix
echo -n "Is this the end of the pay period[y/n]?"
read payp

if [ $payp = y ]
then
       cat "$month"payperiod.txt | mail -s "Hours report for $month" cmerrick@intranet.techsquare.com

fi
