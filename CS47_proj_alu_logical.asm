.include "./cs47_proj_macro.asm"
.text
.globl au_logical
# TBD: Complete your project procedures
# Needed skeleton is given
#####################################################################
# Implement au_logical
# Argument:
# 	$a0: First number
#	$a1: Second number
#	$a2: operation code ('+':add, '-':sub, '*':mul, '/':div)
# Return:
#	$v0: ($a0+$a1) | ($a0-$a1) | ($a0*$a1):LO | ($a0 / $a1)
# 	$v1: ($a0 * $a1):HI | ($a0 % $a1)
# Notes:
#####################################################################
au_logical:
	#this is store frame, allocating memory from stack to store in registers
	addi	$sp, $sp, -56				#taking 56 bits of memory out of $sp aka stack pointer	
	sw	$a0, 56($sp) 				#stores $a0 into memory at the address 56+$sp	
	sw	$a1, 52($sp)				#stores $a1 into memory at the address 52+$sp	
	sw	$a2, 48($sp)				#stores $a2 into memory at the address 48+$sp	
	sw	$a3, 44($sp)				#stores $a3 into memory at the address 44+$sp	
	sw	$s0, 40($sp)				#stores $s0 into memory at the address 40+$sp	
	sw	$s1, 36($sp)				#stores $s1 into memory at the address 36+$sp	
	sw	$s2, 32($sp)				#stores $s2 into memory at the address 32+$sp	
	sw	$s3, 28($sp)				#stores $s3 into memory at the address 28+$sp	
	sw	$s4, 24($sp)				#stores $s4 into memory at the address 24+$sp	
	sw	$s5, 20($sp)				#stores $s5 into memory at the address 20+$sp	
	sw	$s6, 16($sp)				#stores $s6 into memory at the address 16+$sp	
	sw	$s7, 12($sp)				#stores $s7 into memory at the address 12+$sp	
	sw	$fp, 8($sp)				#stores $fp into memory at the address 8+$sp	
	sw	$ra, 4($sp)				#stores $ra into memory at the address 4+$sp	
	addi	$fp, $sp, 56				#$fp is memory of $sp+56
	
	beq 		$a2, '+', addition 		#branch if equal to respective operation
	beq 		$a2, '-', subtraction
	beq 		$a2, '*', mul_signed
	beq 		$a2, '/', div_signed
	j 		au_logical_return		#jump to au_logical_return label

addition:
	#this is store frame, allocating memory from stack to store in registers
	addi 		$sp, $sp, -24 			#taking 24 bits of memory out of $sp aka stack pointer	
	sw 		$s0, 24($sp)			#stores $s0 into memory at the address 24+$sp	
	sw 		$s1, 20($sp)			#stores $s1 into memory at the address 20+$sp	
	sw 		$a0, 16($sp)			#stores $a0 into memory at the address 16+$sp	
	sw 		$a1, 12($sp)			#stores $a1 into memory at the address 12+$sp	
	sw 		$a2, 8($sp)			#stores $a2 into memory at the address 8+$sp	
	sw 		$fp, 4($sp)			#stores $fp into memory at the address 4+$sp	
	sw 		$ra, 0($sp)			#stores $ra into memory at the address 0+$sp	
	addi 		$fp, $sp, 24			#$fp is memory of $sp+24
	
	# initializing variables for addition
	move  		$s0, $0   			#$s0 is digit counter 
	move 		$v0, $0   			#$v0 is final result 
	move 		$a2, $0  			 #$a2 is the carry digit
	jal		add_sub_loop   			#jump and links to add_sub_loop 
	
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw 		$s0, 24($sp)			#loads $s0 at address 24+$sp
	lw 		$s1, 20($sp)			#loads $s1 at address 20+$sp
	lw 		$a0, 16($sp)			#loads $a0 at address 16+$sp
	lw 		$a1, 12($sp)			#loads $a1 at address 12+$sp
	lw 		$a2, 8($sp)			#loads $a2 at address 8+$sp
	lw 		$fp, 4($sp)			#loads $fp at address 4+$sp
	lw 		$ra, 0($sp)			#loads $ra at address 0+$sp
	addi 		$sp, $sp, 24			#taking 24 bits of memory from $sp
	jr 		$ra

