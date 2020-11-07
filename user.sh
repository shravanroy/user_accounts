#! /bin/bash

#program to managing user accounts
#asking user to enter user name want to be deleted

echo "enter name of user want to be deleted "


function get_answer {

read -t 60 USER_NAME

if [ -z $USER_NAME ]
then
echo "since you are not providing user name we are exiting"
exit
fi

}

get_answer
#checking whether user exist or not
CHECK_USER=$( cat /etc/passwd | grep -w $USER_NAME )
if [ -z $CHECK_USER ]
then 
echo "since $USER_NAME doesn't exist "
echo "we are exiting now"
exit
fi
#finding all process releated to user 

if [ $? -eq 1 ]
then
echo "no process are for user $USER_NAME "

else
echo "process running for user $USER_NAME are "
ps -u $USER_NAME
echo "killing all process "
fi




COMMAND=$( ps -u $USER_NAME --no-heading | gawk '{print $1}' )
sudo kill -9 $COMMAND

#finding all files related to user
find / -user $USER_NAME > report 2> /dev/null
echo "we are creating a file name "report" "
echo "it will contains all file belonged to specific user "
echo "this has been done so that user could restore them in future ,if wants"
#deleting user account
echo "deleting $USER_NAME account has been started ..."
echo
sudo userdel $USER_NAME
echo "$USER_NAME account has been deleted "
echo
exit

