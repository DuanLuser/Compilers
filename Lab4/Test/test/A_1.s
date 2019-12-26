.data
_prompt: .asciiz "Enter an integer:"
_ret: .asciiz "\n" 
.globl main
.text
read:
	li $v0, 4 
	la $a0, _prompt 
	syscall
	li $v0, 5 
	syscall 
	jr $ra 

write:
	li $v0, 1 
	syscall 
	li $v0, 4 
	la $a0, _ret 
	syscall 
	move $v0, $0 
	jr $ra 

main:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	li $t0, 12
	sw $t0, -4($fp)
	addi $sp, $sp, -4 
	li $t1, 4
	sw $t1, -8($fp)
	addi $sp, $sp, -4 
	li $t2, 5
	sw $t2, -12($fp)
	lw $t3, -8($fp)
	lw $t4, -4($fp)
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -16($fp)
	lw $t6, -16($fp)
	addi $sp, $sp, -4 
	move $t7, $t6
	sw $t7, -20($fp)
	lw $t8, -12($fp)
	lw $t9, -20($fp)
	addi $sp, $sp, -4 
	add $s0, $t9, $t8
	sw $s0, -24($fp)
	lw $s1, -8($fp)
	lw $s2, -24($fp)
	addi $sp, $sp, -4 
	sub $s3, $s2, $s1
	sw $s3, -28($fp)
	lw $s4, -28($fp)
	addi $sp, $sp, -4 
	move $s5, $s4
	sw $s5, -32($fp)
	lw $s6, -8($fp)
	lw $s7, -32($fp)
	addi $sp, $sp, -4 
	mul $t0, $s7, $s6
	sw $t0, -36($fp)
	lw $t0, -36($fp)
	lw $t1, -20($fp)
	addi $sp, $sp, -4 
	add $t2, $t1, $t0
	sw $t2, -40($fp)
	lw $t0, -40($fp)
	addi $sp, $sp, -4 
	move $t1, $t0
	sw $t1, -44($fp)
	lw $t0, -44($fp)
	move $a0, $t0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t0, -32($fp)
	lw $t1, -20($fp)
	addi $sp, $sp, -4 
	add $t2, $t1, $t0
	sw $t2, -48($fp)
	lw $t0, -48($fp)
	lw $t1, -44($fp)
	addi $sp, $sp, -4 
	mul $t2, $t1, $t0
	sw $t2, -52($fp)
	li $t0, 25
	lw $t1, -52($fp)
	div $t1, $t0
	addi $sp, $sp, -4 
	mflo $t2
	sw $t2, -56($fp)
	lw $t1, -56($fp)
	lw $t2, -44($fp)
	move $t2, $t1
	sw $t2, -44($fp)
	lw $t1, -44($fp)
	lw $t2, -32($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -60($fp)
	lw $t1, -44($fp)
	lw $t2, -20($fp)
	div $t2, $t1
	addi $sp, $sp, -4 
	mflo $t3
	sw $t3, -64($fp)
	lw $t1, -64($fp)
	lw $t2, -60($fp)
	addi $sp, $sp, -4 
	sub $t3, $t2, $t1
	sw $t3, -68($fp)
	li $t1, 12
	lw $t2, -8($fp)
	addi $sp, $sp, -4 
	mul $t3, $t2, $t1
	sw $t3, -72($fp)
	lw $t2, -72($fp)
	lw $t3, -68($fp)
	addi $sp, $sp, -4 
	add $t4, $t3, $t2
	sw $t4, -76($fp)
	lw $t2, -76($fp)
	lw $t3, -32($fp)
	move $t3, $t2
	sw $t3, -32($fp)
	lw $t2, -44($fp)
	move $a0, $t2
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t2, -32($fp)
	move $a0, $t2
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
