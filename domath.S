# domath.S 
# Kaleshwar Singh
# Mahia Tasneem
# Gedare Bloom
#

# Variables in the .data section.
.data
    prompt1:    .asciiz     "Please enter an integer: "
	prompt2:    .asciiz     "Please enter an operator (+, -, *, /): "
	error_msg:  .asciiz     "Error: invalid arithmetic operation 'OP'." 
	largeNum:	.space		20

# Instructions in the .text section.
.text

# main() is the program entry point. It is responsible for
# reading two integers and an operator, and passing the read
# values to do_math
main:
	# Maintain a proper call stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

    # Prompt the user to enter the 1st integer
	li $v0, 4
	la $a0, prompt1
	syscall

	# Read the 1st integer
	li $v0, 5
	syscall

	# Put input integer into argument register
	add $a1, $v0, $zero
    
	# Prompt the user to enter the sign
	li $v0, 4
	la $a0, prompt2
	syscall
	
	# Read the the sign character
	li $v0, 12
	syscall
	
	# Put the input sign into argument register
	add $a2, $v0, $zero

	# Prompt the user to enter the 2nd integer
	li $v0, 4
	la $a0, prompt1
	syscall 

	# Read the 2nd integer
	li $v0, 5
	syscall
	
	# Put input integer into argument register
	add $a3, $v0, $zero
	
	# Call do_math
	jal do_math

	# Restore return address and unwind the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# TODO: return 0 from main using jr (do not use the 'exit' syscall)

	# TODO: Delete this after fixing the above return
	Exit:
		li $v0, 10
		syscall

# do_math takes three register arguments containing two integers (X, Y)
# and a character indicating an arithmetic operator (OP),
# invokes a subroutine to calculate X OP Y, and
# prints the result or an error message.

do_math:

	# Maintain a proper call stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

    addition:
		bne $a2, '+', subtraction
		jal do_add
		j print_result
	
	subtraction:
		bne $a2, '-', multiplication
		jal do_subtract
		j print_result

	multiplication:
		bne $a2, '*', division
		
		li $s0, 0			# We will use $s0 to manage the sign of our multiplication
		
		bgt $a1, 0, secondNumNegative
		sub $a1, $zero, $a1		# Convert to absolute value
		addi $s0, $s0, 1

		secondNumNegative:
			bgt $a3, 0, bothPosOrNeg
			sub $a3, $zero, $a3		# Convert to absolute value
			addi $s0, $s0, 1

		bothPosOrNeg:
			jal do_multiply
			j print_result

    division:
		bne $a2, '/', error
		jal do_divide
		j print_result

	error:
		li $v0, 4
		la $a0, error_msg
		syscall

	print_result:
		# Get the result returned from the operation
		add $t0, $v0, $zero
		add $t1, $v1, $zero

        # Print the 1st integer
		li $v0, 1
		add $a0, $a1, $zero
		syscall

        # Print a space
		li $v0, 11
		li $a0, ' '      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the sign character
		li $v0, 11
		add $a0, $a2, $zero
		syscall

		# Print a space
		li $v0, 11
		li $a0, ' '      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the 2nd integer
		li $v0, 1
		add $a0, $a3, $zero
		syscall

		# Print space
		li $v0, 11
		li $a0, ' '      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the equal sign charcter
        li $v0, 11
		li $a0, '='      # 61 - Is the ASCII decimal value of '='
		syscall

		# Print space
		li $v0, 11
		li $a0, ' '      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the integer result
		beq $a2, '*', multiply	# If sign is '*' --> multiply
		
		result_32bits:
			li $v0, 1
			add $a0, $t0, $zero
			syscall
		
		bne $a2, '/', return		# If sign argument is not '/' --> return
		
		# Print space
		li $v0, 11
		li $a0, ' '      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the remainder for division
		# Print 'R' for remainder
		li $v0, 11
		li $a0, 'R'		# 82 == 'R'
		syscall
		
		# Print space
		# li $v0, 11
		# li $a0, 32      # 32 - Is the ASCII decimal value of ' '
		# syscall

		# Print the remainder from $t1
		li $v0, 1
		add $a0, $t1, $zero
		syscall

		multiply:
			# Check and print the sign of the product
			bne $s0, 1, setArgs				# If the number of negative signs is not 1 --> Set args
			li $v0, 11
			li $a0, '-'
			syscall

			beq $t1, 0, result_32bits
			
			setArgs:
				addi $a0, $t0, 0
				addi $a1, $t1, 0
				jal print64bitNum

	return:
		# Restore return address and unwind the stack
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

do_add:
	# TODO: implement do_add
	add $v0, $a1, $a3 # FIXME: add is not allowed!
	jr $ra

do_subtract:
	# TODO: implement do_subtract
	sub $v0, $a1, $a3 # FIXME: sub is not allowed!
	jr $ra

