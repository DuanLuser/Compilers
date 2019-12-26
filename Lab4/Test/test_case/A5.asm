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

swap:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $a1, -8($fp) 
	lw $t0, -4($fp)
	addi $sp, $sp, -4 
	move $t1, $t0
	sw $t1, -12($fp)
	lw $t2, -8($fp)
	lw $t3, -4($fp)
	move $t3, $t2
	sw $t3, -4($fp)
	lw $t4, -12($fp)
	lw $t5, -8($fp)
	move $t5, $t4
	sw $t5, -8($fp)
	lw $t6, -4($fp)
	move $a0, $t6
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t7, -8($fp)
	move $a0, $t7
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t8, -4($fp)
	move $v0, $t8 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
main:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -20 
	addi $sp, $sp, -4 
	li $t9, 0
	sw $t9, -24($fp)
mylabel0:
	li $s0, 5
	lw $s1, -24($fp)
	blt $s1, $s0, mylabel1
	j mylabel2
mylabel1:
	lw $s2, -24($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $s4, $s3, $s2
	sw $s4, -28($fp)
	lw $s5, -28($fp)
	addi $sp, $sp, -4 
	move $s6, $fp
	addi $s6, $s6, -20
	sw $s6, -32($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s5
	sw $s7, -36($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -40($fp)
	move $t0, $fp
	addi $t0, $t0, -36
	lw $t0, 0($t0)
	lw $t1, -40($fp)
	sw $t1, 0($t0)
	li $t2, 0
	lw $t3, -24($fp)
	bgt $t3, $t2, mylabel3
	j mylabel4
mylabel3:
	li $t4, 1
	lw $t5, -24($fp)
	addi $sp, $sp, -4 
	sub $t6, $t5, $t4
	sw $t6, -44($fp)
	lw $t5, -44($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $t7, $t6, $t5
	sw $t7, -48($fp)
	lw $t5, -48($fp)
	lw $t7, -32($fp)
	addi $sp, $sp, -4 
	add $t9, $t7, $t5
	sw $t9, -52($fp)
	lw $t5, -24($fp)
	li $t7, 4
	addi $sp, $sp, -4 
	mul $t9, $t7, $t5
	sw $t9, -56($fp)
	lw $t5, -56($fp)
	lw $t9, -32($fp)
	addi $sp, $sp, -4 
	add $s2, $t9, $t5
	sw $s2, -60($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -52
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	move $a0, $t0 
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -60
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	move $a1, $t1 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal swap
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t2, $v0
	sw $t2, -72($fp)
mylabel4:
	lw $t3, -24($fp)
	addi $sp, $sp, -4 
	addi $t4, $t3, 1
	sw $t4, -76($fp)
	lw $t5, -76($fp)
	lw $t6, -24($fp)
	move $t6, $t5
	sw $t6, -24($fp)
	j mylabel0
mylabel2:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
