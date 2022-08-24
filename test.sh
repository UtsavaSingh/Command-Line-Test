<<doc
Name : Utsava Kumar Singh
Date : 06-08-2022
Description : A simple shell script which would allow a user to register and the registered user to login. After login user can take a test on shell 
doc

#!/bin/bash

# The directory names
question_answer_directory=question_answer_bank			#This directory contains questions.txt and answer.txt files
user_info_directory=.user_info					#This hidden directory contains user_name.csv and user_pass.csv files
user_response_directory=.user_response				#This hidden dierctory contains all the user's_response.txt files

# The file names
question_bank=./"$question_answer_directory"/questions.txt	#questions.txt file contains all the questions for the test
correct_answer_file=./"$question_answer_directory"/answer.txt	#answer.txt file contains all the answers of each question inside questions.txt file
username_file=./"$user_info_directory"/user_name.csv		#user_name.csv file contains the user names of each user who has signed up
userpass_file=./"$user_info_directory"/user_pass.csv		#user_pass.csv file contains the user passwords of each user who has signed up

# Global variables
no_of_ques=10					    		#number of questions present in questions.txt file
no_of_lines=$((5*$no_of_ques))					#number of lines present in questions.txt file
marks_per_ques=1						#marks carried be each question
total_marks=$(($no_of_ques*$marks_per_ques))			#total marks of test

# Colour codes for 'tput' command
red=1
green=2
yellow=3
blue=4
cyan=6

# Time out periods
menu_time_out=10						#time to log out if user does not given any response
answer_response_time=10						#time given for the answer response for each question to the user
long_period=5							#long delay time to show the message
short_period=3							#short delay time to show the message

#===================================================== page_title function definition ==================================================================

function page_title()
{
    clear
    echo "   =========================="
    # $(tput setaf $red) - select the text colour, $(tput setab $yellow) - select the background colour, $(tput bold) - select the bold mode, 
    # $(tput sgr 0) - resetting to default
    echo "  |$(tput setaf $red)$(tput setab $yellow)$(tput bold)     Command Line Test    $(tput sgr 0)|"       
    echo -e "   ==========================\n"
}

#===================================================== menu_header function definition =================================================================

function menu_header() 
{
    #calling page_title function
    page_title												
    echo -e "\n$(tput setaf $blue)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
    echo "1. Sign in"
    echo "2. Sign up"
    echo -e "3. Exit\n"
    echo -e "$(tput setaf $red)$(tput bold)Note:$(tput sgr 0) Script Exit Timeout is set\n"
}

#==================================================== view_response function definition ================================================================

function view_response()
{
    #calling page_title function
    page_title
    echo -e "$(tput setab $cyan)$(tput bold)     $user's Response Screen       $(tput sgr 0) \n"
    #checking user's answer file is present or not i.e. user has given the test or not
    if [ -f ./"$user_response_directory"/"$user"_answer.txt ]						
    then
	correct_answer=( `cat $correct_answer_file` )				#storing answers.txt content in an 'correct_answers' array 
    	user_answer=( `cat ./"$user_response_directory"/"$user"_answer.txt` )	#storing user_answer.txt content in an 'user_answer' array
    	position=0								#initializing 'position' variable
    	marks=0									#initializing 'marks' variable		
    	#for loop with i=5 as initial value then incrementing it by 5 each time upto number of lines present in question band file
    	for i in `seq 5 5 $no_of_lines`							
    	do
	    echo
	    head -$i $question_bank | tail -5				        #printing each question with options from questions.txt file
	    echo
	    echo "Correct answer: ${correct_answer[$position]}"			#printing the correct answer
	    if [ ${user_answer[$position]} = "e" ]
	    then
	    	echo "$user's answer: No response"				#printing no response if time out occur
            else
	        echo "$user's answer: ${user_answer[$position]}"		#printing user's answer
	    fi
	    #comparing the two answers, if it is equal than marks will be incremented by 1 
	    if [ ${correct_answer[$position]} = ${user_answer[$position]} ]  
	    then
	        echo "Remarks: $(tput setaf $green)Correct$(tput sgr 0)"
	        marks=$(($marks+$marks_per_ques))				#incrementing marks variable for each correct answer
	    else
	        #logic to find out that the user has given the wrong response or time-out condition occur
	        if [ ${user_answer[$position]} = "e" ]
	        then
		    echo "Remarks: Time-out"
	        else
		    echo "Remarks: $(tput setaf $red)Wrong $(tput sgr 0)"
	        fi
	    fi
	    #incrementing the position variable after printing the response of each question
	    position=$(($position+1))				
        done
        echo -e "\n$(tput setaf $red)$(tput setab $yellow)$(tput bold) Total marks: $marks out of $total_marks $(tput sgr 0)\n"
        read -p "Press Enter key to go to previous menu" a
    else
	#If the user's answer file is not present i.e. user has not given the test
	echo -e "\n$(tput setaf $red)$(tput bold)You have not attended the test.$(tput sgr 0)\n\nPlease wait going to previous screen....."
	sleep $short_period							#delay 
    fi
}

