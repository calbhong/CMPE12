##########################################################################
# Created by:  Hong, Calvin
#              cbhong
#              19 May 2019
#
# Assignment:  Lab 04: Roman Numeral Conversion
#              CMPE 012, Computer Systems and Assembly Language
#              UC Santa Cruz, Spring 2019
# 
# Description: This program will read & convert a Roman numeral input that 
#              will be stored in $s0
#	          	
# Notes:      This program is intended to be run from the MARS IDE.
##########################################################################
# Pseudocode:
# entry prompt : "You entered the Roman numerals:"
# 	printNumeral :
#		print each character from program argument (Roman Num)
# 	validation : 
#		Iterate through roman num
#			Check if roman num does not contain valid ascii
#		numeralToInterger
#			Iterate over program argument
#				compare char int += char value
#				check nextChar if follow rules;
#					if(follows rule)
#						add more(IV, IX) etc. or less depending
#					else
#						throw error if invalid ASCII or does not follow romnum rules
#			all of the following calculations go to $s0
# binary prompt : "The binary representation is:" 
#	printBinary:
#		Convert interger to binary
#		implement print loop (avoid certain syscalls)
#
#		
##########################################################################

.data
	entryPrompt:	.asciiz "You entered the Roman numerals:\n"
	binaryPrompt:	.asciiz "\n\nThe binary representation is:\n0b"
	invalidPrompt:	.asciiz "\n\nError: Invalid program argument."
	binaryArray:	.word	32

.text
main:
	#entryPrompt
	la	$a0, entryPrompt
	li	$v0, 4 
	syscall
	#iterate over $t1 to echo input
	
	beqz	$a1, error #catch for any empty program arguments 
	
	numPrint:
		lw	$t1, ($a1)
		li	$v0, 11

		printNumChar: 
			lb	$t2, ($t1) 
			beqz    $t2, validate 	#$t2 loads current char & checks for null char/0;
			lb	$a0, ($t1)	
			syscall		  	#load & print char current char if passed 
			addi	$t1, $t1, 1 	#increment
			j printNumChar
	#interate over $t1 to validate & store final int in $s0
		
	validate:
	li	$s0, 0				#load $s0 with 0 honestly don't really need this line just making sure
	lw	$t1, ($a1)			#loads $t1 with input from $a1 again 
	validLoop:
		lb	$t2, ($t1) 			#loads byte/char to be compared (current char)
		beqz	$t2, intToBinary
		lb	$t3, 1($t1)			#loads byte/char to be compared (next char)
		beqz	$t2, intToBinary 
		#if subsequent character is null, jump to intToBinary assuming input did not throw any errors
	charComp:
		addi	$t1, $t1, 1
		beq	$t2, 0x43, charC		#compares current char with ASCII for CLXIV & bracnhes from there 
		beq	$t2, 0x4C, charL
		beq	$t2, 0x58, charX
		beq	$t2, 0x56, charV
		beq	$t2, 0x49, charI
		#beq	$t2, 0x44, charD 		
		j	error					#if char doesn't match any CLXIV, then it should throw an error
	charC:
		#$s1 C count (?)
		#max of 4 in a row(>= 	5 invalid)
		#int += 100
		beq	$s1, 5, error
		addi	$s1, $s2, 1	#Ccount++
		addi	$s0, $s0, 100
		j	validLoop
		#try to implement D if you have time later
	charL:
		#max of 1 $s5
		#int += 50
		#if nextChar C
		#	throw error
		bgtz 	$s2, error
		addi	$s2, $s2, 1	#Lcount++
		addi	$s0, $s0, 50
		beq	$t3, 0x43, error
		j	validLoop
		
	charX:
		#max of 4 in a row (>= 5 invalid)
		#int += 10
		#if nextChar L || C 
		#L: int += 40
		#C: int += 90
		beq	$s3, 5, error
		addi	$s3, $s3, 1
		beq	$t3, 0x4C, XL
		beq	$t3, 0x43, XC
		addi	$s0, $s0, 10
		j	validLoop
		XL:
			addi	$s0, $s0, 40
			addi 	$t1, $t1, 1
			j	validLoop
		XC:
			addi	$s0, $s0, 90
			addi 	$t1, $t1, 1
			j	validLoop
	charV:
		#max of 1
		#int += 5
		#if nextChar C||L||X
		#	throw error
		bgtz 	$s4, error
		addi	$s4, $s4, 1	#Lcount++
		addi	$s0, $s0, 5
		beq	$t3, 0x43, error	#C
		beq	$t3, 0x4C, error	#L
		beq	$t3, 0x58, error	#X
		j	validLoop		
	charI:
		#max of 4(>= 5 invalid)
		#int += 1
		#if nextChar V || X
		#V: int += 4
		#X: int += 9 
		#if nextChar L || C
		#	throw error
		beq	$s5, 5, error
		beq	$t3, 0x56, IV
		beq	$t3, 0x58, IX
		addi	$s5, $s5, 1
		addi	$s0, $s0, 1
		beq	$t3, 0x43, error	#C
		beq	$t3, 0x4C, error	#L
		j	validLoop
		IV:
			addi	$s0, $s0, 4
			addi 	$t1, $t1, 1
			j validLoop
		IX:
			addi	$s0, $s0, 9
			addi	$t1, $t1, 1
		
	#convert interger to binary & print
	#input already stored in $t1
	
	#check first char for valid entry; compare between valid 5 chats
	#if valid, add value to total ($s0)
	#check next char, if Char < nextChar, check if follows rules, else break & return error-> exit
	#use a register as a boolean (?) for valid/invalid input then check for 0-1 at the end

	intToBinary: 
		li	$v0, 4				#load & print binary output prompt
		la	$a0, binaryPrompt
		syscall
	
	
		addi	$t4, $t4, 0			#$t4 memory index
		li	$s2, 2			
		la	$s1, ($s0) 			#int n
		Biloop:				
			ble	$s1, $zero, binPrint	#while conditional
			rem	$s3, $s1, $s2		
			sw	$s3, binaryArray($t4)	#num[i] = n mod 2  
			div	$s1, $s1, $s2		#n = n / 2
			addi	$t4, $t4, 4		#mem += 4		
			j Biloop
		binPrint:
			ble   	$t4, $zero, exit	#checks if index has reached 0;
			addi 	$t4, $t4, -4		#decrement by 4
			lw	$t6, binaryArray($t4)	#loads current binary 
			
			li 	$v0, 11			#syscall to print characters
			beqz 	$t6, printZero		#branch on zero
			la $a0, 0x31				
			syscall				#syscall to print 1 ASCII(0x31)
			j binPrint			
			printZero:
				la $a0, 0x30
				syscall			#branch to print 0 ASCII(0x30)
				j binPrint
				

	error:
		li	$v0, 4
		la	$a0, invalidPrompt
		syscall
		j exit
	exit:
		li $v0, 11
		la $a0, 0x0A
		syscall
		li 	$v0, 10
		syscall
