# Command-Line-Test
Command line test is a BASH shell based tool that simulates login based online testing scenario.

### Project Brief
----------------------

The goal of this Linux Shell Scripting Project is to implement a login based online test platform using BASH Shell and commands.

### Introduction
----------------------

Command line test is a BASH shell based tool that simulates login based online testing scenario. Initially the user will be provided with a sign-in and sign-up option, where user have to choose sign-up option if he/she is using first time, but if user has already sign-up then user is going to choose sign-in option. Upon successful login this tool will display questions for the user from existing data-base. It will also handle error conditions like time-out. This tool will also store answers provided by users for future verification.

These days there are a lot of online test platform which enables students to take tests online. They will typically have a user-interface, backend question bank and evaluation part. They will also support other features like predefined time per question, output reports etc. The idea of this project is to simulate such an online test interface using Linux Shell Scripting and commands. 

### Project Details
-------------------------

This Linux Shell Scripting Project is Divided into various sections.

* Provide a prompt for the user to sign-up and sign-in
	* Sign In
		* Take Test
		* View Test
		* Log out
	* Sign up
	* Exit

* Using sign-up user can register with a user-id and password
	* Ask for user-name. The user-name should contain only alphanumeric symbols
	* Ask for new password. The password can contain any symbol in it. Accept at-least 8 characters
with at-least a number and symbol
	* Ask the user to re-enter the password again for validation
	
* Already registered user can sign-in with ID and password
	* The script will prompt for user-name and password
	* The password is taken like a shadow password
	* The script Shows error in-case passwords mismatches 

* Question bank
	- User can save his/her multiple choice questions in questions.txt file which is already present in the folder with some demo questions.
	
* Taking a test
	- Prompt the user with questions one by one from the question_bank.
	* Prompt for questions with multiple choice
	* Every question is to be timed, say 10 seconds
	* On timeout the question will change with fresh time
	* Every answer will be stored in user's_answer.txt

* Show Test Response
	* If the user chooses this option, the script should show all the questions with all options, correct answer and user's answer for each question
	* At last total marks will be displayed gained be the user
	
*  Time-out
	*  The script will timeout if the user input is absent for more than 10 seconds on the main menu and test menu.
