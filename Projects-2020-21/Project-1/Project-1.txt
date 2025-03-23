.text

.globl main

main:

     li $v0, 4 
     la $a0, READ_MESSAGE                    #read message
     syscall 
    
     # ---------------------------- 	Read Initial Number -----------------------------------------
     
     li $v0, 5                               #read an integer
     syscall 
     
     move $t0, $v0
    
     # ---------------------------- 	Validate Initial Number -------------------------------------
     
     addi $t5, $zero, 999                        
     addi $t6, $zero, 9999
     
     bgt $t0, $t6, error                        # $t0 > 9999
     ble $t0, $t5, error			# $t0 <= 999
    
     # ---------------------------- 	Calculate 1st Digit -----------------------------------------
     #addi $t7, $zero, 1000
     div $t1, $t0, 1000			
     rem $t0, $t0, 1000
     
     # ---------------------------- 	Calculate 2st Digit -----------------------------------------
     
     #addi $t7, $t7, -900
     div $t2, $t0, 100
     rem $t0, $t0, 100
     
     # ---------------------------- 	Calculate 3st Digit -----------------------------------------
     
     #addi $t7, $t7, -90
     div $t3, $t0, 10
     rem $t0, $t0, 10
     
     # ---------------------------- 	Calculate 4st Digit -----------------------------------------
     
     #addi $t7, $t7, -9
     div $t4, $t0, 1
     rem $t0, $t0, 1
     
     # ---------------------------- 	Encryption of Digits ----------------------------------------
     
     #addi $t7 ,$t7, 9		
     addi $t1, $t1, 7
     rem $t1, $t1, 10 
     
     addi $t2, $t2, 7
     rem $t2, $t2, 10
     
     addi $t3, $t3, 7
     rem $t3, $t3, 10
     
     addi $t4, $t4, 7
     rem $t4, $t4, 10
     
     # ---------------------------- 	Build Encrypted Number --------------------------------------
     
     #sub $t0, $t0, $t0
     
     add $t0, $t0, $t3 
     mul $t0, $t0, 10
      
     
     add $t0, $t0, $t4
     mul $t0, $t0, 10
     
     add $t0, $t0, $t1
     mul $t0, $t0, 10
     
     add $t0, $t0, $t2 
     
     # ---------------------------- 	Print Encrypted Number --------------------------------------
    
     li $v0, 4
     la $a0, OUTPUT_MESSAGE
     syscall
     
     move $a0, $t0
     li $v0, 1 
     syscall
     
     j exit 
     
     # ---------------------------- 	Print Error Message -----------------------------------------
     
error:

      li $v0, 4
      la $a0, ERROR_MESSAGE 		    #error message 
      syscall					
      
      j main                                #go to main 


	# ------------------------- 	End of progran ----------------------------------

exit:
		
      li $v0, 10 
      syscall 					
		

.data

READ_MESSAGE: 	.asciiz "\nEnter a four digit number to encrypt: "

OUTPUT_MESSAGE: .asciiz "\nEncrypted number is : "

ERROR_MESSAGE: 	.asciiz "\nInvalid input, not a 4-digit number"