#====================================================== test_screen function definition ================================================================

function test_screen()
{
    #calling page_title function
    page_title
    echo -e "$(tput setab $cyan)$(tput bold)           Test Screen             $(tput sgr 0) \n"
    #checking user's answer file is present or not i.e. user has given the test or not
    if [ -f ./"$user_response_directory"/"$user"_answer.txt ]
    then
	echo -e "$(tput setaf $green)$(tput bold)\nYou have already submitted the test.$(tput sgr 0)\n\nPlease wait going to previous screen....."
	sleep $short_period							#delay 
    else
        #If the user's answer file is not present i.e. user has not given the test
        #for loop with i=5 as initial value then incrementing it by 5 each time upto 50
        for i in `seq 5 5 $no_of_lines`					
        do
	    #calling page_title function
	    page_title
	    echo -e "$(tput setab $cyan)$(tput bold)          Test Screen            $(tput sgr 0) \n"
	    echo -e "Total Marks : $total_marks         Each Question Marks : $marks_per_ques\n\n"
            head -$i $question_bank | tail -5					#printing each question with options
            echo
            for j in `seq "$answer_response_time" -1 1`
            do
		echo -n -e "\rTime Remaining: $j Seconds;    Choose your option: \c"
	        read -t 1 ans							#take input as single character 

	        #if no character is passed as input than save default value 'e' in 'ans' variable
	        if [ -n "$ans" ]				
	        then
		    break
	        else
	            ans="e"
	        fi
            done
            echo "$ans" >> ./"$user_response_directory"/"$user"_answer.txt	#append 'ans' variable value into answer.txt file
        done
        echo -e "$(tput setaf $yellow)$(tput bold)\n\nTest Completed, will be logged off shortly$(tput sgr 0)"
        sleep $long_period							#delay 
    fi
}

#======================================================== test_menu function definition =================================================================

function test_menu()
{
    test_menu_exit=0								#initializing a flag to continue or exit the test menu
    while [ $test_menu_exit -eq 0 ]
    do
	#calling page_title function
	page_title
	echo -e "$(tput setab $cyan)$(tput bold)           Test Menu             $(tput sgr 0) \n"
        echo "1. Take a Test"
        echo "2. View your test"
        echo -e "3. Sign Out\n"
        
	#logic for time-out
        for j in `seq "$menu_time_out" -1 1`
        do
           echo -n -e "\rPlease choose your option: \c"
	   read -t 1 choice					#taking user choice as single character 
	   #if no character is passed as input than save default value '+' in 'choice' variable
	    if [ -n "$choice" ]				
	    then
		break						#come out of if condition block if user entered any input
            else
		choice=+
	    fi
        done

        case $choice in
	    1) test_screen					#test_screen function call if user choose option 1
               ;;
            2) view_response					#view_response function call if user choose option 2
               ;;
            3) test_menu_exit=1					#setting test_menu_exit flag to exit from the while loop if user choose option 3
               ;;
            +) #If user has not entered any value in set time out period then this option will execute
    	       echo -e "$(tput setaf $red)\n\nTime out occured as you have not choosen any option$(tput sgr 0)\nPlease wait, going to main menu... "
    	       test_menu_exit=1					#setting exit_flag to come out of the while loop if user has not given any input
    	       sleep $long_period				#delay 
    	       ;;
	   *)  #defualt condition if the user enterd some other value
	       echo -e "$(tput setaf $red)\n\nPlease choose the correct option$(tput sgr 0)\n\nPlease wait, then try again....."
	       sleep $short_period				#delay 
               ;;
        esac	   
    done
}

#======================================================= sign_in function definition ====================================================================

