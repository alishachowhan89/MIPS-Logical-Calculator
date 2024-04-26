.include "./cs47_proj_macro.asm"
.text
.globl au_normal
# TBD: Complete your project procedures
# Needed skeleton is given
#####################################################################
# Implement au_normal
# Argument:
# 	$a0: First number
#	$a1: Second number
#	$a2: operation code ('+':add, '-':sub, '*':mul, '/':div)
# Return:
#	$v0: ($a0+$a1) | ($a0-$a1) | ($a0*$a1):LO | ($a0 / $a1)
# 	$v1: ($a0 * $a1):HI | ($a0 % $a1)
# Notes:
#####################################################################
au_normal:
# TBD: Complete it
	beq 	$a2, '+', addition  		#if $a2 register is equal to + then call addition
	beq 	$a2, '-', subtraction 		#if $a2 register is equal to - then call subtraction
	beq 	$a2, '*', multpilication 	#if $a2 register is equal to * then call multpilication
	beq 	$a2, '/', divison 		#if $a2 register is equal to / then call divison
	
addition:
	add 	$v0, $a0, $a1 			#$v0 = $a0 + $a1, doing addition of two registers
	j   	exit 				#jump to exit after running addition function/label
	

subtraction:
	sub 	$v0, $a0, $a1			#$v0 = $a0 - $a1, doing subtraction of two registers
	j   	exit				#jump to exit after running subtraction function/label

multpilication:
	mult 	$a0, $a1			#$a0 * $a1 and stores 64 bit result into hi and lo registers		
	mflo 	$v0				#$v0 set to mflo 
	mfhi 	$v1				#$v1 set to mfhi 
	j    	exit				#jump to exit after running subtraction function/label

divison:
	div 	$a0, $a1			#$a0/$a1 and stores quotient value in lo and remainder in hi
	mflo 	$v0				#$v0 set to mflo 
	mfhi 	$v1				#$v1 set to mfhi 
	j    	exit				#jump to exit after running subtraction function/label
	
exit: 	
	jr	$ra 				#jump register to calling program