do_multiply:
	li $v0, 0					# Initialize the lo register ($v0) to 0
	li $v1, 0					# Initialize the hi register ($v1) to 0

	addi $t0, $a1, 0					# Initialize add0 register to the multiplier
	li $t1, 0					# Initialize add1 register to 0
	
	addi $t5, $a3, 0				# Copy the multiplier
		
	li $t2, 0					# Initialize a counter to 0

	loop4:
		# Check if the multiplier bit is 1
		andi $t3, $t5, 1		# If $t3 is 1 then the multiplier bit was 1
		bne $t3, 1, next		# Else --> next
		
		# Handles for addition and overflow form lo
		addi $t3, $v0, 0			# Get the MSB of $v0
		srl $t3, $t3, 31

		addi $t4, $t0, 0			# Get the MSB of $t0
		srl $t4, $t4, 31

		add $t3, $t3, $t4			# Sum the 2 MSBs

		beq $t3, 0, noOverflow		# If the sum == 0 --> noOverflow
		beq $t3, 2, overflow		# If the sum == 2 --> overflow
		
		addu $v0, $v0, $t0	
		
		addi $t3, $v0, 0		# Get the MSB of $v0
		srl $t3, $t3, 31
		
		beq $t3, 0, overflow2
		j noOverflow
		
		
		overflow:
			addi $v1, $v1, 1			# Else add 1 to the high register
			addu $v0, $v0, $t0
			addu $v1, $v1, $t1		# Addition of add1 and hi
			j next
			
		overflow2:
			addi $v1, $v1, 1
			addu $v1, $v1, $t1
			j next
			
		noOverflow:
			addu $v0, $v0, $t0
			addu $v1, $v1, $t1		# Addition of add1 and hi

		next:
			addi $t3, $t0, 0		# Get the MSB of the add0 register
			srl $t3, $t3, 31

			sll $t0, $t0, 1			# Shift add0 register left by 1
			sll $t1, $t1, 1			# Shift add1 register left by 1

			add $t1, $t1, $t3		# Add the MSB of add0 reg to add1 reg
		
			srl $t5, $t5, 1			# Shift the multiplier right by 1
			addi $t2, $t2, 1		# Increment the counter
			beq $t2, 32, return3	# If shift == 32 --> return3
			j loop4

	 return3:
		#mult $a1, $a3
		#mfhi $v1
		#mflo $v0
		jr $ra

do_divide:
	# TODO: implement do_divide
	div $a1, $a3 # FIXME: div is not allowed!
	mfhi $v1 # remainder
	mflo $v0 # quotient
	jr $ra

print64bitNum:
	# Get the arguments
	addi $t0, $a0, 0
	addi $t1, $a1, 0

	li $t2, 0				# Initialize the digit count to 0
	li $t3, 19				# Set the index of the least significant digit to 19
	li $t4, 16				# Set the divisor to 16
	li $t5, 0				# Initialize a counter to 0

	loop1:
		addi $t5, $t5, 1					# Increment the counter
		divu $t0, $t4						# Divide the number in the lower register by 16
		mflo $t0							# Set the dividend to the quotient
		mfhi $t6							# Get the remainder
		addi $sp, $sp, -1					# Store the reaminder on the stack
		sb $t6, 0($sp)						# We can use a byte to store since the largest resminder is 15
		beq $t5, 8, loop2					# If we have divided by 16 eight time --> loop2
		j loop1

	loop2:
		addi $t5, $t5, 1					# Increment the counter
		divu $t1, $t4						# Divide the number in the higher register by 16
		mflo $t1							# Set the dividend to the quotient
		mfhi $t6							# Get the remainder
		addi $sp, $sp, -1					# Store the remainder on the stack
		sb $t6, 0($sp)	
		# beq $t5, 16, decimal					
		beq $t1, 0, decimal					# If dividend == 0 --> decimal
		j loop2

	decimal:
		# Ensure that the remainder register is set to 0 before beginning
		divu $t4, $t4						# Sets hi to 0
		li $t0, 10							# Set the divisor to 10
		li $t1, 0							# Initialize a second counter to 0

		loop3:
			mfhi $t6						# Get the remainder
			mult $t6, $t4					# Multiply the remainder by 16
			mflo $t6						# Get the resulting product
			
			lb $t7, 0($sp)					# Get the hexadecimal digit
			add $t7, $t7, $t6				# Add (remainder * 16) to the hex digit
			divu $t7, $t0					# Divide the result by 10
			mflo $t6						# Get the quotient
			sb $t6, 0($sp)					# Store the quotient on the stack
			addi $sp, $sp, 1

			addi $t1, $t1, 1				# Increment the second counter

			beq $t5, $t1, saveDigit			# If the 2 counters are equal --> saveDigit

			j loop3
		
		saveDigit:
			la $t6, largeNum				# Get the address of the space to store the number
			add $t6, $t6, $t3				# Add the digit index to the address
			mfhi $t7						# Get the remainder
			sb $t7, 0($t6)					# Store the digit in its correct position
			addi $t3, $t3, -1				# Decrement the digit index
			beq $t3, -1, continue			# If digit index == -1 --> continue
			sub $sp, $sp, $t1				# Reset the stack pointer to the position of the first digit
			j decimal

	continue:
		la $t6, largeNum					# Get the address of the space where the digits were stored
	
	digits:
		lb $t7, 0($t6)						# Get the stored digit
		bne $t7, 0, printDigits				# If digit > 0 --> printDigits
		addi $t2, $t2, 1					# Increment the digit count
		addi $t6, $t6, 1					# Increment the address
		j digits

	printDigits:
		lb $a0, 0($t6)						# Load the digit to print
		li $v0, 1							# Print the digit
		syscall

		addi $t2, $t2, 1					# Increment the digit count
		addi $t6, $t6, 1					# Increment the address
		beq $t2, 20, return2 				# If digit count == 20 --> return
		j printDigits

	return2:
		jr $ra
