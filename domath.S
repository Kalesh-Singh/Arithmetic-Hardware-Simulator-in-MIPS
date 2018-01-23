# domath.S 
# Mahia Tasneem
# Gedare Bloom
#

# Variables in the .data section.
.data

# string var named prompt
prompt: .asciiz "Please enter an integer: "

# Instructions in the .text section.
.text

# main() is the program entry point. It is responsible for
# reading two integers and an operator, and passing the read
# values to do_math
main:
	# maintain a proper call stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# print the prompt message 
	li $v0, 4
	la $a0, prompt
	syscall

	# read an integer from user
	li $v0, 5
	syscall

	# put input integer into argument register
	or $a0, $v0, $zero

	# TODO: print the operator prompt, and read the operator

	# TODO: print prompt message and read another integer

	# TODO: call do_math(integer, operator, integer)

	# Restore return address and unwind the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# TODO: return 0

# do_math takes three register arguments containing two integers (X, Y)
# and a character indicating an arithmetic operator (OP),
# invokes a subroutine to calculate X OP Y, and
# prints the result or an error message.
do_math:
	# TODO: implement do_math
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

