# CSCI 202 - Computer Organization II - MIPS Project 1 #

This MIPS Program simulates a simple calculator and implements user defined versions of the basic arithmetic operations in MIPS. 

## Features: ##
  + Allows the user to enter 2 integer operands and a character operator.
  + Performs the operations specified by the inputs.
  + Outputs the result of the arithmetic operation.	

### Errors: ###
  + If division by zero occurs, the resulting output is NaN (Not a number). 
  + If arithmetic overflow occurs, the incorrect output will be displayed along with the appropriate error message.
  + If an invalid operator is entered, "Invalid arithmetic operation" error messagge will be displayed.

## Requirements: ##
  + A MIPS simulator is required to run this program. 
  + The two recommended simulators are QtSpim and MARS. 
  + You will also be required to have Java SE installed on your system if you decide to go with MARS.

### Download Links: ###
  + QtSpim	http://spimsimulator.sourceforge.net/
  + MARS	http://courses.missouristate.edu/KenVollmar/mars/download.htm

## Execution Instructions: ##
### QtSpim: ###
  + Open QtSpim.
  + Load the file, "domath.S".
  + Run the program.
  + Enter the appropriate inputs in the console window that appears. 
  + **Note: You must reinitialize and load the file before running the program again.**

### MARS: ###
  + Open MARS.
  + Open the file, "domath.S".
  + Assemble the program by pressing F3.
  + Run the program by pressing F5.
  + Enter the appropriate inputs in the interactive window that appears at the bottom of the screen.
  + **Note: You must assemble the program again before running it again.**

## Workload Distribution: ##
  + Both team members worked on implementing the do_math and main functions.
  + Mahia Tasneem implemented the do_add and the do_subtract functions
  + Kaleshwar Singh implemented the do_multiply and do_divide functions. 

## Test Cases: ##
### Test Cases for the do_add function ###
  The do_add function is being tested here. This function performs addition on two user-entered integers. 

#### Test Case 1: ####
  + Input: 212345678 + 412134567
  + Expected Output: 624480245
  + Actual output: 624480245

#### Test Case 2: ####
  + Input: 0 + 0
  + Expected Output: 0
  + Actual Output: 0

#### Test Case 3: ####
  + Input: 800 + -350
  + Expected Output: 450
  + Actual Output: 450

#### Test Case 4: ####
  + Input: -900 + -2
  + Expected Output: -902
  + Actual Output: -902

#### Test Case 5: ####
  + Input: -900 + -2
  + Expected Output: -902
  + Actual Output: -902

#### Test Case 6: ####
  + Input: 2123456789 + 2123456789
  + Expected Output: -48053718 (Error: Arithmetic overflow)
  + Actual Output: -48053718 (Error: Arithmetic overflow)

#### Test Case 7: ####
  + Input: -2123456789 + -2123456789
  + Expected Output: 48053718 (Error: Arithmetic overflow)
  + Actual Output: 48053718 (Error: Arithmetic overflow)

#### Test Case 8: ####
  + Input: 2147483647 + 1
  + Expected Output: -2147483648 (Error: Arithmetic overflow)
  + Actual Output: -2147483648 (Error: Arithmetic overflow)

#### Test Case 9: ####
  + Input: -2147483647 + -1
  + Expected Output: 2147483648 (Error: Arithmetic overflow)
  + Actual Output: 2147483648 (Error: Arithmetic overflow)

### Test Cases for the do_subtract function ###
  The do_subtract function is being tested here. This function performs subtraction on two user-entered integers.

#### Test Case 1: ####
  + Input: 4 - 2
  + Expected Output: 2
  + Actual output: 2

#### Test Case 2: ####
  + Input: 0 - 0
  + Expected Output: 0
  + Actual output: 0

#### Test Case 3: ####
  + Input: -55 - -5
  + Expected Output: -50
  + Actual output: -50

#### Test Case 4: ####
  + Input: 5 - 5000
  + Expected Output: -4995
  + Actual output: -4995

#### Test Case 5: ####
  + Input: -55 - 5
  + Expected Output: 50
  + Actual output: 50

#### Test Case 6: ####
  + Input: 60 - -5
  + Expected Output: 65
  + Actual output: 65

#### Test Case 7: ####
  + Input: 2123456789 - -2123456789 
  + Expected Output: -48053718 (Error: Arithmetic overflow)
  + Actual output: -48053718 (Error: Arithmetic overflow)

### Test Cases for the do_multiply function ###
  The do_multiply function is being tested here. This function performs multiplication on two user-entered integers.

#### Test Case 1: ####
  + Input: 2 * 1 
  + Expected Output: 2
  + Actual output: 2

#### Test Case 2: ####
  + Input: 2 * -8 
  + Expected Output: -16
  + Actual output: -16

#### Test Case 3: ####
  + Input: -8 * 2 
  + Expected Output: -16
  + Actual output: -16

#### Test Case 4: ####
  + Input: -9 * -9 
  + Expected Output: 81
  + Actual output: 81

#### Test Case 5: ####
  + Input: 1 * 4 
  + Expected Output: 4
  + Actual output: 4

#### Test Case 6: ####
  + Input: 2147483647 * 2147483647 
  + Expected Output: 4611686014132420609
  + Actual output: 4611686014132420609

#### Test Case 7: ####
  + Input: 2 * 2
  + Expected Output: 4
  + Actual output: 4

#### Test Case 8: ####
  + Input: 4 * 0 
  + Expected Output: 0
  + Actual output: 0

#### Test Case 9: ####
  + Input: 0 * 4
  + Expected Output: 0
  + Actual output: 0

#### Test Case 10: ####
  + Input: 0 * 0
  + Expected Output: 0
  + Actual output: 0

### Test Cases for the do_divide function ###
  The do_divide function is being tested here. This function performs subtraction on two user-entered integers.

#### Test Case 1: ####
  + Input: 50 / 5
  + Expected Output: 10
  + Actual output: 10

#### Test Case 2: ####
  + Input: 38 / 12
  + Expected Output: 3 R 2
  + Actual output: 3 R 2

#### Test Case 3: ####
  + Input: 50 / -5
  + Expected Output: -10
  + Actual output: -10

#### Test Case 4: ####
  + Input: -50 / 5
  + Expected Output: -10
  + Actual output: -10

#### Test Case 5: ####
  + Input: 38 / -12
  + Expected Output: -3 R 2
  + Actual output: -3 R 2

#### Test Case 6: ####
  + Input: -38 / 12
  + Expected Output: -3 R -2
  + Actual output: -3 R -2

#### Test Case 7: ####
  + Input: 10 / 0
  + Expected Output: NaN
  + Actual output: NaN

#### Test Case 8: ####
  + Input: 0 / 0
  + Expected Output: NaN
  + Actual output: NaN

#### Test Case 9: ####
  + Input: 0 / 20
  + Expected Output: 0
  + Actual output: 0

#### Test Case 10: ####
  + Input: 0 / -7
  + Expected Output: 0
  + Actual output: 0

#### Test Case 11: ####
  + Input: 2 / -3 
  + Expected Output: 0 R 2
  + Actual output: 0 R 2

#### Test Case 12: ####
  + Input: -2 / 3
  + Expected Output: 0 R -2
  + Actual output: 0 R -2

## Problems: ##
  + Division of a very large number by a very small (magnitude not sign) number takes a considerable amount of time.

## Contributors: ##
+ Kaleshwar Singh 
+ Mahia Tasneem
