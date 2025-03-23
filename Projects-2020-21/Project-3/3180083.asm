# ---------------------------------------------------------------------------
# Program: MIPS Subprograms
# ---------------------------------------------------------------------------
.text
# ---------------------------------------------------------------------------
# main program
# ---------------------------------------------------------------------------
	li $v0, 4
	la $a0, array # print message read array A
	syscall 

	li $t0, 1 # counter = 1
	
	la $t2, A # $t2 is base register of A

for1: 
	bgt $t0, 5, exit_for1 # if counter>5 goto exit_for1

	li $v0, 12 # $v0=readInt()
	syscall 

	sw $v0, ($t2) # A[i]=$v0

	addi $t2, $t2, 4 # i++
	
	addi $t0, $t0, 1 # counter++
	
	j for1 # goto for1

exit_for1:
	
	
	
	li $v0, 4           
	la $a0, message_b1 # print message
	syscall
	
	#la $t3, b1
	li $v0, 5 
	syscall         
	sw $v0, b1 # b1 = readInt()
	
	li $v0, 4 
	la $a0, message_b2 # print message
	syscall
	
	#la $t4, b2
	li $v0, 5 
	syscall
	sw $v0, b2 # b2 = readInt()

# --------------------- check bounds ----------------------
	
	lw $t3, b1
	lw $t4, b2
	blt $t3, 1, error
	bgt $t4, 5, error # b1>=1 && b1<=5
	
	blt $t4, 1, error 
	bgt $t4, 5, error # b2>=1 && b2<=5
	
	bgt $t3, $t4, error # b1<=b2
	
	#j exit

# --------------------- call subprogram max------------------

	jal max # k = max (A, b1, b2)

# --------------------- print results -----------------------

	li $v0, 4
	la $a0, result_message # print result message
	syscall 
	
	# print(k)

error: 

	li $v0, 4 
	la $a0, error_message # print error message
	syscall 
	
exit:

	li $v0, 10 
	syscall		# end of program

# ---------------------------------------------------------------------------
# max subprogram
# ---------------------------------------------------------------------------

max: 
lw $s0, ($t2) # $s0 is A

lw $s1, 0($t1) # $s1 is K

lw $s2, 0($t5) # $s2 is P
 
mul $t1, $s1, 4 
add $s0, $zero, $t1
lw $t1, ($s0)
lw $s3, ($t1)  # $s3 is maxA

# $s4 is A[K]

# save $ra - push ($ra)

# K

# K - 1

# (K - 1) * 4

# (K - 1) * 4 + A

# $s3 is maxA = A[K]

for2: 
# K++
# if (K>P) exit_for2
# K
# K - 1
# (K - 1) * 4
# (K - 1) * 4 + A
# $s4 = A[K] - next position in array A
# $a0 = maxA
# $a1 = A[K]
# greater (maxA, A[K])
# maxA = greater (maxA, A[K])
exit_for2: 

# load $ra - pop ($ra)
# return value is maxA
# return from max

# ---------------------------------------------------------------------------
# greater subprogram
# ---------------------------------------------------------------------------

greater: 

# if (x < y)
# return y
# else
# return x

exit_greater: # 

# ---------------------------------------------------------------------------
# Data Segment:
# ---------------------------------------------------------------------------

.data
A: .space 20 
b1: .space 4
b2: .space 4
array: .asciiz "\n read array A " 
message_b1: .asciiz "\n give b1 "
message_b2: .asciiz "\n give b2 "
error_message: .asciiz "\n error"
result_message: .asciiz "\n k: "
#messages...10