.data 

	N: 	.word 10
	keys: 	.word 0
	hash: 	.space 40

	s1: .asciiz " Menu"
	s2: .asciiz "\n1.Insert Key"
	s3: .asciiz "\n2.Find Key"
	s4: .asciiz "\n3.Display Hash Table"
	s5: .asciiz "\n4.Exit"
	s6: .asciiz "\nChoise? "
	s7: .asciiz "\nGive new key (greater than zero): "
	s9: .asciiz "\nkey must be greater than zero"
	s10: .asciiz "\nGive key to search for: "
	s11: .asciiz "\nKey not in hash table."
	s12: .asciiz "\nKey value = "
	s13: .asciiz "\nTable position = "
	s14: .asciiz "\nKey is already in hash table. "
        s15: .asciiz "\nhash table is full"
        s16: .asciiz "\npos key\n"
        space: .asciiz " "
	


.text

run:
	
	    lw $t1, N				# int N = 10;
	    lw $t2, keys			# int keys = 0;
			
	    li $t3, 0				# int key = 0;
	    				
		
	    li $t4, 0				# int pos = 0;
	    
		
	    li $t5, 0				# int choice = 0;
       	    li $t6, 0				# int telos = 0;
	    addi $s0, $zero, 0
	    li $t0, 0	                        

hash1:			                        # int[] hash = {0, 0, ..., 0};
     
      bge $t0, 40, do_while
      sw $s0, hash($t0)
      addi $t0, $t0, 4
      j hash1
     
     
                   

do_while:
	
		la $a0, s1				# " Menu"
		li $v0, 4
		syscall
				
		la $a0, s2				# "1.Insert Key"
		li $v0, 4
		syscall
		
		la $a0, s3				# "2.Find Key"
		li $v0, 4
		syscall
		
		la $a0, s4				# "3.Display Hash Table"
		li $v0, 4
		syscall
		
		la $a0, s5				# "4.Exit"
		li $v0, 4
		syscall
		
		la $a0, s6				# "Choise? "
		li $v0, 4
		syscall
		
		li $v0, 5				# choice = readInt();
		syscall
		move $t5, $v0
		
#		-----		
		
		li $t9, 1
		beq $t5, $t9, choice1			# if (choice == 1)
		
		li $t9, 2
		beq $t5, $t9, choice2			# if (choice == 2)
		
		li $t9, 3
		beq $t5, $t9, choice3			# if (choice == 3)
		
		li $t9, 4
		beq $t5, $t9, choice4			# if (choice == 4)
		
		choice1:
		
			la $a0, s7			# "Give new key..."
			li $v0, 4
			syscall
			
			li $v0, 5			# key = readInt();
			syscall
			move $t3, $v0			

			blez $t3, else_c		# if !(key > 0) goto insertkey (hash, key);
			jal insertkey			# goto insertkey(hash, key);
			
		
		else_c:
		
			la $a0, s9			# else {...};
			li $v0, 4			
			syscall	
			
			j do_while_loop			# goto do_while_loop ();
					
		choice2:
		
			la $a0, s10			# "Give key to search for: "
			li $v0, 4
			syscall
			
			li $v0, 5			# key = readInt();
			syscall
			move $t3, $v0
					
			jal findkey			# pos = findkey (hash, key);			
			
			li $t9, -1			
			bne $t4, $t9, choice2_else	# if (pos != -1) goto choice2_else();
			
			# choice2_if() == TRUE;
			la $a0, s11			# "Key not in hash table."
			li $v0, 4
			syscall
			
			j do_while_loop			# goto do_while_loop ();
			
			choice2_else:
				
				     la $a0, s12		# "Key value = "
				     li $v0, 4
				     syscall
				
				     addi $t4, $t4, 1
			             mul $t9, $t4, 4
			             sub $t4, $t4, 1   
			             lw $t7, hash($t9)
				     
				
				     move $a0, $t7		# ... + hash[pos];
				     li $v0, 1
				     syscall
				
				     la $a0, s13		# "Table position = "
				     li $v0, 4
				     syscall
				
				     move $a0, $t4		# ... + pos;
				     li $v0, 1
				     syscall
				
				     j do_while_loop
				
		choice3:
		
			jal displaytable		# goto displaytable (hash);
			
			j do_while_loop
			
		choice4:
		
			li $t6, 1			# telos = 1;
			
			j do_while_loop
			
		do_while_loop:
		
			     beqz $t6, do_while		        # if (telos == 0) goto do_while
			     j exit				# else { goto exit(); }

