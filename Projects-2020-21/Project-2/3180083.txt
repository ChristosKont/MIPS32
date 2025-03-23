.text
     
     la $t0, CodeWord
   
     li $t1, 0 
     
     li $t2, 1
     
while: 

    	li $v0, 12
     	syscall 
     	
     	move $t3, $v0
     	
     	bne $t3, 48, digit1
     	
     	addi $t1, $t1, 1
    	
    	addi $t0, $t0, 1
     	
     	j digit0
       
	digit1:
       
        	sb $t2, ($t0)
        	
        	addi $t0, $t0, 1 
        	
        	addi $t1, $t1, 1
	       		            		     
	digit0:      

		blt $t1, 12, while
     
Control4paritydigits:

     			li $t1, 1
     			
     			addi $t0, $t0, -12
     				
     			while2:
     			
     				li $t3, 0 
     				
     				la $t5, PotitionsForDigit1
     				beq $t1, 1, p
     				     				
     				la $t5, PotitionsForDigit2
     				beq $t1, 2, p
     				     				
     				la $t5, PotitionsForDigit4
     				beq $t1, 3, p
     				     				
     				la $t5, PotitionsForDigit8
     				beq $t1, 4, p
     				 
     			p:
     				
     				lb $t4, ($t5)
     				     				
     				beq $t4, -1, sum2
     				
     				addi $t4, $t4, -1 
     				
     				add $t0, $t0, $t4
     				
     				lb $t7, ($t0)

     				jal sum1
     				     			
     				j p 
     			
     			sum1: 
     				
     				add $t3, $t3, $t7 

     				addi $t5, $t5, 1 
     				
     				sub $t0, $t0, $t4  
     				
     				jr $ra
     			 
     			sum2: 
     		
     				addi $t1, $t1, 1
     			
     				rem $t6, $t3, 2 
     				
     				bne $t6, $zero, not_ok
     				
     				beq $t1, 4, ok
     				 
     				j while2
     			
ok:

	li $v0, 4
	la $a0, ok_message
	syscall
	
	j exit
     			
not_ok:
	
	li $v0, 4 
	la $a0, not_ok_message
	syscall     			
     			
exit:
     			
 	li $v0 10 
     	syscall
     			
.data

CodeWord:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

PotitionsForDigit1: 	.byte 1, 3, 5, 7, 9, 11, -1
PotitionsForDigit2: 	.byte 2, 3, 6, 7, 10, 11, -1
PotitionsForDigit4: 	.byte 4, 5, 6, 7, 12, -1
PotitionsForDigit8: 	.byte 8, 9, 10, 11, 12, -1

not_ok_message:		.asciiz "\n - Error in CodeWord"

ok_message:		.asciiz "\n - No error in CodeWord"