subtraction:
	#this is store frame, allocating memory from stack to store in registers
	addi 		$sp, $sp, -24 			#taking 24 bits of memory out of $sp aka stack pointer	
	sw 		$s0, 24($sp)			#stores $s0 into memory at the address 24+$sp	
	sw 		$s1, 20($sp)			#stores $s1 into memory at the address 20+$sp	
	sw 		$a0, 16($sp)			#stores $a0 into memory at the address 16+$sp	
	sw 		$a1, 12($sp)			#stores $a1 into memory at the address 12+$sp	
	sw 		$a2, 8($sp)			#stores $a2 into memory at the address 8+$sp	
	sw 		$fp, 4($sp)			#stores $fp into memory at the address 4+$sp	
	sw 		$ra, 0($sp)			#stores $ra into memory at the address 0+$sp	
	addi 		$fp, $sp, 24			#$fp is memory of $sp+24
	
	# initializing variables for subtraction
	move 		$s0, $0				#move $0 into $s0 
	move		$v0, $0				#move $0 into $v0
	move		$a2, $0				#move $0 into $a2
	
	#technically everything is addition logic, not will just negate $a2 making it a subtraction logic
	not 		$a1, $a1			#not of $a1
	not 		$a2, $a2			#not of $a2
	jal		add_sub_loop			#jump and link to add_sub_loop
	
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw 		$s0, 24($sp)			#loads $s0 at address 24+$sp
	lw 		$s1, 20($sp)			#loads $s1 at address 20+$sp
	lw 		$a0, 16($sp)			#loads $a0 at address 16+$sp
	lw 		$a1, 12($sp)			#loads $a1 at address 12+$sp
	lw 		$a2, 8($sp)			#loads $a2 at address 8+$sp
	lw 		$fp, 4($sp)			#loads $fp at address 4+$sp
	lw 		$ra, 0($sp)			#loads $ra at address 0+$sp
	addi 		$sp, $sp, 24			#taking 24 bits of memory from $sp
	jr 		$ra

#loop of addition and subtraction involving carry. Used in both but subtraction is just a negation and then addition
add_sub_loop:
	#$a2 is used to store the carry digit
	extract_nth_bit($t6, $a0, $s0) 			#extracts nth bit from $a0, first number
	extract_nth_bit($t5, $a1, $s0) 			#extracts nth bit from $a1, second number
	xor 		$t4, $t6, $t5  			#xor is used to add the nth bit with $a2(carry digit)
	xor 		$t3, $t4, $a2
	and 		$t2, $t6, $t5 
	and 		$t1, $t4, $a2
	or 		$a2, $t2, $t1
	insert_to_nth_bit($s1, $s0, $t3, $t6) 		#inserts sum stored in $t3 to the nth bit($s0)
	addi 		$s0, $s0, 1 			#increments, $s0 = $s0 + 1
	beq 		$s0, 32, exit_add_sub_loop 	#if $s0=32 then go to exit_add_sub_loop
	j 		add_sub_loop               	#jump to add_sub_loop

exit_add_sub_loop: 
	move 		$v0, $s1 			#move $s1 content to $v0
	move 		$v1, $a2			#move $a2 content to $v1
	jr 		$ra

#------------------- MULTIPLICATION (04/28) -------------------------------------------------------------------------------------------
twos_complement:
	#this is store frame, allocating memory from stack to store in registers
	addi $sp, $sp, -16				#taking 16 bits of memory out of $sp aka stack pointer	
	sw $a0, 16($sp)					#stores $a0 into memory at the address 16+$sp	
	sw $a1, 12($sp)					#stores $a1 into memory at the address 12+$sp	
	sw $fp, 8($sp)					#stores $fp into memory at the address 8+$sp	
	sw $ra, 4($sp)					#stores $ra into memory at the address 4+$sp	
	addi $fp, $sp, 16				#$fp is memory of $sp+16
	
	#'-$a0 + 1", making $a1 equal to 1 so we can make -$a0+1
	not $a0, $a0					#negation of $a0
	ori $a1, $0, 1 					#setting $a1 to 1
	jal addition					#jump and link to addition label 
	
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw $a0, 16($sp)					#loads $a0 at address 16+$sp
	lw $a1, 12($sp)					#loads $a1 at address 12+$sp
	lw $fp, 8($sp)					#loads $fp at address 8+$sp
	lw $ra, 4($sp)					#loads $ra at address 4+$sp
	addi $sp, $sp, 16				#taking 16 bits of memory from $sp
	jr $ra
	