function sign_in()
{
    user_name=( `cat $username_file` )				#saving the content of 'user_name.csv' file in 'user_name' array
    user_pass=( `cat $userpass_file` )				#saving the content of 'user_pass.csv' file in 'user_pass' array
    user_flag=0							#flag to decide to continue or exit the sign in screen
    pass_flag=0							#flag to decide to continue or exit the  password taking process
    error_user=0						#flag to show the error message for invalid user or not
    error_pass=0						#flag to show the error message for invalid password or not
    while [ $user_flag -eq 0 ]
    do
	#calling page_title function
	page_title
	echo -e "$(tput setab $cyan)$(tput bold)         Sign In Screen           $(tput sgr 0) \n"
	if [ ! -s "$username_file" ]				#checking that user_name.csv file is empty or not
        then
	    echo -e "$(tput setaf $red)$(tput bold)\n\nYou need to sign up first to attend the test.\n$(tput sgr 0)\nPlease wait going to sign in screen....."
	    sleep $short_period					#delay 
	    user_flag=1						#setting user_flag to not to continue with the sign in process
	else
            if [ $error_user -eq 1 ]
            then
		#printing the error message when error_user flag is set i.e. when user does not exist in user_name array
	        echo -e "\n$(tput setaf $red)Entered user name does not exist$(tput sgr 0)\n"
	        error_user=0
            fi
            echo -e "Please enter your\n"
            read -p "Username: " user
	
	    #logic for sign in of a user
            for i in `seq 0 $((${#user_name[*]}-1))`
            do
		if [ ${user_name[i]} = $user ]
	        then
		    user_flag=1					#setting the user_flag as the user name is found in user_name array
                    while [ $pass_flag -eq 0 ]
                    do
			#calling page_title function
                        page_title
                        echo -e "$(tput setab $cyan)$(tput bold)         Sign In Screen           $(tput sgr 0) \n"
                        echo -e "Please enter your\n"
                        echo "Username: $user"
                        #logic for printing the error message when error_pass flag is set i.e. when user entered wrong password
                        if [ $error_pass -eq 1 ]
                        then
		            echo -e "\n$(tput setaf $red)You have entered wrong password. Please try again!$(tput sgr 0)\n"
                        fi
	                echo -n "Password: "			
	                read -s  pass				#taking password in shadow mode
	                if [ ${user_pass[i]} = $pass ]
	                then
		            #setting the pass_flag as the user password is same as the password given by the user
		            pass_flag=1				
		            echo -e "\n$(tput setaf $green)\nlogin successful!$(tput sgr 0)\nPlease wait going to test menu screen....."
		            sleep $short_period			#delay
		            #calling test_menu function
		            test_menu
	                else
	                    error_pass=1			#setting error_pass flag as the user entered wrong password
	                fi
	            done
	        else
	            error_user=1				#setting error_user flag as the entered user name is not present
                fi
            done
	fi
    done
}

#===================================================== sign_up function definition ======================================================================

