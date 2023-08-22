#!/bin/bash

<<Doc
Name : S Sandeep Kumar
Date : 22/08/23
Description : Module Project
sample_input :
sample_output :
Doc

echo "Command Line Test" #Test Heading

#function to choose option
function opt() {
	echo -e "1.Sign_up\n2.Sign_in\n3.Exit" #by using -e and \n we can make the output next to next line
	read -p "Choose one option : " option
}

#function to ask username
function ask_usr() {
		read -p "Enter the username : " username 
}

#function to ask password and confirmation password
function pass_pro() {
	read -p "Enter the password: " pass
	read -p "Enter the confirm password: " con_pass
}

#function to check Password and Confirmation password same
function pass_che() {
			if [ "$pass" = "$con_pass" ] #condition Check
			then
				echo "$pass" >> "$pass_file" #Redirecting Password to pass_file
				echo "$username" >> "$csv_file" #Redirecting Username to csv_file
				user_arr+=( ` cat $csv_file ` )  #Adding username to user_arr from the csv file
				pass_arr+=( ` cat $pass_file ` ) #Adding password to pass_arr form the csv file
				echo "${user_arr[@]}" #Displaying usernames 
				echo "${pass_arr[@]}" #Displaying passwords
				echo "Sign_Up Successful" 
			else
				echo "Password Not matching "
				pass_pro #Calling function pass_pro
				pass_che #Calling function pass_che

			fi

}

#Function to SignUp 
function SignUp() {
			pass_pro #Calling fun pass_pro
			if [ "$pass" = "$con_pass" ] 
			then
				echo "$pass" >> "$pass_file" #Redirecting Password to pass_file 
				echo "$username" >> "$csv_file" #Redirecting Password to csv_file
				user_arr+=( ` cat $csv_file ` ) #Adding username to user_arr from the csv file
				pass_arr+=( ` cat $pass_file ` ) #Adding password to pass_arr from the csv file
				echo "${user_arr[@]}" #Displaying usernames
				echo "${pass_arr[@]}" #Displaying passwords
				echo "Sign_Up Successful"
			else
				echo "Password is not matching"
				pass_pro #Calling function pass_pro
				pass_che #Calling function pass_che
			fi
}