twos_compl_if_negative:
	#this is store frame, allocating memory from stack to store in registers
	addi $sp, $sp, -12				#taking 12 bits of memory out of $sp aka stack pointer
	sw $a0, 12($sp)					#stores $a0 into memory at the address 12+$sp
	sw $fp, 8($sp)					#stores $fp into memory at the address 8+$sp
	sw $ra, 4($sp)					#stores $ra into memory at the address 4+$sp
	addi $fp, $sp, 12				#$fp is memory of $sp+12
	bltz $a0, twos_compl_neg			#is $a0 less than zero go to twos_complement_neg label

twos_compl_pos:
	move $v0, $a0 					#move content of $a0 to $v0
	j twos_compl_end 				# jump to end

twos_compl_neg:
	jal twos_complement				#jump and link to twos_complement label
	move $a0, $v0 					# move the result to a0

twos_compl_end:
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw $a0, 12($sp) 				#loads $a0 at address 12+$sp	
	lw $fp, 8($sp)					#loads $a0 at address 8+$sp	
	lw $ra, 4($sp)					#loads $a0 at address 4+$sp	
	addi $sp, $sp, 12				#taking 12 bits of memory from $sp
	jr $ra

twos_complement_64bit:
	#this is store frame, allocating memory from stack to store in registers
	addi $sp, $sp, -24				#taking 24 bits of memory out of $sp aka stack pointer			
	sw $a0, 24($sp)					#stores $a0 into memory at the address 24+$sp	
	sw $a1, 20($sp)					#stores $a1 into memory at the address 20+$sp
	sw $s6, 16($sp)					#stores $s6 into memory at the address 16+$sp
	sw $s7, 12($sp)					#stores $s7 into memory at the address 12+$sp
	sw $fp, 8($sp)					#stores $fp into memory at the address 8+$sp
	sw $ra, 4($sp)					#stores $ra into memory at the address 4+$sp
	addi $fp, $sp, 24				#$fp is memory of $sp+24

	
	#logical not
	not $a0, $a0					#negation of $a0
	not $a1, $a1					#negation of $a1
	move $s6, $a1					#move contents of $a1 to $s6
	ori $a1, $0, 1					#setting $a1 to 1
	jal addition					#jump and link to addition label

	move $s7, $v0					#move content of $v0 to $s7
	move $a0, $v1					#move content of $v1 to $a0
	move $a1, $s6					#move content of $s6 to $a1
	jal addition					#jump and link addition
	move $v1, $v0					#move content of $v0 to $s7
	move $v0, $s7					#move content of $s7 to $v0
	
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw $a0, 24($sp)					#loads $a0 at address 24+$sp
	lw $a1, 20($sp)					#loads $a1 at address 20+$sp
	lw $s6, 16($sp)					#loads $s6 at address 16+$sp
	lw $s7, 12($sp)					#loads $s7 at address 12+$sp
	lw $fp, 8($sp)					#loads $fp at address 8+$sp
	lw $ra, 4($sp)					#loads $ra at address 4+$sp
	addi $sp, $sp, 24				#taking 24 bits of memory from $sp
	jr $ra

bit_replicator:
	#this is store frame, allocating memory from stack to store in registers
	addi $sp, $sp, -12				#taking 12 bits of memory out of $sp aka stack pointer	
	sw $a0, 12($sp)					#stores $a0 into memory at the address 12+$sp
	sw $fp, 8($sp)					#stores $fp into memory at the address 8+$sp
	sw $ra, 4($sp)					#stores $ra into memory at the address 4+$sp
	addi $fp, $sp, 12				#$fp is memory of $sp+12
	
	beq $a0, 0x0, bit_replicator_zero		#if $a0 = 0 then go to bit_replicator_zero label
	beq $a0, 0x1, bit_replicator_one		#if $a0 = 1 then go to bit_replicator_one label 
	
bit_replicator_zero:
	la $v0, ($zero)					#load 0 to $v0
	j bit_replicator_end				#jump to bit_replicator_end label
	
bit_replicator_one:
	la $v0, ($zero)					#load 0 to $v0
	not $v0, $v0					#negate $v0
	j bit_replicator_end				#jump to bit_replicator_end label