function sign_up()
{
    user_flag=0							#flag for deciding to continue or exit the user input process
    error_flag=0						#flag to show the error message or not, if user name is already present
    user_cond_flag=0						#flag to show the error message or not, if user name does not fulfil the conditions
    while [ $user_flag -eq 0 ]
    do	
	user_flag=1						#setting the user_flag
	#calling page_title function
	page_title
        echo -e "$(tput setab $cyan)$(tput bold)         Sign Up Screen           $(tput sgr 0) \n"
	
	if [ $user_cond_flag -eq 1 ]
	then
	    echo -e "$(tput setaf $red)Username should contain only alpha-numeric and at least 5 characters$(tput sgr 0)\n"
	    user_cond_flag=0
	fi
	#logic for printing the error message when error_flag is set i.e. when user entered the user name is already in use
	if [ $error_flag -eq 1 ]
	then
	    echo -e "$(tput setaf $red)Username "$user" Exist!!: Please choose some other name$(tput sgr 0)\n"
	    error_flag=0
	fi
        read -p "Please choose your username: " user
	
	#'grep' command is used to find number of times 'user' variable is present in user_name.csv file and save it to 'user_times' variable
	user_times=`grep -c "$user" "$username_file"`	
 	len_user=${#user}       				#saving the length of 'user' variable into len_user variable
        
	#checking that the 'user' variable contain only alpha-numeric and at least 5 characters
        if [[ "$user" =~ ^[0-9a-zA-Z]+$ && "$len_user" -ge 5 ]]
	then
	    if [ $user_times -ne 0 ]
	    then
		error_flag=1					#setting the error_flag if the user entered the user name that is already in use
		user_flag=0					#resetting the user_flag if the user entered the user name that is already in use
	    fi
	else
	    user_cond_flag=1					#setting user_cond_flag if all the conditions are not fulfiled
	    user_flag=0
	fi
     done
     echo "$user" >> "$username_file"				#append the value of 'user' variable into 'user_name.csv' file

     match_flag=0						#flag to check both password is matching or not
     while [ $match_flag -eq 0 ]
     do
	 #calling page_title function
	 page_title
        echo -e "$(tput setab $cyan)$(tput bold)         Sign Up Screen           $(tput sgr 0) \n"
        echo "Please choose your username: $user"
	 pass_flag=0						#initializing flag to check entered password fulfill all conditions or not
	 msg_flag=1						#flag to show the password condition details only one time
         while [ $pass_flag -eq 0 ]
         do
	     if [ $msg_flag -eq 1 ]				#printing the conditions to create password initially
	     then
	         echo -e "\nNote: * The password must contain a mix of letters, numbers and special characters"
	         echo -e "      * The length of password must be greater than or equal to 8\n"
	     fi
	     echo -n "Please enter your password: "
	     read -s pass
             len_pass=${#pass} 					#saving the length of 'pass' variable into len_pass variable
             #checking that the 'pass' variable contains mix of letters, numbers and special characters and also length is at least 8 or not
             if [[ "$pass" =~ [a-zA-Z] && "$pass" =~ [!@#$%^\&*?,.] && "$pass" =~ [0-9] && "$len_pass" -ge 8 ]] 
             then
                 pass_flag=1					#setting pass_flag if all the conditions are fulfiled
             else
		 echo -e "\n$(tput setaf $red)Your password does not fulfil the conditions$(tput sgr 0)"
		 echo -e "\nPlease try again\n"
		 msg_flag=0					#resetting msg_flag as the conditions are already printed 
             fi
         done
         echo -e -n "\nPlease $(tput setaf $green)re-enter$(tput sgr 0) your password: "
         read -s re_pass
         if [ $pass = $re_pass ]
         then
	     echo "$pass" >> "$userpass_file"			#append the value of 'pass' variable into 'user_pass.csv' file
	     echo -e "$(tput setaf $green)\n\nRegistration Successful!$(tput sgr 0)\n\nPlease wait going to sign in screen....."
	     sleep $short_period				#delay
	     match_flag=1					#setting match_flag as the both the password matches
         else
	     echo -e "$(tput setaf $red)Both the password is not matching!! Please wait and try again$(tput sgr 0)\n"
	     sleep $short_period				#delay
         fi
     done
}

#================================================= file_existence function definition ===================================================================

function file_existence()
{
    if [ ! -d $question_answer_directory ]			#checking question_answer directory is present or not
    then
        mkdir "$question_answer_directory"			#creating question_answer directory
    fi
    
    if [ ! -d $user_info_directory ]			        #checking user_info directory is present or not
    then
        mkdir "$user_info_directory"  			        #creating user_info directory
    fi
    
    if [ ! -d $user_response_directory ]			#checking user_response directory is present or not
    then
        mkdir "$user_response_directory"			#creating user_response directory
    fi
    
    if [ ! -f $question_bank ]					#checking questions.txt file is present or not
    then
        echo -e "$(tput setaf $red)\nQuestion bank file is not present in the question_answer directory.\nPlease create it...\n$(tput sgr 0)"
        exit_flag=1						#setting exit_flag to come out of the while loop        
    fi
    
    if [ ! -f $correct_answer_file ]				#checking answer.txt file is present or not
    then
        echo -e "$(tput setaf $red)\nCorrect answer file is not present in the question_answer directory.\nPlease create it...\n$(tput sgr 0)"
        exit_flag=1						#setting exit_flag to come out of the while loop
    fi
    
    if [ ! -f $username_file ]					#checking user_name.csv file is present or not
    then
        touch "$username_file"					#creating user_name.csv file
    fi
    
    if [ ! -f $userpass_file ]					#checking user_pass.csv file is present or not
    then
        touch "$userpass_file"					#creating user_pass.csv file
    fi
}

#============================================================= Main Script ==============================================================================

exit_flag=0							#initializing the exit_flag to continue the while loop
while [ $exit_flag -eq 0 ]
do
    #calling menu_header function
    menu_header
    #calling file_existence function
    file_existence						#checking that both question and answer file is present or not
    if [ $exit_flag -eq 0 ]					
    then
        #logic for time-out
	for j in `seq "$menu_time_out" -1 1`
        do
            echo -n -e "\rPlease choose your option: \c"
	    read -t 1 choice					#taking user choice as single character 
	    #if no character is passed as input than save default value '+' in 'choice' variable
	    if [ -n "$choice" ]				
	    then
		break						#come out of if condition block if user entered any input
            else
		choice=+
	    fi
        done
        
        case $choice in	
            1) sign_in 						#calling sign_in function if user choose option 1
	       ;;
    	    2) sign_up						#calling sign_up function if user choose option 2
	       ;;
    	    3) exit_flag=1					#setting exit_flag to come out of the while loop if user choose option 3
    	       ;;
    	    +) #If user has not entered any value in set time out period then this option will execute
    	       echo -e "$(tput setaf $red)\n\nTime out occured as you have not choosen any option$(tput sgr 0)\n"
    	       exit_flag=1					#setting exit_flag to come out of the while loop if user has not given any input
    	       ;;
	    *)  #defualt condition if the user enterd some other value
	       echo -e "$(tput setaf $red)\nPlease coose the correct option!$(tput sgr 0)\n\nPlease wait and try again"
	       sleep $short_period				#delay
    	       ;;
        esac
    fi
done  

************************************************************* End of Script ****************************************************************************
