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

trap:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	li $t0, 0
	sw $t0, -4($fp)
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -8($fp)
	addi $sp, $sp, -4 
	li $t2, 0
	sw $t2, -12($fp)
	addi $sp, $sp, -4 
	li $t3, 0
	sw $t3, -16($fp)
	addi $sp, $sp, -4 
	li $t4, 0
	sw $t4, -20($fp)
	addi $sp, $sp, -4 
	li $t5, 12
	sw $t5, -24($fp)
	addi $sp, $sp, -4 
	li $t6, 0
	sw $t6, -28($fp)
	addi $sp, $sp, -48 
mylabel0:
	lw $t7, -24($fp)
	lw $t8, -12($fp)
	blt $t8, $t7, mylabel1
	j mylabel2
mylabel1:
	lw $t9, -12($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s1, $s0, $t9
	sw $s1, -80($fp)
	lw $s2, -80($fp)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -76
	sw $s3, -84($fp)
	addi $sp, $sp, -4 
	add $s4, $s3, $s2
	sw $s4, -88($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $s5, $v0
	sw $s5, -92($fp)
	move $s6, $fp
	addi $s6, $s6, -88
	lw $s6, 0($s6)
	lw $s7, -92($fp)
	sw $s7, 0($s6)
	lw $t0, -12($fp)
	addi $sp, $sp, -4 
	addi $t1, $t0, 1
	sw $t1, -96($fp)
	lw $t0, -96($fp)
	lw $t1, -12($fp)
	move $t1, $t0
	sw $t1, -12($fp)
	j mylabel0
mylabel2:
	lw $t0, -12($fp)
	li $t0, 0
	sw $t0, -12($fp)
mylabel3:
	lw $t0, -24($fp)
	lw $t1, -12($fp)
	blt $t1, $t0, mylabel6
	j mylabel5
mylabel6:
	lw $t2, -12($fp)
	li $t3, 4
	addi $sp, $sp, -4 
	mul $t4, $t3, $t2
	sw $t4, -100($fp)
	lw $t2, -100($fp)
	lw $t4, -84($fp)
	addi $sp, $sp, -4 
	add $t5, $t4, $t2
	sw $t5, -104($fp)
	li $t2, 0
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -104
	lw $t4, 0($t4)
	lw $t4, 0($t4)
	beq $t4, $t2, mylabel4
	j mylabel5
mylabel4:
	lw $t5, -12($fp)
	addi $sp, $sp, -4 
	addi $t6, $t5, 1
	sw $t6, -112($fp)
	lw $t5, -112($fp)
	lw $t6, -12($fp)
	move $t6, $t5
	sw $t6, -12($fp)
	j mylabel3
mylabel5:
	lw $t5, -24($fp)
	lw $t6, -12($fp)
	bge $t6, $t5, mylabel7
	j mylabel8
mylabel7:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel8:
	lw $t9, -12($fp)
	li $s1, 4
	addi $sp, $sp, -4 
	mul $s2, $s1, $t9
	sw $s2, -116($fp)
	lw $t9, -116($fp)
	lw $s2, -84($fp)
	addi $sp, $sp, -4 
	add $s3, $s2, $t9
	sw $s3, -120($fp)
	addi $sp, $sp, -4 
	move $t9, $fp
	addi $t9, $t9, -120
	lw $t9, 0($t9)
	lw $t9, 0($t9)
	lw $s2, -4($fp)
	move $s2, $t9
	sw $s2, -4($fp)
	lw $t9, -12($fp)
	lw $s2, -8($fp)
	move $s2, $t9
	sw $s2, -8($fp)
	lw $t9, -20($fp)
	li $t9, 0
	sw $t9, -20($fp)
	lw $t9, -12($fp)
	addi $sp, $sp, -4 
	addi $s2, $t9, 1
	sw $s2, -128($fp)
	lw $t9, -128($fp)
	lw $s2, -12($fp)
	move $s2, $t9
	sw $s2, -12($fp)
mylabel9:
	lw $t9, -24($fp)
	lw $s2, -12($fp)
	blt $s2, $t9, mylabel10
	j mylabel11
mylabel10:
	lw $s3, -12($fp)
	li $s4, 4
	addi $sp, $sp, -4 
	mul $s5, $s4, $s3
	sw $s5, -132($fp)
	lw $s3, -132($fp)
	lw $s5, -84($fp)
	addi $sp, $sp, -4 
	add $t7, $s5, $s3
	sw $t7, -136($fp)
	lw $t7, -4($fp)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -136
	lw $s3, 0($s3)
	lw $s3, 0($s3)
	blt $s3, $t7, mylabel12
	j mylabel13
mylabel12:
	lw $s5, -12($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s0, $t8, $s5
	sw $s0, -144($fp)
	lw $s0, -144($fp)
	lw $s6, -84($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s0
	sw $s7, -148($fp)
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -148
	lw $s0, 0($s0)
	lw $s0, 0($s0)
	lw $s6, -4($fp)
	addi $sp, $sp, -4 
	sub $s7, $s6, $s0
	sw $s7, -156($fp)
	lw $s0, -156($fp)
	lw $s6, -20($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s0
	sw $s7, -160($fp)
	lw $s0, -160($fp)
	lw $s6, -20($fp)
	move $s6, $s0
	sw $s6, -20($fp)
	j mylabel14
mylabel13:
	lw $s0, -20($fp)
	lw $s6, -16($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s0
	sw $s7, -164($fp)
	lw $s0, -164($fp)
	lw $s6, -16($fp)
	move $s6, $s0
	sw $s6, -16($fp)
	lw $s0, -12($fp)
	li $s6, 4
	addi $sp, $sp, -4 
	mul $s7, $s6, $s0
	sw $s7, -168($fp)
	lw $s0, -168($fp)
	lw $s7, -84($fp)
	addi $sp, $sp, -4 
	add $t0, $s7, $s0
	sw $t0, -172($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -172
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	lw $s0, -4($fp)
	move $s0, $t0
	sw $s0, -4($fp)
	lw $t0, -12($fp)
	lw $s0, -8($fp)
	move $s0, $t0
	sw $s0, -8($fp)
	lw $t0, -20($fp)
	li $t0, 0
	sw $t0, -20($fp)
mylabel14:
	lw $t0, -12($fp)
	addi $sp, $sp, -4 
	addi $s0, $t0, 1
	sw $s0, -180($fp)
	lw $t0, -180($fp)
	lw $s0, -12($fp)
	move $s0, $t0
	sw $s0, -12($fp)
	j mylabel9
mylabel11:
	lw $t0, -20($fp)
	li $t0, 0
	sw $t0, -20($fp)
	lw $t0, -28($fp)
	li $t0, 0
	sw $t0, -28($fp)
	li $t0, 1
	lw $s0, -24($fp)
	addi $sp, $sp, -4 
	sub $s7, $s0, $t0
	sw $s7, -184($fp)
	lw $s0, -184($fp)
	lw $s7, -12($fp)
	move $s7, $s0
	sw $s7, -12($fp)
mylabel15:
	lw $s0, -8($fp)
	lw $s7, -12($fp)
	bgt $s7, $s0, mylabel18
	j mylabel17
mylabel18:
	lw $t1, -12($fp)
	li $t3, 4
	addi $sp, $sp, -4 
	mul $t2, $t3, $t1
	sw $t2, -188($fp)
	lw $t1, -188($fp)
	lw $t2, -84($fp)
	addi $sp, $sp, -4 
	add $t4, $t2, $t1
	sw $t4, -192($fp)
	li $t1, 0
	addi $sp, $sp, -4 
	move $t2, $fp
	addi $t2, $t2, -192
	lw $t2, 0($t2)
	lw $t2, 0($t2)
	beq $t2, $t1, mylabel16
	j mylabel17
mylabel16:
	li $t4, 1
	lw $t5, -12($fp)
	addi $sp, $sp, -4 
	sub $t6, $t5, $t4
	sw $t6, -200($fp)
	lw $t6, -200($fp)
	lw $s1, -12($fp)
	move $s1, $t6
	sw $s1, -12($fp)
	j mylabel15
mylabel17:
	lw $t6, -12($fp)
	li $s1, 4
	addi $sp, $sp, -4 
	mul $t9, $s1, $t6
	sw $t9, -204($fp)
	lw $t6, -204($fp)
	lw $t9, -84($fp)
	addi $sp, $sp, -4 
	add $s2, $t9, $t6
	sw $s2, -208($fp)
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -208
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	lw $t9, -28($fp)
	move $t9, $t6
	sw $t9, -28($fp)
	li $t6, 1
	lw $t9, -12($fp)
	addi $sp, $sp, -4 
	sub $s2, $t9, $t6
	sw $s2, -216($fp)
	lw $t9, -216($fp)
	lw $s2, -12($fp)
	move $s2, $t9
	sw $s2, -12($fp)
mylabel19:
	lw $t9, -8($fp)
	lw $s2, -12($fp)
	bgt $s2, $t9, mylabel20
	j mylabel21
mylabel20:
	lw $s4, -12($fp)
	li $t7, 4
	addi $sp, $sp, -4 
	mul $s3, $t7, $s4
	sw $s3, -220($fp)
	lw $s3, -220($fp)
	lw $s4, -84($fp)
	addi $sp, $sp, -4 
	add $t8, $s4, $s3
	sw $t8, -224($fp)
	lw $t8, -28($fp)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -224
	lw $s3, 0($s3)
	lw $s3, 0($s3)
	blt $s3, $t8, mylabel22
	j mylabel23
mylabel22:
	lw $s4, -12($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s6, $s5, $s4
	sw $s6, -232($fp)
	lw $s6, -232($fp)
	lw $t0, -84($fp)
	addi $sp, $sp, -4 
	add $s0, $t0, $s6
	sw $s0, -236($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -236
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	lw $s0, -28($fp)
	addi $sp, $sp, -4 
	sub $s6, $s0, $t0
	sw $s6, -244($fp)
	lw $t0, -244($fp)
	lw $s0, -20($fp)
	addi $sp, $sp, -4 
	add $s6, $s0, $t0
	sw $s6, -248($fp)
	lw $t0, -248($fp)
	lw $s0, -20($fp)
	move $s0, $t0
	sw $s0, -20($fp)
	j mylabel24
mylabel23:
	lw $t0, -20($fp)
	lw $s0, -16($fp)
	addi $sp, $sp, -4 
	add $s6, $s0, $t0
	sw $s6, -252($fp)
	lw $t0, -252($fp)
	lw $s0, -16($fp)
	move $s0, $t0
	sw $s0, -16($fp)
	lw $t0, -12($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s6, $s0, $t0
	sw $s6, -256($fp)
	lw $t0, -256($fp)
	lw $s6, -84($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $t0
	sw $s7, -260($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -260
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	lw $s6, -28($fp)
	move $s6, $t0
	sw $s6, -28($fp)
	lw $t0, -20($fp)
	li $t0, 0
	sw $t0, -20($fp)
mylabel24:
	li $t0, 1
	lw $s6, -12($fp)
	addi $sp, $sp, -4 
	sub $s7, $s6, $t0
	sw $s7, -268($fp)
	lw $s6, -268($fp)
	lw $s7, -12($fp)
	move $s7, $s6
	sw $s7, -12($fp)
	j mylabel19
mylabel21:
	lw $s6, -20($fp)
	lw $s7, -16($fp)
	addi $sp, $sp, -4 
	add $t3, $s7, $s6
	sw $t3, -272($fp)
	lw $t3, -272($fp)
	move $v0, $t3 
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
	jal trap
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -4($fp)
	lw $t1, -4($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -8($fp)
	lw $t3, -8($fp)
	move $a0, $t3
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
