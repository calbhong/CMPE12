##########################################################################
# Created by:  Hong, Calvin
#              cbhong
#              12 May 2019
#
# Assignment:  Lab 03: MIPS!
#              CMPE 012, Computer Systems and Assembly Language
#              UC Santa Cruz, Spring 2019
# 
# Description: This program will prompt the use for an interger between 0 & 10
#	       calculate the factorial.	
# 
# Notes:       This program is intended to be run from the MARS IDE.
##########################################################################

.data
	prompt:  .asciiz  "Enter an integer between 0 and 10: "
	message: .asciiz  "! = "
	error:   .asciiz  "\nInvalid entry!\n"
	input:	 .word	  0	
	output:  .word    0
.text	
.globl  main
main:
	li $s0, 11	
.globl L1
L1:
	#Prompt & get user input
	li $v0, 4
	la $a0, prompt
	syscall

	li $v0, 5
	syscall
		
	sw $v0, input
	#check if less than 0
	slt $s1, $v0, $zero
	bne $s1, $zero, L4
	#check if greater than 10 
	bge $v0, $s0, L4
	
	j L2
.globl L4
L4:
	li $v0, 4
	la $a0, error
	syscall
	li $v0, 11
	la $a0, 0x0A
	syscall
	j L1

.globl findFactorial
findFactorial:
	
	move $t4, $a0
	li $t1, 1
	li $t2, 1
	
	loop:
		bgt $t2, $t4, end
		mul $t1, $t1, $t2
		addi $t2, $t2, 1
		j loop
	end:
		sw $t1, output
		j L3


.globl L2
L2:
	#Factorial function
	lw $a0, input
	jal findFactorial
	

.globl L3
L3:
	#Display output 
	#using sys11 for newline character
	li $v0, 11
	la $a0, 0x0A
	syscall
	
	li $v0, 1
	lw $a0, input
	syscall
	
	li $v0, 4
	la $a0, message
	syscall
		
	li $v0, 1
	lw $a0, output
	syscall
	
	li $v0, 11
	la $a0, 0x0A
	syscall
			
	#End program
	li $v0, 10
	syscall
