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
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -4($fp)
	lw $t1, -4($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -8($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t3, $v0
	sw $t3, -12($fp)
	lw $t4, -12($fp)
	addi $sp, $sp, -4 
	move $t5, $t4
	sw $t5, -16($fp)
	li $t6, 2
	lw $t7, -16($fp)
	div $t7, $t6
	addi $sp, $sp, -4 
	mflo $t8
	sw $t8, -20($fp)
	li $t9, 2
	lw $s0, -20($fp)
	addi $sp, $sp, -4 
	mul $s1, $s0, $t9
	sw $s1, -24($fp)
	lw $s2, -24($fp)
	lw $s3, -16($fp)
	beq $s3, $s2, mylabel0
	j mylabel1
mylabel0:
	addi $sp, $sp, -4 
	li $s4, 1
	sw $s4, -28($fp)
	j mylabel2
mylabel1:
	lw $s5, -8($fp)
	lw $s6, -28($fp)
	move $s6, $s5
	sw $s6, -28($fp)
mylabel2:
	li $s7, 2
	lw $t0, -16($fp)
	div $t0, $s7
	addi $sp, $sp, -4 
	mflo $t1
	sw $t1, -32($fp)
	lw $t0, -32($fp)
	lw $t1, -16($fp)
	move $t1, $t0
	sw $t1, -16($fp)
mylabel3:
	li $t0, 0
	lw $t1, -16($fp)
	bgt $t1, $t0, mylabel4
	j mylabel5
mylabel4:
	lw $t2, -8($fp)
	addi $sp, $sp, -4 
	mul $t3, $t2, $t2
	sw $t3, -36($fp)
	lw $t2, -36($fp)
	lw $t3, -8($fp)
	move $t3, $t2
	sw $t3, -8($fp)
	li $t2, 2
	lw $t3, -16($fp)
	div $t3, $t2
	addi $sp, $sp, -4 
	mflo $t4
	sw $t4, -40($fp)
	li $t3, 2
	lw $t4, -40($fp)
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -44($fp)
	lw $t4, -44($fp)
	lw $t5, -16($fp)
	bne $t5, $t4, mylabel6
	j mylabel7
mylabel6:
	lw $t7, -8($fp)
	lw $t8, -28($fp)
	addi $sp, $sp, -4 
	mul $s0, $t8, $t7
	sw $s0, -48($fp)
	lw $t7, -48($fp)
	lw $t8, -28($fp)
	move $t8, $t7
	sw $t8, -28($fp)
mylabel7:
	li $t7, 2
	lw $t8, -16($fp)
	div $t8, $t7
	addi $sp, $sp, -4 
	mflo $s0
	sw $s0, -52($fp)
	lw $t8, -52($fp)
	lw $s0, -16($fp)
	move $s0, $t8
	sw $s0, -16($fp)
	j mylabel3
mylabel5:
	lw $t8, -28($fp)
	move $a0, $t8
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
