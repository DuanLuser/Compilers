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

countSort:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -20 
	addi $sp, $sp, -40 
	addi $sp, $sp, -20 
	addi $sp, $sp, -4 
	li $t0, 0
	sw $t0, -84($fp)
mylabel0:
	li $t1, 10
	lw $t2, -84($fp)
	blt $t2, $t1, mylabel1
	j mylabel2
mylabel1:
	lw $t3, -84($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -88($fp)
	lw $t6, -88($fp)
	addi $sp, $sp, -4 
	move $t7, $fp
	addi $t7, $t7, -60
	sw $t7, -92($fp)
	addi $sp, $sp, -4 
	add $t8, $t7, $t6
	sw $t8, -96($fp)
	move $t9, $fp
	addi $t9, $t9, -96
	lw $t9, 0($t9)
	li $s0, 0
	sw $s0, 0($t9)
	lw $s1, -84($fp)
	addi $sp, $sp, -4 
	addi $s2, $s1, 1
	sw $s2, -100($fp)
	lw $s3, -100($fp)
	lw $s4, -84($fp)
	move $s4, $s3
	sw $s4, -84($fp)
	j mylabel0
mylabel2:
	lw $s5, -84($fp)
	li $s5, 0
	sw $s5, -84($fp)
mylabel3:
	li $s6, 5
	lw $s7, -84($fp)
	blt $s7, $s6, mylabel4
	j mylabel5
mylabel4:
	lw $t0, -84($fp)
	li $t3, 4
	addi $sp, $sp, -4 
	mul $t5, $t3, $t0
	sw $t5, -104($fp)
	lw $t0, -104($fp)
	addi $sp, $sp, -4 
	move $t5, $fp
	addi $t5, $t5, -20
	sw $t5, -108($fp)
	addi $sp, $sp, -4 
	add $t5, $t5, $t0
	sw $t5, -112($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -116($fp)
	move $t0, $fp
	addi $t0, $t0, -112
	lw $t0, 0($t0)
	lw $t5, -116($fp)
	sw $t5, 0($t0)
	lw $t6, -84($fp)
	li $t7, 4
	addi $sp, $sp, -4 
	mul $t8, $t7, $t6
	sw $t8, -120($fp)
	lw $t6, -120($fp)
	lw $t8, -108($fp)
	addi $sp, $sp, -4 
	add $s1, $t8, $t6
	sw $s1, -124($fp)
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -124
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s1, $t8, $t6
	sw $s1, -132($fp)
	lw $t6, -132($fp)
	lw $s1, -92($fp)
	addi $sp, $sp, -4 
	add $s2, $s1, $t6
	sw $s2, -136($fp)
	lw $t6, -84($fp)
	li $s1, 4
	addi $sp, $sp, -4 
	mul $s2, $s1, $t6
	sw $s2, -140($fp)
	lw $t6, -140($fp)
	lw $s2, -108($fp)
	addi $sp, $sp, -4 
	add $s3, $s2, $t6
	sw $s3, -144($fp)
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -144
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $s3, $s2, $t6
	sw $s3, -152($fp)
	lw $t6, -152($fp)
	lw $s3, -92($fp)
	addi $sp, $sp, -4 
	add $s4, $s3, $t6
	sw $s4, -156($fp)
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -156
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	addi $sp, $sp, -4 
	addi $s3, $t6, 1
	sw $s3, -164($fp)
	move $t6, $fp
	addi $t6, $t6, -136
	lw $t6, 0($t6)
	lw $s3, -164($fp)
	sw $s3, 0($t6)
	lw $s4, -84($fp)
	addi $sp, $sp, -4 
	addi $s5, $s4, 1
	sw $s5, -168($fp)
	lw $s4, -168($fp)
	lw $s5, -84($fp)
	move $s5, $s4
	sw $s5, -84($fp)
	j mylabel3
mylabel5:
	lw $s4, -84($fp)
	li $s4, 1
	sw $s4, -84($fp)
mylabel6:
	li $s4, 10
	lw $s5, -84($fp)
	blt $s5, $s4, mylabel7
	j mylabel8
mylabel7:
	lw $t1, -84($fp)
	li $t2, 4
	addi $sp, $sp, -4 
	mul $t4, $t2, $t1
	sw $t4, -172($fp)
	lw $t4, -172($fp)
	lw $t9, -92($fp)
	addi $sp, $sp, -4 
	add $s0, $t9, $t4
	sw $s0, -176($fp)
	lw $t4, -84($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s0, $t9, $t4
	sw $s0, -180($fp)
	lw $t4, -180($fp)
	lw $s0, -92($fp)
	addi $sp, $sp, -4 
	add $s6, $s0, $t4
	sw $s6, -184($fp)
	li $t4, 1
	lw $s0, -84($fp)
	addi $sp, $sp, -4 
	sub $s6, $s0, $t4
	sw $s6, -188($fp)
	lw $s0, -188($fp)
	li $s6, 4
	addi $sp, $sp, -4 
	mul $s7, $s6, $s0
	sw $s7, -192($fp)
	lw $s0, -192($fp)
	lw $s7, -92($fp)
	addi $sp, $sp, -4 
	add $t3, $s7, $s0
	sw $t3, -196($fp)
	addi $sp, $sp, -4 
	move $t3, $fp
	addi $t3, $t3, -196
	lw $t3, 0($t3)
	lw $t3, 0($t3)
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -184
	lw $s0, 0($s0)
	lw $s0, 0($s0)
	addi $sp, $sp, -4 
	add $s7, $s0, $t3
	sw $s7, -208($fp)
	move $t3, $fp
	addi $t3, $t3, -176
	lw $t3, 0($t3)
	lw $s0, -208($fp)
	sw $s0, 0($t3)
	lw $s7, -84($fp)
	addi $sp, $sp, -4 
	addi $t0, $s7, 1
	sw $t0, -212($fp)
	lw $t0, -212($fp)
	lw $s7, -84($fp)
	move $s7, $t0
	sw $s7, -84($fp)
	j mylabel6
mylabel8:
	lw $t0, -84($fp)
	li $t0, 0
	sw $t0, -84($fp)
mylabel9:
	li $t0, 5
	lw $s7, -84($fp)
	blt $s7, $t0, mylabel10
	j mylabel11
mylabel10:
	lw $t5, -84($fp)
	li $t7, 4
	addi $sp, $sp, -4 
	mul $t8, $t7, $t5
	sw $t8, -216($fp)
	lw $t5, -216($fp)
	lw $t8, -108($fp)
	addi $sp, $sp, -4 
	add $s1, $t8, $t5
	sw $s1, -220($fp)
	addi $sp, $sp, -4 
	move $t5, $fp
	addi $t5, $t5, -220
	lw $t5, 0($t5)
	lw $t5, 0($t5)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s1, $t8, $t5
	sw $s1, -228($fp)
	lw $t5, -228($fp)
	lw $s1, -92($fp)
	addi $sp, $sp, -4 
	add $s2, $s1, $t5
	sw $s2, -232($fp)
	li $t5, 1
	addi $sp, $sp, -4 
	move $s1, $fp
	addi $s1, $s1, -232
	lw $s1, 0($s1)
	lw $s1, 0($s1)
	addi $sp, $sp, -4 
	sub $s2, $s1, $t5
	sw $s2, -240($fp)
	lw $s1, -240($fp)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $t6, $s2, $s1
	sw $t6, -244($fp)
	lw $t6, -244($fp)
	addi $sp, $sp, -4 
	move $s1, $fp
	addi $s1, $s1, -80
	sw $s1, -248($fp)
	addi $sp, $sp, -4 
	add $s1, $s1, $t6
	sw $s1, -252($fp)
	lw $t6, -84($fp)
	li $s1, 4
	addi $sp, $sp, -4 
	mul $s3, $s1, $t6
	sw $s3, -256($fp)
	lw $t6, -256($fp)
	lw $s3, -108($fp)
	addi $sp, $sp, -4 
	add $s4, $s3, $t6
	sw $s4, -260($fp)
	move $t6, $fp
	addi $t6, $t6, -252
	lw $t6, 0($t6)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -260
	lw $s3, 0($s3)
	lw $s3, 0($s3)
	sw $s3, 0($t6)
	lw $s4, -84($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $t1, $s5, $s4
	sw $t1, -268($fp)
	lw $t1, -268($fp)
	lw $t2, -108($fp)
	addi $sp, $sp, -4 
	add $t9, $t2, $t1
	sw $t9, -272($fp)
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -272
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	li $t2, 4
	addi $sp, $sp, -4 
	mul $t9, $t2, $t1
	sw $t9, -280($fp)
	lw $t1, -280($fp)
	lw $t9, -92($fp)
	addi $sp, $sp, -4 
	add $t4, $t9, $t1
	sw $t4, -284($fp)
	lw $t1, -84($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t9, $t4, $t1
	sw $t9, -288($fp)
	lw $t1, -288($fp)
	lw $t9, -108($fp)
	addi $sp, $sp, -4 
	add $s6, $t9, $t1
	sw $s6, -292($fp)
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -292
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s6, $t9, $t1
	sw $s6, -300($fp)
	lw $t1, -300($fp)
	lw $s6, -92($fp)
	addi $sp, $sp, -4 
	add $t3, $s6, $t1
	sw $t3, -304($fp)
	li $t1, 1
	addi $sp, $sp, -4 
	move $t3, $fp
	addi $t3, $t3, -304
	lw $t3, 0($t3)
	lw $t3, 0($t3)
	addi $sp, $sp, -4 
	sub $s6, $t3, $t1
	sw $s6, -312($fp)
	move $t3, $fp
	addi $t3, $t3, -284
	lw $t3, 0($t3)
	lw $s6, -312($fp)
	sw $s6, 0($t3)
	lw $s0, -84($fp)
	addi $sp, $sp, -4 
	addi $t0, $s0, 1
	sw $t0, -316($fp)
	lw $t0, -316($fp)
	lw $s0, -84($fp)
	move $s0, $t0
	sw $s0, -84($fp)
	j mylabel9
mylabel11:
	lw $t0, -84($fp)
	li $t0, 0
	sw $t0, -84($fp)
mylabel12:
	li $t0, 5
	lw $s0, -84($fp)
	blt $s0, $t0, mylabel13
	j mylabel14
mylabel13:
	lw $s7, -84($fp)
	li $t7, 4
	addi $sp, $sp, -4 
	mul $t8, $t7, $s7
	sw $t8, -320($fp)
	lw $t8, -320($fp)
	lw $s7, -248($fp)
	addi $sp, $sp, -4 
	add $t5, $s7, $t8
	sw $t5, -324($fp)
	addi $sp, $sp, -4 
	move $t5, $fp
	addi $t5, $t5, -324
	lw $t5, 0($t5)
	lw $t5, 0($t5)
	move $a0, $t5
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t5, -84($fp)
	addi $sp, $sp, -4 
	addi $t8, $t5, 1
	sw $t8, -332($fp)
	lw $t5, -332($fp)
	lw $t8, -84($fp)
	move $t8, $t5
	sw $t8, -84($fp)
	j mylabel12
mylabel14:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
bubbleSort:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -20 
	addi $sp, $sp, -4 
	li $t5, 0
	sw $t5, -24($fp)
mylabel15:
	li $t5, 5
	lw $t8, -24($fp)
	blt $t8, $t5, mylabel16
	j mylabel17
mylabel16:
	lw $s7, -24($fp)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $s1, $s2, $s7
	sw $s1, -28($fp)
	lw $s1, -28($fp)
	addi $sp, $sp, -4 
	move $s7, $fp
	addi $s7, $s7, -20
	sw $s7, -32($fp)
	addi $sp, $sp, -4 
	add $s7, $s7, $s1
	sw $s7, -36($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $s1, $v0
	sw $s1, -40($fp)
	move $s1, $fp
	addi $s1, $s1, -36
	lw $s1, 0($s1)
	lw $s7, -40($fp)
	sw $s7, 0($s1)
	lw $t6, -24($fp)
	addi $sp, $sp, -4 
	addi $s3, $t6, 1
	sw $s3, -44($fp)
	lw $t6, -44($fp)
	lw $s3, -24($fp)
	move $s3, $t6
	sw $s3, -24($fp)
	j mylabel15
mylabel17:
	addi $sp, $sp, -4 
	li $t6, 1
	sw $t6, -48($fp)
mylabel18:
	li $t6, 1
	lw $s3, -48($fp)
	beq $s3, $t6, mylabel19
	j mylabel20
mylabel19:
	lw $s4, -48($fp)
	li $s4, 0
	sw $s4, -48($fp)
	lw $s4, -24($fp)
	li $s4, 1
	sw $s4, -24($fp)
mylabel21:
	li $s4, 5
	lw $s5, -24($fp)
	blt $s5, $s4, mylabel22
	j mylabel23
mylabel22:
	lw $t2, -24($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t9, $t4, $t2
	sw $t9, -52($fp)
	lw $t2, -52($fp)
	lw $t9, -32($fp)
	addi $sp, $sp, -4 
	add $t1, $t9, $t2
	sw $t1, -56($fp)
	li $t1, 1
	lw $t2, -24($fp)
	addi $sp, $sp, -4 
	sub $t9, $t2, $t1
	sw $t9, -60($fp)
	lw $t2, -60($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $t3, $t9, $t2
	sw $t3, -64($fp)
	lw $t2, -64($fp)
	lw $t3, -32($fp)
	addi $sp, $sp, -4 
	add $s6, $t3, $t2
	sw $s6, -68($fp)
	addi $sp, $sp, -4 
	move $t2, $fp
	addi $t2, $t2, -68
	lw $t2, 0($t2)
	lw $t2, 0($t2)
	addi $sp, $sp, -4 
	move $t3, $fp
	addi $t3, $t3, -56
	lw $t3, 0($t3)
	lw $t3, 0($t3)
	blt $t3, $t2, mylabel24
	j mylabel25
mylabel24:
	lw $s6, -48($fp)
	li $s6, 1
	sw $s6, -48($fp)
	li $s6, 1
	lw $t0, -24($fp)
	addi $sp, $sp, -4 
	sub $s0, $t0, $s6
	sw $s0, -80($fp)
	lw $t0, -80($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $t7, $s0, $t0
	sw $t7, -84($fp)
	lw $t0, -84($fp)
	lw $t7, -32($fp)
	addi $sp, $sp, -4 
	add $t5, $t7, $t0
	sw $t5, -88($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -88
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	addi $sp, $sp, -4 
	move $t5, $t0
	sw $t5, -96($fp)
	li $t0, 1
	lw $t5, -24($fp)
	addi $sp, $sp, -4 
	sub $t7, $t5, $t0
	sw $t7, -100($fp)
	lw $t5, -100($fp)
	li $t7, 4
	addi $sp, $sp, -4 
	mul $t8, $t7, $t5
	sw $t8, -104($fp)
	lw $t5, -104($fp)
	lw $t8, -32($fp)
	addi $sp, $sp, -4 
	add $s2, $t8, $t5
	sw $s2, -108($fp)
	lw $t5, -24($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s2, $t8, $t5
	sw $s2, -112($fp)
	lw $t5, -112($fp)
	lw $s2, -32($fp)
	addi $sp, $sp, -4 
	add $s1, $s2, $t5
	sw $s1, -116($fp)
	move $t5, $fp
	addi $t5, $t5, -108
	lw $t5, 0($t5)
	addi $sp, $sp, -4 
	move $s1, $fp
	addi $s1, $s1, -116
	lw $s1, 0($s1)
	lw $s1, 0($s1)
	sw $s1, 0($t5)
	lw $s2, -24($fp)
	li $s7, 4
	addi $sp, $sp, -4 
	mul $t6, $s7, $s2
	sw $t6, -124($fp)
	lw $t6, -124($fp)
	lw $s2, -32($fp)
	addi $sp, $sp, -4 
	add $s3, $s2, $t6
	sw $s3, -128($fp)
	move $t6, $fp
	addi $t6, $t6, -128
	lw $t6, 0($t6)
	lw $s2, -96($fp)
	sw $s2, 0($t6)
mylabel25:
	lw $s3, -24($fp)
	addi $sp, $sp, -4 
	addi $s4, $s3, 1
	sw $s4, -132($fp)
	lw $s3, -132($fp)
	lw $s4, -24($fp)
	move $s4, $s3
	sw $s4, -24($fp)
	j mylabel21
mylabel23:
	j mylabel18
mylabel20:
	lw $s3, -24($fp)
	li $s3, 0
	sw $s3, -24($fp)
mylabel26:
	li $s3, 5
	lw $s4, -24($fp)
	blt $s4, $s3, mylabel27
	j mylabel28
mylabel27:
	lw $s5, -24($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t1, $t4, $s5
	sw $t1, -136($fp)
	lw $t1, -136($fp)
	lw $s5, -32($fp)
	addi $sp, $sp, -4 
	add $t9, $s5, $t1
	sw $t9, -140($fp)
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -140
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	move $a0, $t1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t1, -24($fp)
	addi $sp, $sp, -4 
	addi $t9, $t1, 1
	sw $t9, -148($fp)
	lw $t1, -148($fp)
	lw $t9, -24($fp)
	move $t9, $t1
	sw $t9, -24($fp)
	j mylabel26
mylabel28:
	li $v0, 0 
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
	sw $ra, 0($sp) 
	jal countSort
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -4($fp)
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal bubbleSort
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -8($fp)
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
