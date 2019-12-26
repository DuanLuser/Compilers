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
	addi $sp, $sp, -8 
	addi $sp, $sp, -4 
	li $t0, 0
	sw $t0, -12($fp)
mylabel0:
	li $t1, 5
	lw $t2, -12($fp)
	blt $t2, $t1, mylabel1
	j mylabel2
mylabel1:
	lw $t3, -12($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -16($fp)
	lw $t6, -16($fp)
	addi $sp, $sp, -4 
	move $t7, $fp
	addi $t7, $t7, -8
	sw $t7, -20($fp)
	addi $sp, $sp, -4 
	add $t8, $t7, $t6
	sw $t8, -24($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t9, $v0
	sw $t9, -28($fp)
	move $s0, $fp
	addi $s0, $s0, -24
	lw $s0, 0($s0)
	lw $s1, -28($fp)
	sw $s1, 0($s0)
	lw $s2, -12($fp)
	addi $sp, $sp, -4 
	addi $s3, $s2, 1
	sw $s3, -32($fp)
	lw $s4, -32($fp)
	lw $s5, -12($fp)
	move $s5, $s4
	sw $s5, -12($fp)
	j mylabel0
mylabel2:
	lw $s6, -12($fp)
	li $s6, 1
	sw $s6, -12($fp)
mylabel3:
	li $s7, 5
	lw $t0, -12($fp)
	blt $t0, $s7, mylabel4
	j mylabel5
mylabel4:
	lw $t3, -12($fp)
	addi $sp, $sp, -4 
	move $t5, $t3
	sw $t5, -36($fp)
mylabel6:
	li $t3, 0
	lw $t5, -36($fp)
	bgt $t5, $t3, mylabel9
	j mylabel8
mylabel9:
	li $t6, 1
	lw $t7, -36($fp)
	addi $sp, $sp, -4 
	sub $t8, $t7, $t6
	sw $t8, -40($fp)
	lw $t7, -40($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $t9, $t8, $t7
	sw $t9, -44($fp)
	lw $t7, -44($fp)
	lw $t9, -20($fp)
	addi $sp, $sp, -4 
	add $s2, $t9, $t7
	sw $s2, -48($fp)
	lw $t7, -36($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s2, $t9, $t7
	sw $s2, -52($fp)
	lw $t7, -52($fp)
	lw $s2, -20($fp)
	addi $sp, $sp, -4 
	add $s3, $s2, $t7
	sw $s3, -56($fp)
	addi $sp, $sp, -4 
	move $t7, $fp
	addi $t7, $t7, -56
	lw $t7, 0($t7)
	lw $t7, 0($t7)
	addi $sp, $sp, -4 
	move $s2, $fp
	addi $s2, $s2, -48
	lw $s2, 0($s2)
	lw $s2, 0($s2)
	bgt $s2, $t7, mylabel7
	j mylabel8
mylabel7:
	lw $s3, -36($fp)
	li $s4, 4
	addi $sp, $sp, -4 
	mul $s5, $s4, $s3
	sw $s5, -68($fp)
	lw $s3, -68($fp)
	lw $s5, -20($fp)
	addi $sp, $sp, -4 
	add $s6, $s5, $s3
	sw $s6, -72($fp)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -72
	lw $s3, 0($s3)
	lw $s3, 0($s3)
	addi $sp, $sp, -4 
	move $s5, $s3
	sw $s5, -80($fp)
	lw $s3, -36($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s6, $s5, $s3
	sw $s6, -84($fp)
	lw $s3, -84($fp)
	lw $s6, -20($fp)
	addi $sp, $sp, -4 
	add $t1, $s6, $s3
	sw $t1, -88($fp)
	li $t1, 1
	lw $s3, -36($fp)
	addi $sp, $sp, -4 
	sub $s6, $s3, $t1
	sw $s6, -92($fp)
	lw $s3, -92($fp)
	li $s6, 4
	addi $sp, $sp, -4 
	mul $t2, $s6, $s3
	sw $t2, -96($fp)
	lw $t2, -96($fp)
	lw $s3, -20($fp)
	addi $sp, $sp, -4 
	add $t4, $s3, $t2
	sw $t4, -100($fp)
	move $t2, $fp
	addi $t2, $t2, -88
	lw $t2, 0($t2)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -100
	lw $t4, 0($t4)
	lw $t4, 0($t4)
	sw $t4, 0($t2)
	li $s3, 1
	lw $s0, -36($fp)
	addi $sp, $sp, -4 
	sub $s1, $s0, $s3
	sw $s1, -108($fp)
	lw $s0, -108($fp)
	li $s1, 4
	addi $sp, $sp, -4 
	mul $t0, $s1, $s0
	sw $t0, -112($fp)
	lw $t0, -112($fp)
	lw $s0, -20($fp)
	addi $sp, $sp, -4 
	add $s7, $s0, $t0
	sw $s7, -116($fp)
	move $t0, $fp
	addi $t0, $t0, -116
	lw $t0, 0($t0)
	lw $s0, -80($fp)
	sw $s0, 0($t0)
	li $s7, 1
	lw $t3, -36($fp)
	addi $sp, $sp, -4 
	sub $t5, $t3, $s7
	sw $t5, -120($fp)
	lw $t5, -120($fp)
	lw $t6, -36($fp)
	move $t6, $t5
	sw $t6, -36($fp)
	j mylabel6
mylabel8:
	lw $t5, -12($fp)
	addi $sp, $sp, -4 
	addi $t6, $t5, 1
	sw $t6, -124($fp)
	lw $t5, -124($fp)
	lw $t6, -12($fp)
	move $t6, $t5
	sw $t6, -12($fp)
	j mylabel3
mylabel5:
	lw $t5, -12($fp)
	li $t5, 0
	sw $t5, -12($fp)
mylabel10:
	li $t5, 5
	lw $t6, -12($fp)
	blt $t6, $t5, mylabel11
	j mylabel12
mylabel11:
	lw $t8, -12($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $t7, $t9, $t8
	sw $t7, -128($fp)
	lw $t7, -128($fp)
	lw $t8, -20($fp)
	addi $sp, $sp, -4 
	add $s2, $t8, $t7
	sw $s2, -132($fp)
	addi $sp, $sp, -4 
	move $t7, $fp
	addi $t7, $t7, -132
	lw $t7, 0($t7)
	lw $t7, 0($t7)
	move $a0, $t7
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t7, -12($fp)
	addi $sp, $sp, -4 
	addi $t8, $t7, 1
	sw $t8, -140($fp)
	lw $t7, -140($fp)
	lw $t8, -12($fp)
	move $t8, $t7
	sw $t8, -12($fp)
	j mylabel10
mylabel12:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
