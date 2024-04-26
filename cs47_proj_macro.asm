# Add you macro definition here - do not touch cs47_common_macro.asm"
#<------------------ MACRO DEFINITIONS ---------------------->#
.macro extract_nth_bit($regD, $regS, $regT)
	srlv $regD, $regS, $regT       	#set $regD to result by shifting right $regS to the amount specified by $regT
	and $regD, $regD, 0x1 		#perform AND operation between $regD and 1 and store in $regD
.end_macro
	
.macro insert_to_nth_bit($regD, $regS, $regT, $maskReg)
	addi $maskReg,$0, 1  		#$maskReg store sum of $0 and 1
	sllv $maskReg, $maskReg, $regS  #set $maskReg to result by shifting left $maskReg to the amount specified by $regS
	nor $maskReg, $maskReg, $0  	#NOR operation on $maskReg and 0 store in $maskReg
 	and $regD, $regD, $maskReg	#AND operation on $regD, $maskReg and store in $regD
 	sllv $regT, $regT, $regS 	#set $regT to result by shifting right $regT to the amount specified by $regS
 	or $regD, $regD, $regT		#OR operation on $regD and $regT and store in $regD
.end_macro
