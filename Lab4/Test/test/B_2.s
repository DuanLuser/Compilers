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
	li $t0, 10
	sw $t0, -4($fp)
	addi $sp, $sp, -40 
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -48($fp)
	addi $sp, $sp, -4 
	li $t2, 0
	sw $t2, -52($fp)
mylabel0:
	li $t3, 10
	lw $t4, -48($fp)
	blt $t4, $t3, mylabel1
	j mylabel2
mylabel1:
	lw $t5, -48($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $t7, $t6, $t5
	sw $t7, -56($fp)
	lw $t8, -56($fp)
	addi $sp, $sp, -4 
	move $t9, $fp
	addi $t9, $t9, -44
	sw $t9, -60($fp)
	addi $sp, $sp, -4 
	add $s0, $t9, $t8
	sw $s0, -64($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $s1, $v0
	sw $s1, -68($fp)
	move $s2, $fp
	addi $s2, $s2, -64
	lw $s2, 0($s2)
	lw $s3, -68($fp)
	sw $s3, 0($s2)
	lw $s4, -48($fp)
	addi $sp, $sp, -4 
	addi $s5, $s4, 1
	sw $s5, -72($fp)
	lw $s6, -72($fp)
	lw $s7, -48($fp)
	move $s7, $s6
	sw $s7, -48($fp)
	j mylabel0
mylabel2:
	li $t0, 2
	lw $t1, -4($fp)
	div $t1, $t0
	addi $sp, $sp, -4 
	mflo $t2
	sw $t2, -76($fp)
	lw $t1, -76($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -80($fp)
mylabel3:
	li $t1, 0
	lw $t2, -80($fp)
	bge $t2, $t1, mylabel4
	j mylabel5
mylabel4:
	lw $t5, -52($fp)
	li $t5, 0
	sw $t5, -52($fp)
	lw $t5, -80($fp)
	lw $t7, -48($fp)
	move $t7, $t5
	sw $t7, -48($fp)
mylabel6:
	li $t5, 0
	lw $t7, -52($fp)
	beq $t7, $t5, mylabel7
	j mylabel8
mylabel7:
	lw $t8, -52($fp)
	li $t8, 1
	sw $t8, -52($fp)
	li $t8, 2
	lw $t9, -48($fp)
	addi $sp, $sp, -4 
	mul $s0, $t9, $t8
	sw $s0, -84($fp)
	lw $t9, -84($fp)
	addi $sp, $sp, -4 
	addi $s0, $t9, 1
	sw $s0, -88($fp)
	lw $t9, -88($fp)
	addi $sp, $sp, -4 
	move $s0, $t9
	sw $s0, -92($fp)
	li $t9, 2
	lw $s0, -48($fp)
	addi $sp, $sp, -4 
	mul $s1, $s0, $t9
	sw $s1, -96($fp)
	lw $s0, -96($fp)
	addi $sp, $sp, -4 
	addi $s1, $s0, 2
	sw $s1, -100($fp)
	lw $s0, -100($fp)
	addi $sp, $sp, -4 
	move $s1, $s0
	sw $s1, -104($fp)
	lw $s0, -4($fp)
	lw $s1, -92($fp)
	blt $s1, $s0, mylabel9
	j mylabel10
mylabel9:
	lw $s4, -92($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s6, $s5, $s4
	sw $s6, -108($fp)
	lw $s4, -108($fp)
	lw $s6, -60($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s4
	sw $s7, -112($fp)
	addi $sp, $sp, -4 
	move $s4, $fp
	addi $s4, $s4, -112
	lw $s4, 0($s4)
	lw $s4, 0($s4)
	addi $sp, $sp, -4 
	move $s6, $s4
	sw $s6, -120($fp)
	lw $s4, -4($fp)
	lw $s6, -104($fp)
	blt $s6, $s4, mylabel13
	j mylabel12
mylabel13:
	lw $s7, -104($fp)
	li $t3, 4
	addi $sp, $sp, -4 
	mul $t4, $t3, $s7
	sw $t4, -124($fp)
	lw $t4, -124($fp)
	lw $s7, -60($fp)
	addi $sp, $sp, -4 
	add $t6, $s7, $t4
	sw $t6, -128($fp)
	lw $t4, -92($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $s7, $t6, $t4
	sw $s7, -132($fp)
	lw $t4, -132($fp)
	lw $s7, -60($fp)
	addi $sp, $sp, -4 
	add $s2, $s7, $t4
	sw $s2, -136($fp)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -136
	lw $t4, 0($t4)
	lw $t4, 0($t4)
	addi $sp, $sp, -4 
	move $s2, $fp
	addi $s2, $s2, -128
	lw $s2, 0($s2)
	lw $s2, 0($s2)
	blt $s2, $t4, mylabel11
	j mylabel12
mylabel11:
	lw $s7, -104($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $t0, $s3, $s7
	sw $t0, -148($fp)
	lw $t0, -148($fp)
	lw $s7, -60($fp)
	addi $sp, $sp, -4 
	add $t1, $s7, $t0
	sw $t1, -152($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -152
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	lw $t1, -120($fp)
	move $t1, $t0
	sw $t1, -120($fp)
	lw $t0, -104($fp)
	lw $t1, -92($fp)
	move $t1, $t0
	sw $t1, -92($fp)
mylabel12:
	lw $t0, -48($fp)
	li $t1, 4
	addi $sp, $sp, -4 
	mul $s7, $t1, $t0
	sw $s7, -160($fp)
	lw $t0, -160($fp)
	lw $s7, -60($fp)
	addi $sp, $sp, -4 
	add $t2, $s7, $t0
	sw $t2, -164($fp)
	lw $t0, -120($fp)
	addi $sp, $sp, -4 
	move $t2, $fp
	addi $t2, $t2, -164
	lw $t2, 0($t2)
	lw $t2, 0($t2)
	bgt $t2, $t0, mylabel14
	j mylabel15
mylabel14:
	lw $s7, -52($fp)
	li $s7, 0
	sw $s7, -52($fp)
	lw $s7, -92($fp)
	li $t5, 4
	addi $sp, $sp, -4 
	mul $t7, $t5, $s7
	sw $t7, -172($fp)
	lw $t7, -172($fp)
	lw $s7, -60($fp)
	addi $sp, $sp, -4 
	add $t8, $s7, $t7
	sw $t8, -176($fp)
	lw $t7, -48($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s7, $t8, $t7
	sw $s7, -180($fp)
	lw $t7, -180($fp)
	lw $s7, -60($fp)
	addi $sp, $sp, -4 
	add $t9, $s7, $t7
	sw $t9, -184($fp)
	move $t7, $fp
	addi $t7, $t7, -176
	lw $t7, 0($t7)
	addi $sp, $sp, -4 
	move $t9, $fp
	addi $t9, $t9, -184
	lw $t9, 0($t9)
	lw $t9, 0($t9)
	sw $t9, 0($t7)
	lw $s7, -48($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s1, $s0, $s7
	sw $s1, -192($fp)
	lw $s1, -192($fp)
	lw $s7, -60($fp)
	addi $sp, $sp, -4 
	add $s5, $s7, $s1
	sw $s5, -196($fp)
	move $s1, $fp
	addi $s1, $s1, -196
	lw $s1, 0($s1)
	lw $s5, -120($fp)
	sw $s5, 0($s1)
	lw $s7, -92($fp)
	lw $s4, -48($fp)
	move $s4, $s7
	sw $s4, -48($fp)
mylabel15:
mylabel10:
	j mylabel6
mylabel8:
	li $s4, 1
	lw $s7, -80($fp)
	addi $sp, $sp, -4 
	sub $s6, $s7, $s4
	sw $s6, -200($fp)
	lw $s6, -200($fp)
	lw $s7, -80($fp)
	move $s7, $s6
	sw $s7, -80($fp)
	j mylabel3
mylabel5:
	lw $s6, -48($fp)
	li $s6, 0
	sw $s6, -48($fp)
mylabel16:
	lw $s6, -4($fp)
	lw $s7, -48($fp)
	blt $s7, $s6, mylabel17
	j mylabel18
mylabel17:
	lw $t3, -48($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $t4, $t6, $t3
	sw $t4, -204($fp)
	lw $t3, -204($fp)
	lw $t4, -60($fp)
	addi $sp, $sp, -4 
	add $s2, $t4, $t3
	sw $s2, -208($fp)
	addi $sp, $sp, -4 
	move $t3, $fp
	addi $t3, $t3, -208
	lw $t3, 0($t3)
	lw $t3, 0($t3)
	move $a0, $t3
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t3, -48($fp)
	addi $sp, $sp, -4 
	addi $t4, $t3, 1
	sw $t4, -216($fp)
	lw $t3, -216($fp)
	lw $t4, -48($fp)
	move $t4, $t3
	sw $t4, -48($fp)
	j mylabel16
mylabel18:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