findkey:
		
		li $t0, 0				# i = 0;
		li $t8, 0				# found = 0;
		
		rem $t4, $s3, $t1			# position = k % N
		
		while_f:
		
			bge $t0, $t1, if_f		# !(i < N)
			bnez $t8, if_f			# ... && (found != 0)
			
			addi $t0, $t0, 1		# if TRUE: i++;
			
			addi $t4, $t4, 1
			mul $t9, $t4, 4
			sub $t4, $t4, 1   
			lw $t7, hash($t9)
			
			bne $t7, $t3, else_f		# !(hash[position] == k)
			li $t8, 1                       # found = 1;
			j while_f			# goto while_f
			
		else_f:
			addi $t4, $t4, 1		# position += 1;
			rem $t4, $t4, $t1		# position %= N;
			j while_f			# goto while_f
				
		if_f:
			
		     bnez $t8, else_f2			# !(found == 0)
 
                else_f2:
                
                        li $t4, -1			# return -1;
		     
		        jr $ra			        # return position;
                       
                       
                        
                        
                        
                            
displaytable:
	
		    la $a0, s16				# "\npos key\n"
		    li $v0, 4	
		    syscall		
				
		    li $t0, 0				# int i = 0;
		
		for_d:
		
		    bge $t0, $t1, exit_d		# !(i < N)
		    la $a0, space                       # println(" " + i + " " + hash[i]); 
            	    li $v0, 4
            	    syscall
            		
            	    move $a0, $t0
            	    li $v0, 1
                    syscall
            		
            	    la $a0, space
           	    li $v0, 4
            	    syscall 
            

		    mul $t9, $t0, 4   
		    lw $t7, hash($t9)                   # hash[i]
                    move $a0, $t9 
            	    li $v0, 1
            	    syscall
            	    addi $t0, $t0, 1                    # i++;
            		
            	    j for_d
            	    
            exit_d:
            
                   jr $ra
                   
hashfunction:
	
	     rem $t4, $t3, $t1			                # position = k % N
		
	     while_h:
		
			addi $t4, $t4, 1
			mul $t9, $t4, 4
			sub $t4, $t4, 1   
			lw $t7, hash($t9)
		
			
			bnez $t7, return_h			# (hash[position] != 0)
		
			addi $t4, $t4, 1			# position++;
			rem $t4, $t4, $t1			# position %= N;
			j while_h 
		
	     return_h:
			
		      
		      jr $ra				# return position;
		      
insertkey:
	
          jal findkey					# pos = findkey(hash, keys)
		
	  li $t9, -1
          beq $t4, $t9, else_i				# !(position != -1)
		
	  la $a0, s11					# "Key not in hash table."
	  li $v0, 4
	  syscall
		
	  jr $ra					# return;
		
	else_i:
		
		bge $t2, $t1, else_i2			# !(keys < N)
			
		jal hashfunction			# position = hashfunction(hash, k)
		
		addi $t4, $t4, 1
		mul $t9, $t4, 4
		sub $t4, $t4, 1   
		add $s1, $zero, $t3			
		sw $s1, hash($t9)                       # hash[position] = k;
		
		addi $t2, $t2, 1			# keys++;
		
	        j else_i 	
	else_i2:
			
		la $a0, s15
		li $v0, 4			        # "hash table is full"
		syscall
		
		j else_c			        # return

exit:
		
	li $v0, 10				        # exit
	syscall		

            	    
  
            	    
            	
			

