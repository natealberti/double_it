# author: nate alberti
# date: 03-13-2021
# purpose: with the use of subprograms, take in an integer value between 30 and 40,
# double it, and display the results

.data
	x: .byte 0
	y: .byte 0
	hello_world: .asciiz "Hello World\n"
	results: .asciiz "Your final answer is: "

.text
main:
	# printing greeting message #
	li $v0, 4
	la $a0, hello_world
	syscall
	
	# get_input subprogram #
	li $a0, 30 # setting the minimum value
	li $a1, 40 # setting the maximum value
	jal get_input # running the subprogram
	sb $v0, x # assigning x to the value of the return value from get_input
	
	# double_it subprogram #
	move $a0, $v0 # moving x into the argument reg in preparation for double_it
	jal double_it # running the subprogram
	sb $v0, y # assigning y to the value of the return value from double_it
	
	 # printing the result #
	 la $a0, results # loading the final message into argument reg for print_results
	 move $a1, $v0 # loading the final value into the argument reg for print_results
	 jal print_results
	 
	  # exiting the program #
	  li $v0, 10
	  syscall 
	  
								# SUBPROGRAMS #

### GET_INPUT subprogram ###
# purpose: reads an int that is between two preselected numbers
# arguments: two integers: min in $a0 and max in $a1
# return values: one integer in $v0
.data
	prompt_1: .asciiz "Enter a number between "
	prompt_2: .asciiz " and "
	prompt_3: .asciiz ": "
	
.text
get_input:
	# moving arguments from $a0,$a1 >>> $a2,$a3 to make room for printing the prompt
	move $a2, $a0
	move $a3, $a1

	# printing first part of prompt
	li $v0, 4
	la $a0, prompt_1
	syscall
	
	# printing min number
	li $v0, 1
	move $a0, $a2 # moving the min number to be printed
	syscall
	move $a2, $a0 # returning min number back to it's place
	
	# printing second part of the prompt
	li $v0, 4
	la $a0, prompt_2
	syscall
	
	# printing max number
	li $v0, 1
	move $a0, $a3 # moving the max number to be printed
	syscall
	move $a3, $a0 # returning max value back to it's place
	
	# printing third part of the prompt
	li $v0, 4
	la $a0, prompt_3
	syscall
	
	# reading the input
	li $v0, 5
	syscall
	
	# returning program back to main
	jr $ra
	
	
### DOUBLE_IT subprogram ###
# purpose: takes an integer and returns it multiplied by 2
# arguments: one integer in $a0
# return values: one integer in $v0
.data
	number: .byte 0

.text
double_it:
	sb $a0, number # saving number into data memory
	lb $t0, number # loading number into $t0 
	lb $v0, number # loading number into $v0
	add $v0, $v0, $t0 # adding the two and putting it into $v0
	
	# returning program back to main
	jr $ra
	

### PRINT_RESULTS subprogram ###
# purpose: takes an integer and returns it with the accompanying string
# arguments: a string in $a0, and an integer in $a1
# return values: nothing
.text
print_results:
	li $v0, 4 # preparing to print a string
	# assuming the string is already in $a0
	syscall
	
	move $a0, $a1 # moving the integer into $a0
	li $v0, 1
	syscall
	
	# returing the program back to main
	jr $ra
	
	
	
