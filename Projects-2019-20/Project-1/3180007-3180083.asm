
.data
	i: .word 1
	str_n: .asciiz	"Enter number of objects in the set (n): "
	str_k: .asciiz	"Enter number to be chosen (k): "
	str_else: .asciiz "Please enter n >= k >= 0"
	str_ans_1: .asciiz "C("
	str_ans_2: .asciiz ", "
	str_ans_3: .asciiz ") = "
	
.text
	main:
		# Print message (n)
		la $a0, str_n		
		li $v0, 4		
		syscall
		
		# Get user's input (n)
		li $v0, 5
		syscall
		
		# Saving input (n)
		move $t1, $v0

		# Print message (k)
		la $a0, str_k		
		li $v0, 4		
		syscall
		
		# Get user's input (k)
		li $v0, 5
		syscall
		
		# Saving input (k)
		move $t2, $v0
		
		# IF STATEMENTS
		sge $s1, $t1, $t2	# If n >= k
		sge $s2, $t2, $zero	# If k >= 0
		
		mul $s3, $s1, $s2	# $s1 * $s2
		sne $s0, $s3, $zero	# If $s1 == $s2 == 1
		
		# Go to ELSE
		beqz $s0, else
		
		# Go to COMBS
		jal combs	
		
		# FINAL PRINT
		la $a0, str_ans_1	# Print "C(..."
		li $v0, 4
		syscall
		
		move $a0, $t1		# Print "C(n..."
		li $v0, 1
		syscall
		
		la $a0, str_ans_2	# Print "C(n, ..."
		li $v0, 4
		syscall
		
		move $a0, $t2		# Print "C(n, k..."
		li $v0, 1
		syscall
		
		la $a0, str_ans_3	# Print "C(n, k) = ..."
		li $v0, 4
		syscall
		
		move $a0,$t9		# Print "C(n, k) = $t9"
		li $v0, 1
		syscall
		
		# EXIT
		li $v0, 10		
		syscall	
	
	else:
		# Print message (else)
		la $a0, str_else
		li $v0, 4
		syscall
		
		# EXIT
		li $v0, 10
		syscall

	combs:
		addi $t3, $zero, 1	# int factorial_n = 1
		addi $t4, $zero, 1	# int factorial_k = 1
		addi $t5, $zero, 1	# int factorial_n_k = 1
		sub  $t7, $t1, $t2	# int n-k
	
	for1_R:
		lw $t6, i		# i = 1
	for1:	
		bgt $t6, $t1, for2_R	# i <= n
	
		mul $t3, $t3, $t6	# factorial_n *= 1
		addi $t6, $t6, 1	# i++
		j for1
		
	for2_R:
		lw $t6, i		# i = 1
	for2:
		bgt $t6, $t2, for3_R	# i <= k
		
		mul $t4, $t4, $t6	# factorial_k *= 1
		addi $t6, $t6, 1	# i++
		j for2
		
	for3_R:
		lw $t6, i		# i = 1
	for3:
		bgt $t6, $t7, exitComb	# i <= n-k
		
		mul $t5, $t5, $t6	# factorial_n_k *= 1
		addi $t6, $t6, 1	# i++
		j for3

	exitComb:
		mul $t8, $t4, $t5	# factorial_k * factorial_n_k
		div $t9, $t3, $t8	# factorial_n / >>
		
		jr $ra			# return																																										