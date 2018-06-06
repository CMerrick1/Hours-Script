#!/bin/bash

# hours script
#variables day date  send  stime etime ttime payp productivity mtotal emergency
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

echo -n "Are these hours billable[Y/N]? "
read billable

echo -n "Was this an Emergency[Y/N]? "
read emergency

echo -n "What did you work on? "
read productivity

# change date to only show numerals
echo -e "CMerrick" \| `date +%m/%d/%y`  $stime \| `date +%m/%d/%y`  $etime \| $ttime \| "MGHPCC/INTERN" \| "$billable" \| "$emergency" \| "$productivity"  >> "`date +%A%F`"payperiod.txt

echo -n "Would you like to submit these hours[y/n]? "
read payp

if [ $payp = y ]
then

echo -n "How many hours have you worked so far this month? "
read mtotal
       
cat "`date +%A%F`"payperiod.txt | mail -s "Total Hours for the Pay Period to Date: $mtotal" sb@intranet.techsquare.com

#email daily
#
fi




