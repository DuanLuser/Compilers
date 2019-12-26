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

myPow:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $a1, -8($fp) 
	li $t0, 0
	lw $t1, -8($fp)
	beq $t1, $t0, mylabel0
	j mylabel1
mylabel0:
	li $v0, 1 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel1:
	li $t2, 1
	lw $t3, -8($fp)
	beq $t3, $t2, mylabel2
	j mylabel3
mylabel2:
	lw $t4, -4($fp)
	move $v0, $t4 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel3:
	li $t5, 2
	lw $t6, -8($fp)
	beq $t6, $t5, mylabel4
	j mylabel5
mylabel4:
	lw $t7, -4($fp)
	addi $sp, $sp, -4 
	mul $t8, $t7, $t7
	sw $t8, -12($fp)
	lw $t9, -12($fp)
	move $v0, $t9 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel5:
	li $s0, 2
	lw $s1, -8($fp)
	div $s1, $s0
	addi $sp, $sp, -4 
	mflo $s2
	sw $s2, -16($fp)
	li $s3, 2
	lw $s4, -16($fp)
	addi $sp, $sp, -4 
	mul $s5, $s4, $s3
	sw $s5, -20($fp)
	lw $s6, -20($fp)
	lw $s7, -8($fp)
	beq $s7, $s6, mylabel6
	j mylabel7
mylabel6:
	li $t7, 2
	lw $t8, -8($fp)
	div $t8, $t7
	addi $sp, $sp, -4 
	mflo $s1
	sw $s1, -24($fp)
	lw $a0, -4($fp) 
	lw $a1, -24($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal myPow
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -28($fp)
	lw $a0, -28($fp) 
	li $t0, 2
	move $a1, $t0 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal myPow
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t1, $v0
	sw $t1, -32($fp)
	lw $t2, -32($fp)
	move $v0, $t2 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
	j mylabel8
mylabel7:
	li $t3, 2
	lw $t4, -8($fp)
	div $t4, $t3
	addi $sp, $sp, -4 
	mflo $t5
	sw $t5, -36($fp)
	lw $a0, -4($fp) 
	lw $a1, -36($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal myPow
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -40($fp)
	lw $a0, -40($fp) 
	li $t0, 2
	move $a1, $t0 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal myPow
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t1, $v0
	sw $t1, -44($fp)
	lw $t2, -44($fp)
	addi $sp, $sp, -4 
	move $t3, $t2
	sw $t3, -48($fp)
	lw $t4, -48($fp)
	lw $t5, -4($fp)
	addi $sp, $sp, -4 
	mul $t6, $t5, $t4
	sw $t6, -52($fp)
	lw $t7, -52($fp)
	move $v0, $t7 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel8:
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
	move $t8, $v0
	sw $t8, -4($fp)
	lw $t9, -4($fp)
	addi $sp, $sp, -4 
	move $s0, $t9
	sw $s0, -8($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $s1, $v0
	sw $s1, -12($fp)
	lw $s2, -12($fp)
	addi $sp, $sp, -4 
	move $s3, $s2
	sw $s3, -16($fp)
	lw $a0, -8($fp) 
	lw $a1, -16($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal myPow
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -20($fp)
	lw $t1, -20($fp)
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