bit_replicator_end:
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw $a0, 12($sp)					#loads $a0 at address 12+$sp		
	lw $fp, 8($sp)					#loads $fp at address 8+$sp
	lw $ra, 4($sp)					#loads $ra at address 4+$sp
	addi $sp, $sp, 12				#taking 12 bits of memory from $sp
	jr $ra						#this label is what ends the bit_replicator

mul_unsigned:
	#this is store frame, allocating memory from stack to store in registers
	addi $sp, $sp, -44				#taking 44 bits of memory out of $sp aka stack pointer	
	sw $a0, 44($sp)					#stores $a0 into memory at the address 44+$sp
	sw $a1, 40($sp)					#stores $a1 into memory at the address 40+$sp
	sw $a2, 36($sp)					#stores $a2 into memory at the address 36+$sp
	sw $s0, 32($sp)					#stores $s0 into memory at the address 32+$sp
	sw $s1, 28($sp)					#stores $s1 into memory at the address 28+$sp
	sw $s2, 24($sp)					#stores $s2 into memory at the address 24+$sp
	sw $s3, 20($sp)					#stores $s3 into memory at the address 20+$sp
	sw $s4, 16($sp)					#stores $s4 into memory at the address 16+$sp
	sw $s5, 12($sp)					#stores $s5 into memory at the address 12+$sp
	sw $fp, 8($sp)					#stores $fp into memory at the address 8+$sp
	sw $ra, 4($sp)					#stores $ra into memory at the address 4+$sp
	addi $fp, $sp, 44				#$fp is memory of $sp+44
	
	# getting the unsigned loop ready before execution
	addi $s0, $zero, 0				#add 0 and 1 to $s0
	addi $s1, $zero, 0				#add 0 and 1 to $s1
	move $s2, $a0					#move $a0 to $s2
	move $s3, $a1					#move $a1 to $a3
	
mul_unsign_lp:
	extract_nth_bit($t8, $s3, $zero)		#passing $t8, $t3, $zero to extract_nth_bit 
	move $a0, $t8					#move $t8 into $a0
	jal bit_replicator				#jump and link bit_replicator
	move $s4, $v0					#move $v0 into $s4
	and $s5, $s2, $s4  				#$s5 set to the AND of $s2 and $s4			
	move $a0, $s5					#move $s5 into $a0
	move $a1, $s1					#move $s1 into $a1
	jal addition					#jump and link to addition label
	move $s1, $v0					#move $v0 into $s1
	srl $s3, $s3, 1	 				#shift $s3 right by 1 and then store
	extract_nth_bit($t3, $s1, $zero)		#call extract_nth_bit label with respective parameters
	addi $t4, $zero, 31				#adds immediate value of 31 to $t4 			
	insert_to_nth_bit($s3, $t4, $t3, $t5)		#calls insert_to_nth_bit with respective parameters
	srl $s1, $s1, 1					#shift $s0 right by 1 and store in $s0
	addi $s0, $s0, 1				#add one to $s0 and store
	beq $s0, 32, mul_unsign_end			#if $s0 = 32 then go to mul_unsign_end
	j mul_unsign_lp					#jump to mul_usign_lp label
	
mul_unsign_end:	
	move $v0, $s3					#move $s3 into $v0
	move $v1, $s1					#move $s1 into $v1
	
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw $a0, 44($sp)					#loads $a0 at address 44+$sp
	lw $a1, 40($sp)					#loads $a1 at address 40+$sp
	lw $a2, 36($sp)					#loads $a2 at address 36+$sp
	lw $s0, 32($sp)					#loads $s0 at address 32+$sp
	lw $s1, 28($sp)					#loads $s1 at address 28+$sp
	lw $s2, 24($sp)					#loads $s2 at address 24+$sp
	lw $s3, 20($sp)					#loads $s3 at address 20+$sp
	lw $s4, 16($sp)					#loads $s4 at address 16+$sp
	lw $s5, 12($sp)					#loads $s5 at address 12+$sp
	lw $fp, 8($sp)					#loads $fp at address 8+$sp
	lw $ra, 4($sp)					#loads $ra at address 4+$sp
	addi $sp, $sp, 44				#$fp is memory of $sp+44			
	jr $ra

