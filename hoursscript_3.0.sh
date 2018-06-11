#!/bin/bash

# hours script
#variables day date  send  stime etime ttime payp productivity mtotal emergency compiled_hours
#<username>|startdate|starttime|enddate|endtime|totalhours(rounded to nearest .25)|MGHPCC/INTERN|billable(y/n)|emergency(y/n)|

test -e '"$day"payperiod.txt'
if [ $? = 1 ]
then
	touch "`date +%A%F`"payperiod.txt
fi

test -e '"$date +%b-%Y"payperiod.txt'
if [ $? = 1 ]
then
        touch "`date +%b-%Y`"hourscount.txt
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

#Something wrong
#doesnt add ttime to hourscount.txt

if [ $billable == Y ]
#ADDS only billable time to running time count
then
echo "$ttime" >> "`date +%b-%Y`"hourscount.txt                  #this should work fine
fi

#
#


echo -n "Was this an Emergency[Y/N]? "
read emergency

echo -n "What did you work on? "
read productivity


echo -e "cmerrick" \| `date +%m-%d-%y`  $stime \| `date +%m-%d-%y`  $etime \| $ttime \| "MGHPCC/INTERN" \| "$billable" \| "$emergency" \| "$productivity"  >> "`date +%A%F`"payperiod.txt

echo -n "Would you like to submit these hours[y/n]? "
read payp

if [ $payp = y ]
then


#something wrong


paste -sd+ "`date +%b-%Y`"hourscount.txt | bc > compiled_hours.txt
       
cat "`date +%A%F`"payperiod.txt | mail -s "Total Hours for the Pay Period to Date: `cat compiled_hours.txt` " cmerrick@intranet.techsquare.com


#


fi

