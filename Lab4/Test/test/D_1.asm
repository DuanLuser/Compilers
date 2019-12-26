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

process:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	lw $t0, -4($fp)
	addi $sp, $sp, -4 
	addi $t1, $t0, 24
	sw $t1, -8($fp)
	lw $t2, -8($fp)
	addi $sp, $sp, -4 
	addi $t3, $t2, 1
	sw $t3, -12($fp)
	lw $t4, -12($fp)
	addi $sp, $sp, -4 
	move $t5, $t4
	sw $t5, -16($fp)
	lw $t6, -16($fp)
	move $v0, $t6 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
main:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	li $t7, 13
	sw $t7, -4($fp)
	addi $sp, $sp, -4 
	li $t8, 20
	sw $t8, -8($fp)
	addi $sp, $sp, -4 
	li $t9, 15
	sw $t9, -12($fp)
	lw $s0, -8($fp)
	lw $s1, -4($fp)
	addi $sp, $sp, -4 
	add $s2, $s1, $s0
	sw $s2, -16($fp)
	lw $s3, -12($fp)
	lw $s4, -16($fp)
	addi $sp, $sp, -4 
	add $s5, $s4, $s3
	sw $s5, -20($fp)
	lw $s6, -20($fp)
	addi $sp, $sp, -4 
	move $s7, $s6
	sw $s7, -24($fp)
	lw $t0, -8($fp)
	lw $t1, -4($fp)
	addi $sp, $sp, -4 
	mul $t2, $t1, $t0
	sw $t2, -28($fp)
	li $t0, 2
	lw $t1, -12($fp)
	div $t1, $t0
	addi $sp, $sp, -4 
	mflo $t2
	sw $t2, -32($fp)
	lw $t1, -32($fp)
	lw $t2, -28($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -36($fp)
	lw $t1, -36($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -40($fp)
	lw $t1, -8($fp)
	lw $t2, -4($fp)
	addi $sp, $sp, -4 
	sub $t3, $t2, $t1
	sw $t3, -44($fp)
	lw $t1, -12($fp)
	lw $t2, -44($fp)
	addi $sp, $sp, -4 
	sub $t3, $t2, $t1
	sw $t3, -48($fp)
	lw $t1, -48($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -52($fp)
	addi $sp, $sp, -4 
	li $t1, 42
	sw $t1, -56($fp)
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -60($fp)
	lw $t1, -8($fp)
	lw $t2, -4($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -64($fp)
	lw $t1, -12($fp)
	lw $t2, -64($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -68($fp)
	lw $t1, -68($fp)
	addi $sp, $sp, -4 
	addi $t2, $t1, 2000
	sw $t2, -72($fp)
	lw $t1, -52($fp)
	lw $t2, -72($fp)
	addi $sp, $sp, -4 
	sub $t3, $t2, $t1
	sw $t3, -76($fp)
	lw $t1, -76($fp)
	lw $t2, -52($fp)
	move $t2, $t1
	sw $t2, -52($fp)
mylabel0:
	lw $t1, -8($fp)
	lw $t2, -4($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -80($fp)
	lw $t1, -52($fp)
	lw $t2, -80($fp)
	blt $t2, $t1, mylabel1
	j mylabel2
mylabel1:
	li $t3, 12
	lw $t4, -60($fp)
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -84($fp)
	lw $t4, -84($fp)
	lw $t5, -56($fp)
	addi $sp, $sp, -4 
	add $t7, $t5, $t4
	sw $t7, -88($fp)
	lw $t4, -88($fp)
	addi $sp, $sp, -4 
	addi $t5, $t4, 4
	sw $t5, -92($fp)
	lw $t4, -92($fp)
	addi $sp, $sp, -4 
	addi $t5, $t4, 5
	sw $t5, -96($fp)
	lw $t4, -96($fp)
	addi $sp, $sp, -4 
	addi $t5, $t4, 2
	sw $t5, -100($fp)
	lw $t4, -100($fp)
	lw $t5, -56($fp)
	move $t5, $t4
	sw $t5, -56($fp)
	lw $a0, -52($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -104($fp)
	lw $t1, -4($fp)
	li $t2, 2
	addi $sp, $sp, -4 
	mul $t3, $t2, $t1
	sw $t3, -108($fp)
	lw $t4, -108($fp)
	lw $t5, -104($fp)
	addi $sp, $sp, -4 
	add $t6, $t5, $t4
	sw $t6, -112($fp)
	lw $t7, -52($fp)
	lw $t8, -112($fp)
	addi $sp, $sp, -4 
	sub $t9, $t8, $t7
	sw $t9, -116($fp)
	lw $s0, -24($fp)
	lw $s1, -12($fp)
	addi $sp, $sp, -4 
	mul $s2, $s1, $s0
	sw $s2, -120($fp)
	lw $s3, -120($fp)
	lw $s4, -116($fp)
	addi $sp, $sp, -4 
	add $s5, $s4, $s3
	sw $s5, -124($fp)
	lw $s6, -124($fp)
	addi $sp, $sp, -4 
	move $s7, $s6
	sw $s7, -128($fp)
	lw $t0, -60($fp)
	addi $sp, $sp, -4 
	add $t1, $t0, $t0
	sw $t1, -132($fp)
	lw $t0, -132($fp)
	lw $t1, -60($fp)
	move $t1, $t0
	sw $t1, -60($fp)
	lw $t0, -60($fp)
	addi $sp, $sp, -4 
	add $t1, $t0, $t0
	sw $t1, -136($fp)
	lw $t0, -136($fp)
	lw $t1, -60($fp)
	move $t1, $t0
	sw $t1, -60($fp)
	lw $t0, -60($fp)
	addi $sp, $sp, -4 
	add $t1, $t0, $t0
	sw $t1, -140($fp)
	lw $t0, -140($fp)
	lw $t1, -60($fp)
	move $t1, $t0
	sw $t1, -60($fp)
	lw $t0, -60($fp)
	addi $sp, $sp, -4 
	add $t1, $t0, $t0
	sw $t1, -144($fp)
	lw $t0, -144($fp)
	lw $t1, -60($fp)
	move $t1, $t0
	sw $t1, -60($fp)
	lw $t0, -60($fp)
	addi $sp, $sp, -4 
	add $t1, $t0, $t0
	sw $t1, -148($fp)
	lw $t0, -148($fp)
	lw $t1, -60($fp)
	move $t1, $t0
	sw $t1, -60($fp)
	lw $t0, -60($fp)
	addi $sp, $sp, -4 
	addi $t1, $t0, 3
	sw $t1, -152($fp)
	lw $t0, -152($fp)
	addi $sp, $sp, -4 
	move $t1, $t0
	sw $t1, -156($fp)
	li $t0, 1
	lw $t1, -156($fp)
	addi $sp, $sp, -4 
	sub $t3, $t1, $t0
	sw $t3, -160($fp)
	lw $t1, -160($fp)
	lw $t3, -156($fp)
	move $t3, $t1
	sw $t3, -156($fp)
	lw $t1, -156($fp)
	addi $sp, $sp, -4 
	addi $t3, $t1, 3
	sw $t3, -164($fp)
	lw $t1, -164($fp)
	lw $t3, -156($fp)
	move $t3, $t1
	sw $t3, -156($fp)
	li $t1, 6
	lw $t3, -156($fp)
	addi $sp, $sp, -4 
	sub $t4, $t3, $t1
	sw $t4, -168($fp)
	lw $t3, -168($fp)
	lw $t4, -156($fp)
	move $t4, $t3
	sw $t4, -156($fp)
	lw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -172($fp)
	lw $t1, -4($fp)
	addi $sp, $sp, -4 
	addi $t2, $t1, 3
	sw $t2, -176($fp)
	li $t3, 2
	lw $t4, -176($fp)
	addi $sp, $sp, -4 
	sub $t5, $t4, $t3
	sw $t5, -180($fp)
	li $t6, 1
	lw $t7, -180($fp)
	addi $sp, $sp, -4 
	sub $t8, $t7, $t6
	sw $t8, -184($fp)
	lw $a0, -184($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal process
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -188($fp)
	lw $t1, -188($fp)
	lw $t2, -172($fp)
	beq $t2, $t1, mylabel3
	j mylabel4
mylabel3:
	li $t3, 2
	lw $t4, -52($fp)
	addi $sp, $sp, -4 
	sub $t5, $t4, $t3
	sw $t5, -192($fp)
	lw $t6, -192($fp)
	addi $sp, $sp, -4 
	addi $t7, $t6, 1
	sw $t7, -196($fp)
	lw $t8, -196($fp)
	lw $t9, -52($fp)
	move $t9, $t8
	sw $t9, -52($fp)
mylabel4:
	lw $s0, -4($fp)
	addi $sp, $sp, -4 
	addi $s1, $s0, 2
	sw $s1, -200($fp)
	lw $s2, -200($fp)
	addi $sp, $sp, -4 
	addi $s3, $s2, 1
	sw $s3, -204($fp)
	lw $s4, -204($fp)
	lw $s5, -4($fp)
	move $s5, $s4
	sw $s5, -4($fp)
	j mylabel0
mylabel2:
	li $s6, 12
	lw $s7, -56($fp)
	addi $sp, $sp, -4 
	sub $t0, $s7, $s6
	sw $t0, -208($fp)
	lw $t0, -208($fp)
	lw $t4, -156($fp)
	move $t4, $t0
	sw $t4, -156($fp)
mylabel5:
	lw $t0, -56($fp)
	lw $t4, -156($fp)
	blt $t4, $t0, mylabel6
	j mylabel7
mylabel6:
	lw $t5, -4($fp)
	addi $sp, $sp, -4 
	addi $t6, $t5, 58
	sw $t6, -212($fp)
	lw $t5, -212($fp)
	lw $t6, -52($fp)
	move $t6, $t5
	sw $t6, -52($fp)
	lw $t5, -156($fp)
	addi $sp, $sp, -4 
	addi $t6, $t5, 1
	sw $t6, -216($fp)
	lw $t5, -216($fp)
	lw $t6, -156($fp)
	move $t6, $t5
	sw $t6, -156($fp)
	lw $t5, -56($fp)
	lw $t6, -128($fp)
	move $t6, $t5
	sw $t6, -128($fp)
	lw $t5, -8($fp)
	lw $t6, -4($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -220($fp)
	lw $t5, -220($fp)
	lw $t6, -60($fp)
	move $t6, $t5
	sw $t6, -60($fp)
	lw $t5, -8($fp)
	lw $t6, -4($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -224($fp)
	lw $t5, -224($fp)
	lw $t6, -12($fp)
	move $t6, $t5
	sw $t6, -12($fp)
	j mylabel5
mylabel7:
	lw $t5, -52($fp)
	move $a0, $t5
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t5, -8($fp)
	lw $t6, -4($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -228($fp)
	lw $t5, -228($fp)
	lw $t6, -4($fp)
	move $t6, $t5
	sw $t6, -4($fp)
	lw $t5, -8($fp)
	lw $t6, -4($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -232($fp)
	lw $t5, -232($fp)
	lw $t6, -8($fp)
	move $t6, $t5
	sw $t6, -8($fp)
	lw $t5, -8($fp)
	lw $t6, -4($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -236($fp)
	lw $t5, -236($fp)
	lw $t6, -12($fp)
	move $t6, $t5
	sw $t6, -12($fp)
	lw $t5, -8($fp)
	lw $t6, -4($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -240($fp)
	lw $t5, -240($fp)
	lw $t6, -52($fp)
	move $t6, $t5
	sw $t6, -52($fp)
	lw $t5, -8($fp)
	lw $t6, -4($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -244($fp)
	lw $t5, -244($fp)
	lw $t6, -128($fp)
	move $t6, $t5
	sw $t6, -128($fp)
	lw $t5, -52($fp)
	lw $t6, -12($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -248($fp)
	lw $t5, -128($fp)
	lw $t6, -248($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -252($fp)
	lw $t5, -252($fp)
	move $a0, $t5
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
