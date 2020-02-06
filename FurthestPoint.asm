# Name        : Luke D Johnson
# Username    : ldjohnso
# Description : This programs reads in x and y points 
#then determines which one is farthest from the orgin (0,0)
#after (0,0) is entered in
####################################################
.text

loop1: 
#This reads (x1,y1) and stores it
#x1 -> $t1 and y1 -> $t2
#Then it sends it be compared with (x2,y2)
	li $t8, 1	#This is loop1 so it puts 1 in here (used for tie)
	li $v0, 5	# read in x
	syscall
	la $t1, ($v0) 	# put x in $t1
	li $v0, 5	# read in y
	syscall		
	la $t2, ($v0) 	# put y in $t2
	beq	$t1, $t2, checkzero1	#if $t1 == $t2 goto checkzero
	b checksize	#goto checksize
loop2:
#This reads (x2,y2) and stores it
#x2 -> $t4 and y2 -> $t5
#Then it sends it be compared with (x1,y1)
	li $t8, 2	#This is loop1 so it puts 2 in here (used for tie)
	li $v0, 5	# read in x
	syscall
	la $t4, ($v0) 	# put x in $t4
	li $v0, 5	# read in y
	syscall		
	la $t5, ($v0) 	# put y in $t5
	beq	$t4, $t5, checkzero2	#if $4 == $t5 goto checkzero
	b checksize	#goto check size
checksize:
#part 1
#This part calculates the squared distance of both sets of (x,y)
	mult $t1, $t1	#x1 * x1
	mflo $t6      	#(x1 * x1) -> $t6
	mult $t2, $t2	#y1 * y1
	mflo $t3	#(y1 * y1) -> $t3
	add  $t3, $t3, $t6	#$t3 -> ((x1 * x1) + (y1 * y1))
	mult $t4, $t4	#x2 * x2
	mflo $t7	#(x2 * x2) -> $t7
	mult $t5, $t5	#y2 * y2
	mflo $t6	#(y2 * y2) ->
#part2
#This part makes decisons based on the calculated distances above
	add  $t7, $t7, $t6	#$t7 -> ((x2 * x2) + (y2 * y2)) 
	beq  $t7, $t3, tie	#If the squared or equal goto tie
	bgt  $t3, $t7, setlarge1#if the x1 set is large goto setlaege1
	bgt  $t7, $t3, setlarge2#if the x2 set is large goto setlaege1
	b    loop2	#goto loop2
tie:
#If there is a tie it will set the last thing entered in by the user
#as the largest distance point
	beq $t8, 1, setlarge1
	beq $t8, 2, setlarge2
checkzero1:
#since $t1 = $t2 if it is zero the loop will exit
#this checks the first set of (x,y)
	beq	$t1, 0, end	#if $t1 == 0 then goto end
	b checksize		#goto check size
checkzero2:
#since $t4 = $t5 if it is zero the loop will exit
#this checks the second set of (x,y)
	beq	$t4, 0, end	#if $t4 == 0 then goto end
	b checksize		#goto checksize
setlarge1:
#This sets the final printing reg. to the temp reg. holding 
#the data for the largest distance point
#this is for the first set of (x,y)
	move $s0, $t1	#$t1 -> $s0 (x1)
	move $s1, $t2	#$t2 -> $s1 (y2)
	move $s2, $t3	#$t3 -> $s3 (x^2) + (y^2)
	b loop2		#goto loop2
setlarge2:
#This sets the final printing reg. to the temp reg. holding 
#the data for the largest distance point
#this is for the first set of (x,y)
	move $s0, $t4	#$t4 -> $s0 (x2)	
	move $s1, $t5	#$t5 -> $s1 (y2)
	move $s2, $t7	#$t7 -> $s3 ((x2)^2) + ((y2)^2)
	b loop1		#goto loop1
end:


	
####################################################
# DO NOT CHANGE code after this point!
# This prints the result and terminates execution.
#
# When your program reaches this point, the following must be true:
#  $s0 - contains the x-coordinate of the furthest point
#  $s1 - contains the y-coordinate of the furthest point
#  $s2 - contains the squared distance of the furthest point
 
	li	$v0, 4		# Print "("
	la	$a0, msg1
	syscall

	li	$v0, 1		# Print the x-coordinate		
	move	$a0, $s0
	syscall

	li	$v0, 4		# Print ", "	
	la	$a0, msg2
	syscall

	li	$v0, 1		# Print the y-coordinate		
	move	$a0, $s1
	syscall
	
	la	$v0, 4		# Print ") squared distance = "
	la	$a0, msg3	
	syscall
	
	li	$v0, 1		# Print the squared distance		
	move	$a0, $s2
	syscall	
	
	li 	$v0, 10		# Terminate execution
	syscall

.data
msg1: 	.asciiz "("
msg2: 	.asciiz ", "
msg3: 	.asciiz ") squared distance = "
