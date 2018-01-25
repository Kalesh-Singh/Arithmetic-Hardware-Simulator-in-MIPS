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
	# TODO: fix do_math

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
		li $a0, 32      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the sign character
		li $v0, 11
		add $a0, $a2, $zero
		syscall

		# Print a space
		li $v0, 11
		li $a0, 32      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the 2nd integer
		li $v0, 1
		add $a0, $a3, $zero
		syscall

		# Print space
		li $v0, 11
		li $a0, 32      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the equal sign charcter
        li $v0, 11
		li $a0, 61      # 61 - Is the ASCII decimal value of '='
		syscall

		# Print space
		li $v0, 11
		li $a0, 32      # 32 - Is the ASCII decimal value of ' '
		syscall

		# Print the integer result
		beq $t1, 0, result_32bits
		
		result_32bits:
			li $v0, 1
			add $a0, $t0, $zero
			syscall

	# Restore return address and unwind the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	return:
		jr $ra

do_add:
	# TODO: implement do_add
	add $v0, $a0, $a1 # FIXME: add is not allowed!
	jr $ra

do_subtract:
	# TODO: implement do_subtract
	sub $v0, $a0, $a1 # FIXME: sub is not allowed!
	jr $ra

do_multiply:
	# TODO: implement do_multiply
	mult $a0, $a1 # FIXME: mult is not allowed!
	mfhi $v1
	mflo $v0
	jr $ra

do_divide:
	# TODO: implement do_divide
	div $a0, $a1 # FIXME: div is not allowed!
	mfhi $v1 # remainder
	mflo $v0 # quotient
	jr $ra

