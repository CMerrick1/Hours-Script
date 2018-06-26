#!/bin/bash

# hours script
#variables day todaydate  send  stime etime ttime payp productivity mtotal emergency compiled_hours
#<username>|startdate|starttime|enddate|endtime|totalhours(rounded to nearest .25)|MGHPCC/INTERN|billable(y/n)|emergency(y/n)|
#
# need to take month, sort out the date parameter, if date is >= 26, needs to create and 
# save to the next months payperiod
# 
# 
# 

futuremonth=`date +%b-%y --date='+1 month'`   #displays nest month date July18
compileddate=`date +%b%y` #displays month and year eg Jun18
whichpayperiod=`date +%d`  # displays just date 26
#date = (`date +%m-%d-%y`)                   Issue with $daypayperiod, not sure why its here
#month = (`date +%A%F`)


if [ $whichpayperiod = 1 ]
then
mv compiled_hours.txt compiled_hours.txt
fi

test -e '"$day"payperiod.txt'
if [ $? = 1 ]
then
	if [ "$whichpayperiod" -ge  25 ]
	then
		touch "`date +%b-%y --date='+1 month'`"payperiod.txt
		touch "`date +%b-%y --date='+1 month'`"hourscount.txt
	else
# if statement for selecting date >= 26
		touch "`date +%b-%y`"payperiod.txt
	fi
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
	if [ "$whichpayperiod" -ge  25 ]
        then
               echo "$ttime" >> "`date +%b-%y --date='+1 month'`"hourscount.txt
	else
		echo "$ttime" >> "`date +%b-%Y`"hourscount.txt                  #this should work fine
	fi
fi
#
#


echo -n "Was this an Emergency[Y/N]? "
read emergency

echo -n "What did you work on? "
read productivity

if [ "$whichpayperiod" -ge  25 ]
then

	echo -e "cmerrick" \| $todaydate  $stime \| $todaydate  $etime \| $ttime \| "MGHPCC/INTERN" \| "$billable" \| "$emergency" \| "$productivity"  >> "`date +%A%F`"payperiod.txt

	echo -n "Would you like to submit these hours[y/n]? "
	read payp

	if [ $payp = y ]
	then


 #something wrong   doesn work properly


	paste -sd+ "`date +%b-%y --date='+1 month'`"hourscount.txt | bc > compiled_hours.txt
       
	cat "`date +%A%F`"payperiod.txt | mail -s "Total Hours for the Pay Period to Date: `cat  compiled_hours.txt`" cmerrick@intranet.techsquare.com
	fi




######################################################
else

echo -e "cmerrick" \| $todaydate  $stime \| $todaydate  $etime \| $ttime \| "MGHPCC/INTERN" \| "$billable" \| "$emergency" \| "$productivity"  >> "`date +%A%F`"payperiod.txt

        echo -n "Would you like to submit these hours[y/n]? "
        read payp

        if [ $payp = y ]
        then


#something wrong


        paste -sd+ "`date +%b-%Y`"hourscount.txt | bc > compiled_hours.txt


        cat "`date +%A%F`"payperiod.txt | mail -s "Total Hours for the Pay Period to Date: `cat compiled_hours.txt`" cmerrick@intranettechsquare.com


	fi
fi


