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
	lw $t6, -16($fp)
	lw $t7, -8($fp)
	bgt $t7, $t6, mylabel0
	j mylabel1
mylabel0:
	li $t8, 2
	lw $t9, -16($fp)
	addi $sp, $sp, -4 
	mul $s0, $t9, $t8
	sw $s0, -20($fp)
	lw $s1, -20($fp)
	lw $s2, -8($fp)
	bgt $s2, $s1, mylabel2
	j mylabel3
mylabel2:
	lw $s3, -8($fp)
	move $a0, $s3
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	j mylabel4
mylabel3:
	li $s4, 2
	lw $s5, -16($fp)
	addi $sp, $sp, -4 
	mul $s6, $s5, $s4
	sw $s6, -24($fp)
	lw $s7, -24($fp)
	move $a0, $s7
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
mylabel4:
	j mylabel5
mylabel1:
	lw $t0, -16($fp)
	lw $t1, -8($fp)
	beq $t1, $t0, mylabel6
	j mylabel7
mylabel6:
	li $t2, 100
	lw $t3, -16($fp)
	bgt $t3, $t2, mylabel8
	j mylabel9
mylabel8:
	li $t4, 100
	move $a0, $t4
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	j mylabel10
mylabel9:
	lw $t5, -16($fp)
	move $a0, $t5
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
mylabel10:
	j mylabel11
mylabel7:
	li $t5, 2
	lw $t9, -8($fp)
	addi $sp, $sp, -4 
	mul $s0, $t9, $t5
	sw $s0, -28($fp)
	lw $t9, -16($fp)
	lw $s0, -28($fp)
	blt $s0, $t9, mylabel12
	j mylabel13
mylabel12:
	lw $s3, -16($fp)
	move $a0, $s3
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	j mylabel14
mylabel13:
	li $s3, 2
	lw $s5, -8($fp)
	addi $sp, $sp, -4 
	mul $s6, $s5, $s3
	sw $s6, -32($fp)
	lw $s5, -32($fp)
	move $a0, $s5
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
mylabel14:
mylabel11:
mylabel5:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
