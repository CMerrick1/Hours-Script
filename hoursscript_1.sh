#!/bin/bash

# hours script
#variables day date  send  stime etime ttime payp productivity
#<username>|startdate|starttime|enddate|endtime|totalhours(rounded to nearest .25)|MGHPCC/INTERN|billable(y/n)|emergency(y/n)|




test -e '"$day"payperiod.txt'
if [ $? = 1 ]
then
	touch "`date +%A%F`"payperiod.txt
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

echo -n "Are these hours billable[y/n]?"
read billable

echo -n "What did you work on?"
read productivity

echo -e "CMerrick" \| `date +%A%F` \| $stime \| `date +%A%F` \| $etime \| $ttime \| "MGHPCC Intern" \| "($billable)" \| "(n)" \| "$productivity"  >> "`date +%A%F`"payperiod.txt

echo -n "Would you like to submit these hours[y/n]?"
read payp

if [ $payp = y ]
then
       
cat "`date +%A%F`"payperiod.txt | mail -s "`date +%A%F`" sb@intranet.techsquare.com

#email daily
#
fi




