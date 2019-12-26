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
	addi $sp, $sp, -20 
	addi $sp, $sp, -4 
	li $t0, 0
	sw $t0, -24($fp)
mylabel0:
	li $t1, 5
	lw $t2, -24($fp)
	blt $t2, $t1, mylabel1
	j mylabel2
mylabel1:
	lw $t3, -24($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -28($fp)
	lw $t6, -28($fp)
	addi $sp, $sp, -4 
	move $t7, $fp
	addi $t7, $t7, -20
	sw $t7, -32($fp)
	addi $sp, $sp, -4 
	add $t8, $t7, $t6
	sw $t8, -36($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t9, $v0
	sw $t9, -40($fp)
	move $s0, $fp
	addi $s0, $s0, -36
	lw $s0, 0($s0)
	lw $s1, -40($fp)
	sw $s1, 0($s0)
	lw $s2, -24($fp)
	addi $sp, $sp, -4 
	addi $s3, $s2, 1
	sw $s3, -44($fp)
	lw $s4, -44($fp)
	lw $s5, -24($fp)
	move $s5, $s4
	sw $s5, -24($fp)
	j mylabel0
mylabel2:
	addi $sp, $sp, -4 
	li $s6, 1
	sw $s6, -48($fp)
mylabel3:
	li $s7, 1
	lw $t0, -48($fp)
	beq $t0, $s7, mylabel4
	j mylabel5
mylabel4:
	lw $t3, -48($fp)
	li $t3, 0
	sw $t3, -48($fp)
	lw $t3, -24($fp)
	li $t3, 1
	sw $t3, -24($fp)
mylabel6:
	li $t3, 5
	lw $t5, -24($fp)
	blt $t5, $t3, mylabel7
	j mylabel8
mylabel7:
	lw $t6, -24($fp)
	addi $sp, $sp, -4 
	move $t7, $t6
	sw $t7, -52($fp)
mylabel9:
	li $t6, 0
	lw $t7, -52($fp)
	bgt $t7, $t6, mylabel12
	j mylabel11
mylabel12:
	lw $t8, -52($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s2, $t9, $t8
	sw $s2, -56($fp)
	lw $t8, -56($fp)
	lw $s2, -32($fp)
	addi $sp, $sp, -4 
	add $s3, $s2, $t8
	sw $s3, -60($fp)
	li $t8, 1
	lw $s2, -52($fp)
	addi $sp, $sp, -4 
	sub $s3, $s2, $t8
	sw $s3, -64($fp)
	lw $s2, -64($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $s4, $s3, $s2
	sw $s4, -68($fp)
	lw $s2, -68($fp)
	lw $s4, -32($fp)
	addi $sp, $sp, -4 
	add $s5, $s4, $s2
	sw $s5, -72($fp)
	addi $sp, $sp, -4 
	move $s2, $fp
	addi $s2, $s2, -72
	lw $s2, 0($s2)
	lw $s2, 0($s2)
	addi $sp, $sp, -4 
	move $s4, $fp
	addi $s4, $s4, -60
	lw $s4, 0($s4)
	lw $s4, 0($s4)
	blt $s4, $s2, mylabel10
	j mylabel11
mylabel10:
	lw $s5, -52($fp)
	li $s6, 4
	addi $sp, $sp, -4 
	mul $t1, $s6, $s5
	sw $t1, -84($fp)
	lw $t1, -84($fp)
	lw $s5, -32($fp)
	addi $sp, $sp, -4 
	add $t2, $s5, $t1
	sw $t2, -88($fp)
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -88
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -96($fp)
	lw $t1, -52($fp)
	li $t2, 4
	addi $sp, $sp, -4 
	mul $s5, $t2, $t1
	sw $s5, -100($fp)
	lw $t1, -100($fp)
	lw $s5, -32($fp)
	addi $sp, $sp, -4 
	add $t4, $s5, $t1
	sw $t4, -104($fp)
	li $t1, 1
	lw $t4, -52($fp)
	addi $sp, $sp, -4 
	sub $s5, $t4, $t1
	sw $s5, -108($fp)
	lw $t4, -108($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s0, $s5, $t4
	sw $s0, -112($fp)
	lw $t4, -112($fp)
	lw $s0, -32($fp)
	addi $sp, $sp, -4 
	add $s1, $s0, $t4
	sw $s1, -116($fp)
	move $t4, $fp
	addi $t4, $t4, -104
	lw $t4, 0($t4)
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -116
	lw $s0, 0($s0)
	lw $s0, 0($s0)
	sw $s0, 0($t4)
	li $s1, 1
	lw $t0, -52($fp)
	addi $sp, $sp, -4 
	sub $s7, $t0, $s1
	sw $s7, -124($fp)
	lw $t0, -124($fp)
	li $s7, 4
	addi $sp, $sp, -4 
	mul $t3, $s7, $t0
	sw $t3, -128($fp)
	lw $t0, -128($fp)
	lw $t3, -32($fp)
	addi $sp, $sp, -4 
	add $t5, $t3, $t0
	sw $t5, -132($fp)
	move $t0, $fp
	addi $t0, $t0, -132
	lw $t0, 0($t0)
	lw $t3, -96($fp)
	sw $t3, 0($t0)
	lw $t5, -48($fp)
	li $t5, 1
	sw $t5, -48($fp)
	li $t5, 1
	lw $t6, -52($fp)
	addi $sp, $sp, -4 
	sub $t7, $t6, $t5
	sw $t7, -136($fp)
	lw $t7, -136($fp)
	lw $t9, -52($fp)
	move $t9, $t7
	sw $t9, -52($fp)
	j mylabel9
mylabel11:
	lw $t7, -24($fp)
	addi $sp, $sp, -4 
	addi $t9, $t7, 1
	sw $t9, -140($fp)
	lw $t7, -140($fp)
	lw $t9, -24($fp)
	move $t9, $t7
	sw $t9, -24($fp)
	j mylabel6
mylabel8:
	j mylabel3
mylabel5:
	lw $t7, -24($fp)
	li $t7, 0
	sw $t7, -24($fp)
mylabel13:
	li $t7, 5
	lw $t9, -24($fp)
	blt $t9, $t7, mylabel14
	j mylabel15
mylabel14:
	lw $t8, -24($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $s2, $s3, $t8
	sw $s2, -144($fp)
	lw $t8, -144($fp)
	lw $s2, -32($fp)
	addi $sp, $sp, -4 
	add $s4, $s2, $t8
	sw $s4, -148($fp)
	addi $sp, $sp, -4 
	move $t8, $fp
	addi $t8, $t8, -148
	lw $t8, 0($t8)
	lw $t8, 0($t8)
	move $a0, $t8
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t8, -24($fp)
	addi $sp, $sp, -4 
	addi $s2, $t8, 1
	sw $s2, -156($fp)
	lw $t8, -156($fp)
	lw $s2, -24($fp)
	move $s2, $t8
	sw $s2, -24($fp)
	j mylabel13
mylabel15:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