mul_signed:
	move $s0, $a0					#move $a0 into $s0
	move $s1, $a1					#move $a1 into $s1
	move $s2, $zero					#move 0 into $s2
	move $s3, $zero					#move 0 into $s3
	
	# this is the two complement portion of the code
	jal twos_compl_if_negative			#jump and link to twos_compl_if_negative label
	move $s2, $v0					#move $v0 into $s2
	move $a0, $s1					#move $s1 into $a0
	jal twos_compl_if_negative			#jump and link to twos_compl_if_negative label
	move $s3, $v0					#move $v0 into $s3
	
	#setting up registers for multiplication
	move $a0, $s2					#move $s2 into $a0
	move $a1, $s3					#move $s3 into $a1
	
	#does the multiplication
	jal mul_unsigned				#jump and link to mul_unsigned
	move $a0, $v0					#move $v0 into $a0
	move $a1, $v1					#move $v1 into $a1
	
	# this portion of code determines sign of the resulting value
	li $t9, 31					#load 31 bits into $t9
	extract_nth_bit($t7, $s0, $t9)			#calls the extract_nth_bit with respective parameters
	extract_nth_bit($t8, $s1, $t9)			#calls the extract_nth_bit with respective parameters
	xor $t6, $t7, $t8 				# exclusive or of $t7 anf $t8 and store result in $t6
	beqz $t6, mul_sign_end				#if $t6 = 0 then go to mul_sign_end
	jal twos_complement_64bit			#jump and link twos_complement_64bit label
	
mul_sign_end:
	j au_logical_return				#this is what keeps multiplicsation portion from going into infinte loop

#----------------------DIVISION (04/30)--------------------------------------------------------------------------------------------------------
div_unsigned:
	#this is store frame, allocating memory from stack to store in registers
	addi $sp, $sp, -40				#taking 40 bits of memory out of $sp aka stack pointer
	sw $a0, 40($sp)					#stores $a0 into memory at the address 40+$sp
	sw $a1, 36($sp)					#stores $a1 into memory at the address 36+$sp
	sw $a2, 32($sp)					#stores $a2 into memory at the address 32+$sp
	sw $s0, 28($sp)					#stores $s0 into memory at the address 28+$sp
	sw $s1, 24($sp)					#stores $s1 into memory at the address 24+$sp
	sw $s2, 20($sp)					#stores $s2 into memory at the address 20+$sp
	sw $s3, 16($sp)					#stores $s3 into memory at the address 16+$sp
	sw $s4, 12($sp)					#stores $s4 into memory at the address 12+$sp
	sw $fp, 8($sp)					#stores $fp into memory at the address 8+$sp
	sw $ra, 4($sp)					#stores $ra into memory at the address 4+$sp
	addi $fp, $sp, 40				#$fp is memory of $sp+40
	
	#setting up registers for divison 
	move $s0, $0					#move $0 into $s0 (another interesting way to assign load 0 into a register using $0)					
	move $s1, $0					#move $0 into $s1
	move $s2, $a0					#move $a0 into $s2
	move $s3, $a1					#move $a1 into $s3
	
div_unsign_lp:
	sll $s1, $s1, 1 				#shift $s1 left by 1 bit and store							
	addi $t8, $zero, 31				#storing 31 into $t8
	extract_nth_bit($t7, $s2, $t8)			#call extract_nth_bit label with respective parameters
	insert_to_nth_bit($s1, $zero, $t7, $t9)		#call insert_to_nth_bit label with respective parameters
	sll $s2, $s2, 1					#shift left by 1 bit and store in $s2
	move $a0, $s1					#move $s1 into $a0
	move $a1, $s3					#move $s3 into $a1
	jal subtraction					#jump and link to subtraction label
	move $s4, $v0					#move $v0 into $s4
	blt $s4, $zero, div_unsign_less_than_zero 	#if $t4 < 0 then go to div_unsign_less_than_zero label 
	move $s1, $s4					#move $s4 into $s1
	addi $t6, $zero 1 				#storing 1 into $t6
	insert_to_nth_bit($s2, $zero, $t6, $t9)		#call insert_to_nth_bit label with respective parameters

div_unsign_less_than_zero:
	addi $s0, $s0, 1				#storing $s0 and 1 into $s0				
	beq $s0, 32, div_unsign_end			#if $s0 = 32 then go to div_usign_end label
	j div_unsign_lp					#jump to div_unsign_lp
	
