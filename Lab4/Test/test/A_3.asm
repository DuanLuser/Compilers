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
	li $t0, 0
	sw $t0, -4($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t1, $v0
	sw $t1, -8($fp)
	lw $t2, -8($fp)
	addi $sp, $sp, -4 
	move $t3, $t2
	sw $t3, -12($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t4, $v0
	sw $t4, -16($fp)
	lw $t5, -16($fp)
	addi $sp, $sp, -4 
	move $t6, $t5
	sw $t6, -20($fp)
	lw $t7, -20($fp)
	lw $t8, -12($fp)
	bgt $t8, $t7, mylabel0
	j mylabel1
mylabel0:
	lw $t9, -12($fp)
	addi $sp, $sp, -4 
	move $s0, $t9
	sw $s0, -24($fp)
	j mylabel2
mylabel1:
	lw $s1, -20($fp)
	lw $s2, -24($fp)
	move $s2, $s1
	sw $s2, -24($fp)
mylabel2:
mylabel3:
	li $s3, 0
	lw $s4, -4($fp)
	beq $s4, $s3, mylabel4
	j mylabel5
mylabel4:
	lw $s5, -12($fp)
	lw $s6, -24($fp)
	div $s6, $s5
	addi $sp, $sp, -4 
	mflo $s7
	sw $s7, -28($fp)
	lw $t0, -12($fp)
	lw $t1, -28($fp)
	addi $sp, $sp, -4 
	mul $t2, $t1, $t0
	sw $t2, -32($fp)
	lw $t0, -32($fp)
	lw $t1, -24($fp)
	beq $t1, $t0, mylabel6
	j mylabel7
mylabel6:
	lw $t2, -20($fp)
	lw $t3, -24($fp)
	div $t3, $t2
	addi $sp, $sp, -4 
	mflo $t4
	sw $t4, -36($fp)
	lw $t2, -20($fp)
	lw $t3, -36($fp)
	addi $sp, $sp, -4 
	mul $t4, $t3, $t2
	sw $t4, -40($fp)
	lw $t2, -40($fp)
	lw $t3, -24($fp)
	beq $t3, $t2, mylabel8
	j mylabel9
mylabel8:
	lw $t4, -24($fp)
	addi $sp, $sp, -4 
	move $t5, $t4
	sw $t5, -44($fp)
	lw $t4, -4($fp)
	li $t4, 1
	sw $t4, -4($fp)
	j mylabel10
mylabel9:
	lw $t4, -24($fp)
	addi $sp, $sp, -4 
	addi $t5, $t4, 1
	sw $t5, -48($fp)
	lw $t4, -48($fp)
	lw $t5, -24($fp)
	move $t5, $t4
	sw $t5, -24($fp)
mylabel10:
	j mylabel11
mylabel7:
	lw $t4, -24($fp)
	addi $sp, $sp, -4 
	addi $t5, $t4, 1
	sw $t5, -52($fp)
	lw $t4, -52($fp)
	lw $t5, -24($fp)
	move $t5, $t4
	sw $t5, -24($fp)
mylabel11:
	j mylabel3
mylabel5:
	lw $t4, -44($fp)
	move $a0, $t4
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
