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
	* At last total marks will be displayed gained by the user
	
*  Time-out
	*  The script will timeout if the user input is absent for more than 10 seconds on the main menu and test menu.

### Sample Output
----------------------

Here are the sample output by the end of Linux Shell Scripting Project execution.	

|![Main Screen](https://user-images.githubusercontent.com/82516591/186354107-202ff9c8-e605-4ebf-9b4e-a03cb874fd4f.png)|
|:--:|
| <b>Fig1: Main Screen</b> |

|![Sign Up Screen](https://user-images.githubusercontent.com/82516591/186355477-22673118-7972-4ec7-8673-04f62edf4d59.png)|
|:--:|
| <b>Fig2: Sign Up Screen</b> |

|![Sign Up Screen, Credentials Entered](https://user-images.githubusercontent.com/82516591/186358860-4a121e9e-3667-419c-8f92-d1d5a3858522.png)|
|:--:|
| <b>Fig3: Sign Up Screen, Credentials Entered</b> |

|![Sign Up with the same User Name again!!](https://user-images.githubusercontent.com/82516591/186359005-5eb738e3-99ba-4144-8716-76b72d52604d.png)|
|:--:|
| <b>Fig4: Sign Up with the same User Name again!!</b> |

|![Sign In Screen, Password in shadow mode](https://user-images.githubusercontent.com/82516591/186359249-78233b08-36a1-4997-bfbf-72c0570229ba.png)|
|:--:|
| <b>Fig5: Sign In Screen, Password in shadow mode</b> |

|![Sign In Sucessful Screen](https://user-images.githubusercontent.com/82516591/186359458-cf29bc88-9437-4299-85ae-17e85aee7a78.png)|
|:--:|
| <b>Fig6: Sign In Sucessful Screen</b> |

|![Features Screen, Proceeding to Take a Test](https://user-images.githubusercontent.com/82516591/186359708-f1baf8a3-5171-477c-9f94-ff26d5fc781d.png)|
|:--:|
| <b>Fig7: Features Screen, Proceeding to Take a Test</b> |

|![Test in progress](https://user-images.githubusercontent.com/82516591/186359856-736514f3-859b-4a70-a260-2ec99f343a2c.png)|
|:--:|
| <b>Fig8: Test in progress, Every question is Timed</b> |

|![Test completion screen](https://user-images.githubusercontent.com/82516591/186359990-e75af169-c228-4592-8d23-dc973e560ab2.png)|
|:--:|
| <b>Fig9: Test completion screen</b> |

|![View Test Screen](https://user-images.githubusercontent.com/82516591/186360274-d651f9cb-b4f4-4004-8bf1-5d80088b4464.png)|
|:--:|
| <b>Fig10: Candidate's Test Response Screen</b> |

|![View Test Screen](https://user-images.githubusercontent.com/82516591/186360557-02fa279a-fc2a-4185-b547-dd88c743d9bc.png)|
|:--:|
| <b>Fig11: Candidate's Test Response Screen(with marks)</b> |