#function to find username index in array
function user_in() {
			user_arr=( ` cat $csv_file ` ) #Moving csv file to user_arr
			index=-1 #Initially index is -1
			i=0
			while [ $i -lt ${#user_arr[@]} ] #Looping upto how many number of usernames in array
			do 
				if [[ "${user_arr[i]}" = "$username" ]] #checking the useranme with entered username with indexing
				then
					index=$i #if username found assigning tht index num  to index variable
					break
				fi
				i=$(( i + 1 )) #Incremetning by one
			done
			user_index=$index #User_index
			#echo "$user_index"
}

#function to find password index in array
function pass_in() {
	pass_arr=( ` cat $pass_file `) #moving csv file to pass_arr
	index=-1 #Initially index at -1
	i=0
	while [ $i -lt ${#pass_arr[@]} ] #Looping upto how many number of password in array
	do
		if [[ "${pass_arr[i]}" = "$pass" ]] #checking the password with entered password with indexing
		then
			index=$i #if password found assigning tht index num  to index variable
			break
		fi
		i=$(( i + 1 )) #Incrementing by one
	done
	pass_index=$index #pass_index
	#echo "$pass_index"
}

#function to find score
function scores() {
	user_file="user_ans.csv" #Assigning user_ans csv to user_File
	correct_file="correct_ans.csv" #Assiging correct_ans csv to user_file
	user_ans=( ` cat $user_file ` ) #Assigning user_file to user_ans array
	correct_ans=(` cat $correct_file ` ) #Assigning correct_ans to correct_ans array
	#echo "${user_ans[@]}"
	#echo "${correct_ans[@]}"
	yellow='\033[0;033m'
	reset='\033[0m'
	score=0 
	i=0
	while [ $i -lt ${#user_ans[@]} ] #Looping upto how many numbers of user_ans in array 
	do
		if [ "${user_ans[i]}" = "${correct_ans[i]}" ] #Comparing options in user_ans and correct_ans 
		then
			score=$((score + 1 )) #if same score add by one
		fi
		i=$(( i + 1 )) #incrementing by one each time
	done
	echo -e "${yellow} Toatal marks obtained : $score / 10 ${reset}"
}

#function to take_test 
function take_test() {
	question_file="question.csv" #Assigning questions csv file to question_file
	output_file="user_ans.csv" #Assigning user_ans csv file to output file
	enter_arr=() #Empty array named as enter_arr
	i=1
	# clearing output file before starting
	> $output_file

	while [ $i -le 50 ]
	do
		#display questions and options
		head -n $(( i + 4 )) $question_file | tail -n 5
		echo  "Enter the option : "
		#prompt for input
		read -t 10 option #reading options by 10 seconds delay
		echo "\"$option\"" >> $output_file #Storing entered option in output file
		#enter_arr+=( ` cat $output_file ` )
		i=$(( i + 5 ))
	done

	
}	

function result() {
	question_file="question.csv" #Assigning questions csv file to question_file
	output_file="user_ans.csv" #Assigning user_ans csv file to output file
	user_file="user_ans.csv" #Assigning user_ans csv to user_File
	correct_file="correct_ans.csv" #Assiging correct_ans csv to user_file
	user_ans=( ` cat $user_file ` ) #Assigning user_file to user_ans array
	correct_ans=(` cat $correct_file ` ) #Assigning correct_ans to correct_ans array
	red='\033[0;31m'
	green='\033[0;32m'
	blue='\033[0;34m'
	reset='\033[0m'
	i=1
	while [ $i -le 50 ]
	do
		#display questions and options
		head -n $(( i + 4 )) $question_file | tail -n 5
		ques_index=$(( i / 5 )) #index number
		user_choice=${user_ans[$ques_index]} #assining user_ans based on index number
		correct_choice=${correct_ans[$ques_index]} #assining correct_ans based on index number

		if [ "$user_choice" = "$correct_choice" ] #Checking user_choice and correct_choice
		then
			echo -e "${green}Your Answer : $user_choice (Correct) ${reset} " #if same means displaying your answer and correct
		else
			echo -e "${red}Your Answer : $user_choice (Wrong) ${reset} " #if not same means displaying your answer and wrong
		fi
		echo -e "${blue}Correct Answer : $correct_choice ${reset}" #displaying correct choice
		echo
		sleep 3 #sleep for 3 seconds
		i=$(( i + 5 )) #displaying 5 5 lines each time
	done
}

opt #Calling option function

user_arr=() #user name array
pass_arr=() #password array

csv_file="username.csv" #Assining username csv file to csv_file
pass_file="password.csv" #Assining password csv file to pass_file

#switch case for selecting options
case $option in 
	1)
		echo "Sign_up"
		ask_usr #Calling ask_usr function to ask user name
		if grep -Fxq "$username" "$csv_file" #Checking whether username present csv file
		then
			echo "Username is Already exists" 
			#if yes Displaying it already exists and asking username 
			ask_usr 
			#Calling SignUp function for asking usernames and passwords then storing username names and passwords into array
			SignUp
		else
			#Calling SignUp function for asking usernames and passwords then storing username names and passwords into array
			SignUp
		fi
		;;
	2)
		echo "Sign_in"
		ask_usr #Calling ask_usr function to ask user name
		if grep -Fxq "$username" "$csv_file" #Checking whether username present csv file
		then
			read -s -p "Enter the password : " pass #Reading password and making it as hidden
			user_in #Calling function user_in for taking username index
			pass_in #Calling function pass_in for taking password index
			if [ $user_index -eq $pass_index ] #Checking indexes of user_index and pass_index
			then
				echo "Sign in Successful" 
				#if same means calling take_test function to display questions with options to take the user options 
				take_test
				#Calling result function for checking user_ans and correct_ans and then besed on that produces result
				result
				#Calling scores function for checking user_ans and correct_ans and then besed on that produces score
				scores
				
			else
				echo "Incorrect password" #if password is incorrect
			fi
		else
			echo "Username not found" #if username is not found
		fi
		;;
	3)
		exit #exit option
		;;
	*)
		echo " Choose Correct Option !!! " #if user enters not matching options
		;;
esac

