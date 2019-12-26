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
	li $t0, 3
	sw $t0, -4($fp)
	addi $sp, $sp, -4 
	li $t1, 12
	sw $t1, -8($fp)
	lw $t2, -8($fp)
	addi $sp, $sp, -4 
	mul $t3, $t2, $t2
	sw $t3, -12($fp)
	lw $t4, -12($fp)
	addi $sp, $sp, -4 
	addi $t5, $t4, 13
	sw $t5, -16($fp)
	lw $t6, -16($fp)
	addi $sp, $sp, -4 
	move $t7, $t6
	sw $t7, -20($fp)
	li $t8, 13
	lw $t9, -20($fp)
	div $t9, $t8
	addi $sp, $sp, -4 
	mflo $s0
	sw $s0, -24($fp)
	lw $s1, -24($fp)
	addi $sp, $sp, -4 
	addi $s2, $s1, 1
	sw $s2, -28($fp)
	lw $s3, -28($fp)
	addi $sp, $sp, -4 
	move $s4, $s3
	sw $s4, -32($fp)
	lw $s5, -20($fp)
	lw $s6, -8($fp)
	div $s6, $s5
	addi $sp, $sp, -4 
	mflo $s7
	sw $s7, -36($fp)
	lw $t0, -32($fp)
	lw $t1, -20($fp)
	addi $sp, $sp, -4 
	mul $t2, $t1, $t0
	sw $t2, -40($fp)
	lw $t0, -40($fp)
	lw $t1, -36($fp)
	addi $sp, $sp, -4 
	add $t2, $t1, $t0
	sw $t2, -44($fp)
	lw $t0, -44($fp)
	addi $sp, $sp, -4 
	move $t1, $t0
	sw $t1, -48($fp)
	lw $t0, -48($fp)
	move $a0, $t0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	li $t0, 2
	lw $t1, -48($fp)
	addi $sp, $sp, -4 
	mul $t2, $t1, $t0
	sw $t2, -52($fp)
	lw $t1, -52($fp)
	lw $t2, -4($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -56($fp)
	lw $t1, -56($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -60($fp)
	lw $t1, -60($fp)
	move $a0, $t1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t1, -20($fp)
	lw $t2, -8($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -64($fp)
	lw $t1, -32($fp)
	lw $t2, -64($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -68($fp)
	lw $t1, -60($fp)
	lw $t2, -8($fp)
	div $t2, $t1
	addi $sp, $sp, -4 
	mflo $t3
	sw $t3, -72($fp)
	lw $t1, -72($fp)
	lw $t2, -68($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -76($fp)
	lw $t1, -4($fp)
	lw $t2, -76($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -80($fp)
	lw $t1, -80($fp)
	lw $t2, -4($fp)
	move $t2, $t1
	sw $t2, -4($fp)
	lw $t1, -4($fp)
	move $a0, $t1
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