div_unsign_end:	
	la $v0, ($s2)					#load $s2 to $v0
	la $v1, ($s1)					#load $s1 to $v1
	
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw $a0, 40($sp)					#loads $a0 at address 40+$sp
	lw $a1, 36($sp)					#loads $a1 at address 36+$sp
	lw $a2, 32($sp)					#loads $a2 at address 32+$sp
	lw $s0, 28($sp)					#loads $s0 at address 28+$sp
	lw $s1, 24($sp)					#loads $s1 at address 24+$sp
	lw $s2, 20($sp)					#loads $s2 at address 20+$sp
	lw $s3, 16($sp)					#loads $s3 at address 16+$sp
	lw $s4, 12($sp)					#loads $s4 at address 12+$sp
	lw $fp, 8($sp)					#loads $fp at address 8+$sp
	lw $ra, 4($sp)					#loads $ra at address 4+$sp
	addi $sp, $sp, 40				#taking 40 bits of memory from $sp
	jr $ra
	
div_signed:
	move $s0, $a0					#move $a0 into $s0		
	move $s1, $a1					#move $a1 into $s1
	move $s2, $zero 				#move 0 into $s2
	move $s3, $zero					#move 0 into $s3
	jal twos_compl_if_negative			#jump and link to twos_compl_if_negative
	move $s2, $v0					#move $v0 into $s2
	move $a0, $s1					#move $s1 into $a0
	jal twos_compl_if_negative			#jump and link to twos_compl_if_negative
	move $s3, $v0					#move $v0 into $s3
	move $a0, $s2					#move $s2 into $a0
	move $a1, $s3					#move $s3 into $a1
	jal div_unsigned				#jump and link to div_unsigned
	move $a0, $v0					#move $v0 into $a0
	move $a1, $v1					#move $v1 into $a1
	addi $t9, $0, 31				#storing 31 into $t9
	extract_nth_bit($t7, $s0, $t9)			#call extract_nth_bit label with respective parameters
	extract_nth_bit($t8, $s1, $t9)			#call extract_nth_bit label with respective parameters
	xor $t6, $t7, $t8				#exclusive or of $t7 anf $t8 and store in $t6
	move $s4, $a0					#move $a0 into $s4
	move $s5, $a1					#move $a1 into $s5
	beq $t6, 0, div_rem_sign			#if $t6=0 then go to div_rem_sign
	jal twos_complement				#jump and link to twos_complement
	move $s4, $v0					#move $v0 into $s4
	
div_rem_sign:
	addi $t1, $zero, 31				#storing 31 into $t1
	extract_nth_bit($t7, $s0, $t8)			#call extract_nth_bit label with respective parameters
	move $t9, $t7					#move $t7 into $t9
	beq $t9, 0, div_sign_end			#if $t9 is 0 then go to div_sign_end
	move $a0, $s5					#move $s5 into $a0
	jal twos_complement				#jump and link to twos_complement
	move $s5, $v0					#move $v0 into $s5
	
div_sign_end:
	move $v0, $s4					#move $s4 into $v0
	move $v1, $s5					#move $s5 into $v1

au_logical_return:
	# releasing allocated memory back to stack to maintain original value of registers before exiting program to caller program
	lw	$a0, 56($sp)				#loads $a0 at address 56+$sp
	lw	$a1, 52($sp)				#loads $a1 at address 52+$sp
	lw	$a2, 48($sp)				#loads $a2 at address 48+$sp
	lw	$a3, 44($sp)				#loads $a3 at address 44+$sp
	lw	$s0, 40($sp)				#loads $s0 at address 40+$sp
	lw	$s1, 36($sp)				#loads $s1 at address 36+$sp
	lw	$s2, 32($sp)				#loads $s2 at address 32+$sp
	lw	$s3, 28($sp)				#loads $s3 at address 28+$sp
	lw	$s4, 24($sp)				#loads $s4 at address 24+$sp
	lw	$s5, 20($sp)				#loads $s5 at address 20+$sp
	lw	$s6, 16($sp)				#loads $s6 at address 16+$sp
	lw	$s7, 12($sp)				#loads $s7 at address 12+$sp
	lw	$fp, 8($sp)				#loads $fp at address 8+$sp
	lw	$ra, 4($sp)				#loads $ra at address 4+$sp
	addi	$fp, $sp, 56				#taking 56 bits of memory from $sp
	jr 	$ra
	

