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

display:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $a1, -8($fp) 
	addi $sp, $sp, -4 
	sw $a2, -12($fp) 
	addi $sp, $sp, -400 
	addi $sp, $sp, -4 
	li $t0, 0
	sw $t0, -416($fp)
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -420($fp)
	addi $sp, $sp, -4 
	li $t2, 1
	sw $t2, -424($fp)
	lw $t3, -8($fp)
	addi $sp, $sp, -4 
	addi $t4, $t3, 0
	sw $t4, -428($fp)
	li $t5, 1
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -428
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	beq $t6, $t5, mylabel0
	j mylabel1
mylabel0:
mylabel2:
	lw $t7, -12($fp)
	lw $t8, -416($fp)
	blt $t8, $t7, mylabel3
	j mylabel4
mylabel3:
	lw $t9, -420($fp)
	li $t9, 0
	sw $t9, -420($fp)
	lw $s0, -424($fp)
	li $s0, 1
	sw $s0, -424($fp)
mylabel5:
	lw $s1, -12($fp)
	lw $s2, -420($fp)
	blt $s2, $s1, mylabel6
	j mylabel7
mylabel6:
	lw $s3, -416($fp)
	li $s4, 4
	addi $sp, $sp, -4 
	mul $s5, $s4, $s3
	sw $s5, -436($fp)
	lw $s6, -436($fp)
	lw $s7, -4($fp)
	addi $sp, $sp, -4 
	add $t0, $s7, $s6
	sw $t0, -440($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -440
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	lw $t1, -420($fp)
	beq $t1, $t0, mylabel8
	j mylabel9
mylabel8:
	lw $t2, -416($fp)
	li $t3, 40
	addi $sp, $sp, -4 
	mul $t4, $t3, $t2
	sw $t4, -448($fp)
	lw $t2, -448($fp)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -412
	sw $t4, -452($fp)
	addi $sp, $sp, -4 
	add $t4, $t4, $t2
	sw $t4, -456($fp)
	lw $t2, -420($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t9, $t4, $t2
	sw $t9, -460($fp)
	lw $t2, -460($fp)
	lw $t9, -456($fp)
	addi $sp, $sp, -4 
	add $s0, $t9, $t2
	sw $s0, -464($fp)
	move $t2, $fp
	addi $t2, $t2, -464
	lw $t2, 0($t2)
	li $t9, 1
	sw $t9, 0($t2)
	li $s0, 10
	lw $s3, -424($fp)
	addi $sp, $sp, -4 
	mul $s5, $s3, $s0
	sw $s5, -468($fp)
	lw $s3, -468($fp)
	addi $sp, $sp, -4 
	addi $s5, $s3, 1
	sw $s5, -472($fp)
	lw $s3, -472($fp)
	lw $s5, -424($fp)
	move $s5, $s3
	sw $s5, -424($fp)
	j mylabel10
mylabel9:
	lw $s3, -416($fp)
	li $s5, 40
	addi $sp, $sp, -4 
	mul $s6, $s5, $s3
	sw $s6, -476($fp)
	lw $s3, -476($fp)
	lw $s6, -452($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s3
	sw $s7, -480($fp)
	lw $s3, -420($fp)
	li $s6, 4
	addi $sp, $sp, -4 
	mul $s7, $s6, $s3
	sw $s7, -484($fp)
	lw $s3, -484($fp)
	lw $s7, -480($fp)
	addi $sp, $sp, -4 
	add $t5, $s7, $s3
	sw $t5, -488($fp)
	move $t5, $fp
	addi $t5, $t5, -488
	lw $t5, 0($t5)
	li $s3, 0
	sw $s3, 0($t5)
	li $s7, 10
	lw $t6, -424($fp)
	addi $sp, $sp, -4 
	mul $t7, $t6, $s7
	sw $t7, -492($fp)
	lw $t6, -492($fp)
	lw $t7, -424($fp)
	move $t7, $t6
	sw $t7, -424($fp)
mylabel10:
	lw $t6, -420($fp)
	addi $sp, $sp, -4 
	addi $t7, $t6, 1
	sw $t7, -496($fp)
	lw $t6, -496($fp)
	lw $t7, -420($fp)
	move $t7, $t6
	sw $t7, -420($fp)
	j mylabel5
mylabel7:
	lw $t6, -424($fp)
	move $a0, $t6
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t6, -416($fp)
	addi $sp, $sp, -4 
	addi $t7, $t6, 1
	sw $t7, -500($fp)
	lw $t6, -500($fp)
	lw $t7, -416($fp)
	move $t7, $t6
	sw $t7, -416($fp)
	j mylabel2
mylabel4:
mylabel1:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
dfs:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $a1, -8($fp) 
	addi $sp, $sp, -4 
	sw $a2, -12($fp) 
	addi $sp, $sp, -4 
	sw $a3, -16($fp) 
	addi $sp, $sp, -4 
	lw $a3, 8($fp) 
	sw $a3, -20($fp) 
	addi $sp, $sp, -4 
	lw $a3, 12($fp) 
	sw $a3, -24($fp) 
	addi $sp, $sp, -4 
	lw $a3, 16($fp) 
	sw $a3, -28($fp) 
	addi $sp, $sp, -4 
	li $t6, 0
	sw $t6, -32($fp)
	addi $sp, $sp, -40 
	addi $sp, $sp, -40 
	lw $t6, -24($fp)
	lw $t7, -20($fp)
	beq $t7, $t6, mylabel11
	j mylabel12
mylabel11:
	lw $t8, -28($fp)
	addi $sp, $sp, -4 
	addi $s1, $t8, 0
	sw $s1, -116($fp)
	lw $t8, -28($fp)
	addi $sp, $sp, -4 
	addi $s1, $t8, 0
	sw $s1, -120($fp)
	addi $sp, $sp, -4 
	move $t8, $fp
	addi $t8, $t8, -120
	lw $t8, 0($t8)
	lw $t8, 0($t8)
	addi $sp, $sp, -4 
	addi $s1, $t8, 1
	sw $s1, -128($fp)
	move $t8, $fp
	addi $t8, $t8, -116
	lw $t8, 0($t8)
	lw $s1, -128($fp)
	sw $s1, 0($t8)
	lw $a0, -4($fp) 
	lw $a1, -28($fp) 
	lw $a2, -24($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal display
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -132($fp)
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel12:
mylabel13:
	lw $t1, -24($fp)
	lw $t2, -32($fp)
	blt $t2, $t1, mylabel14
	j mylabel15
mylabel14:
	lw $t3, -32($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -136($fp)
	lw $t6, -136($fp)
	lw $t7, -8($fp)
	addi $sp, $sp, -4 
	add $t8, $t7, $t6
	sw $t8, -140($fp)
	li $t9, 1
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -140
	lw $s0, 0($s0)
	lw $s0, 0($s0)
	beq $s0, $t9, mylabel19
	j mylabel17
mylabel19:
	lw $s1, -32($fp)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $s3, $s2, $s1
	sw $s3, -148($fp)
	lw $s4, -148($fp)
	lw $s5, -12($fp)
	addi $sp, $sp, -4 
	add $s6, $s5, $s4
	sw $s6, -152($fp)
	li $s7, 1
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -152
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	beq $t0, $s7, mylabel18
	j mylabel17
mylabel18:
	lw $t3, -32($fp)
	li $t5, 4
	addi $sp, $sp, -4 
	mul $t6, $t5, $t3
	sw $t6, -160($fp)
	lw $t3, -160($fp)
	lw $t6, -16($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t3
	sw $t7, -164($fp)
	li $t3, 1
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -164
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	beq $t6, $t3, mylabel16
	j mylabel17
mylabel16:
	lw $t7, -20($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s1, $t8, $t7
	sw $s1, -172($fp)
	lw $t7, -172($fp)
	lw $s1, -4($fp)
	addi $sp, $sp, -4 
	add $s3, $s1, $t7
	sw $s3, -176($fp)
	move $t7, $fp
	addi $t7, $t7, -176
	lw $t7, 0($t7)
	lw $s1, -32($fp)
	sw $s1, 0($t7)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $s4, $s3, $s1
	sw $s4, -180($fp)
	lw $s1, -180($fp)
	lw $s4, -8($fp)
	addi $sp, $sp, -4 
	add $s5, $s4, $s1
	sw $s5, -184($fp)
	move $s1, $fp
	addi $s1, $s1, -184
	lw $s1, 0($s1)
	li $s4, 0
	sw $s4, 0($s1)
	addi $sp, $sp, -4 
	li $s5, 0
	sw $s5, -188($fp)
mylabel20:
	li $s5, 1
	lw $s6, -24($fp)
	addi $sp, $sp, -4 
	sub $t1, $s6, $s5
	sw $t1, -192($fp)
	lw $t1, -192($fp)
	lw $t2, -188($fp)
	blt $t2, $t1, mylabel21
	j mylabel22
mylabel21:
	lw $t4, -188($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s0, $t9, $t4
	sw $s0, -196($fp)
	lw $t4, -196($fp)
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -72
	sw $s0, -200($fp)
	addi $sp, $sp, -4 
	add $s0, $s0, $t4
	sw $s0, -204($fp)
	lw $t4, -188($fp)
	addi $sp, $sp, -4 
	addi $s0, $t4, 1
	sw $s0, -208($fp)
	lw $t4, -208($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s2, $s0, $t4
	sw $s2, -212($fp)
	lw $t4, -212($fp)
	lw $s2, -12($fp)
	addi $sp, $sp, -4 
	add $t0, $s2, $t4
	sw $t0, -216($fp)
	move $t0, $fp
	addi $t0, $t0, -204
	lw $t0, 0($t0)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -216
	lw $t4, 0($t4)
	lw $t4, 0($t4)
	sw $t4, 0($t0)
	lw $s2, -188($fp)
	addi $sp, $sp, -4 
	addi $s7, $s2, 1
	sw $s7, -224($fp)
	lw $s2, -224($fp)
	lw $s7, -188($fp)
	move $s7, $s2
	sw $s7, -188($fp)
	j mylabel20
mylabel22:
	li $s2, 1
	lw $s7, -24($fp)
	addi $sp, $sp, -4 
	sub $t5, $s7, $s2
	sw $t5, -228($fp)
	lw $t5, -228($fp)
	li $s7, 4
	addi $sp, $sp, -4 
	mul $t3, $s7, $t5
	sw $t3, -232($fp)
	lw $t3, -232($fp)
	lw $t5, -200($fp)
	addi $sp, $sp, -4 
	add $t6, $t5, $t3
	sw $t6, -236($fp)
	move $t3, $fp
	addi $t3, $t3, -236
	lw $t3, 0($t3)
	li $t5, 1
	sw $t5, 0($t3)
	li $t6, 0
	lw $t8, -32($fp)
	bne $t8, $t6, mylabel23
	j mylabel24
mylabel23:
	li $t7, 1
	lw $s3, -32($fp)
	addi $sp, $sp, -4 
	sub $s1, $s3, $t7
	sw $s1, -240($fp)
	lw $s1, -240($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $s4, $s3, $s1
	sw $s4, -244($fp)
	lw $s1, -244($fp)
	lw $s4, -200($fp)
	addi $sp, $sp, -4 
	add $s5, $s4, $s1
	sw $s5, -248($fp)
	move $s1, $fp
	addi $s1, $s1, -248
	lw $s1, 0($s1)
	li $s4, 0
	sw $s4, 0($s1)
mylabel24:
	li $s5, 1
	lw $s6, -24($fp)
	addi $sp, $sp, -4 
	sub $t1, $s6, $s5
	sw $t1, -252($fp)
	lw $t1, -252($fp)
	lw $s6, -188($fp)
	move $s6, $t1
	sw $s6, -188($fp)
mylabel25:
	li $t1, 0
	lw $s6, -188($fp)
	bgt $s6, $t1, mylabel26
	j mylabel27
mylabel26:
	lw $t2, -188($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s0, $t9, $t2
	sw $s0, -256($fp)
	lw $t2, -256($fp)
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -112
	sw $s0, -260($fp)
	addi $sp, $sp, -4 
	add $s0, $s0, $t2
	sw $s0, -264($fp)
	li $t2, 1
	lw $s0, -188($fp)
	addi $sp, $sp, -4 
	sub $t0, $s0, $t2
	sw $t0, -268($fp)
	lw $t0, -268($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $t4, $s0, $t0
	sw $t4, -272($fp)
	lw $t0, -272($fp)
	lw $t4, -16($fp)
	addi $sp, $sp, -4 
	add $s2, $t4, $t0
	sw $s2, -276($fp)
	move $t0, $fp
	addi $t0, $t0, -264
	lw $t0, 0($t0)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -276
	lw $t4, 0($t4)
	lw $t4, 0($t4)
	sw $t4, 0($t0)
	li $s2, 1
	lw $s7, -188($fp)
	addi $sp, $sp, -4 
	sub $t3, $s7, $s2
	sw $t3, -284($fp)
	lw $t3, -284($fp)
	lw $s7, -188($fp)
	move $s7, $t3
	sw $s7, -188($fp)
	j mylabel25
mylabel27:
	lw $t3, -260($fp)
	addi $sp, $sp, -4 
	addi $s7, $t3, 0
	sw $s7, -288($fp)
	move $t3, $fp
	addi $t3, $t3, -288
	lw $t3, 0($t3)
	li $s7, 1
	sw $s7, 0($t3)
	li $t5, 1
	lw $t6, -24($fp)
	addi $sp, $sp, -4 
	sub $t8, $t6, $t5
	sw $t8, -292($fp)
	lw $t6, -292($fp)
	lw $t8, -32($fp)
	bne $t8, $t6, mylabel28
	j mylabel29
mylabel28:
	lw $t7, -32($fp)
	addi $sp, $sp, -4 
	addi $s3, $t7, 1
	sw $s3, -296($fp)
	lw $t7, -296($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $s1, $s3, $t7
	sw $s1, -300($fp)
	lw $t7, -300($fp)
	lw $s1, -260($fp)
	addi $sp, $sp, -4 
	add $s4, $s1, $t7
	sw $s4, -304($fp)
	move $t7, $fp
	addi $t7, $t7, -304
	lw $t7, 0($t7)
	li $s1, 0
	sw $s1, 0($t7)
mylabel29:
	lw $s4, -20($fp)
	addi $sp, $sp, -4 
	addi $s5, $s4, 1
	sw $s5, -308($fp)
	lw $a0, -4($fp) 
	lw $a1, -8($fp) 
	lw $a2, -200($fp) 
	lw $a3, -260($fp) 
	addi $sp, $sp, -4 
	addi $sp, $sp, -4 
	lw $t0, -28($fp) 
	sw $t0, 0($sp) 
	addi $sp, $sp, -4 
	lw $t0, -24($fp) 
	sw $t0, 0($sp) 
	addi $sp, $sp, -4 
	lw $t0, -308($fp) 
	sw $t0, 0($sp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal dfs
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $t0, $v0
	sw $t0, -316($fp)
	lw $t1, -32($fp)
	li $t2, 4
	addi $sp, $sp, -4 
	mul $t3, $t2, $t1
	sw $t3, -328($fp)
	lw $t4, -328($fp)
	lw $t5, -8($fp)
	addi $sp, $sp, -4 
	add $t6, $t5, $t4
	sw $t6, -332($fp)
	move $t7, $fp
	addi $t7, $t7, -332
	lw $t7, 0($t7)
	li $t8, 1
	sw $t8, 0($t7)
mylabel17:
	lw $t9, -32($fp)
	addi $sp, $sp, -4 
	addi $s0, $t9, 1
	sw $s0, -336($fp)
	lw $s1, -336($fp)
	lw $s2, -32($fp)
	move $s2, $s1
	sw $s2, -32($fp)
	j mylabel13
mylabel15:
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
	addi $sp, $sp, -40 
	addi $sp, $sp, -4 
	addi $sp, $sp, -40 
	addi $sp, $sp, -40 
	addi $sp, $sp, -40 
	addi $sp, $sp, -4 
	li $s3, 0
	sw $s3, -168($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $s4, $v0
	sw $s4, -172($fp)
	lw $s5, -172($fp)
	addi $sp, $sp, -4 
	move $s6, $s5
	sw $s6, -176($fp)
	li $s7, 0
	lw $t0, -176($fp)
	beq $t0, $s7, mylabel30
	j mylabel32
mylabel32:
	li $t1, 10
	lw $t3, -176($fp)
	bgt $t3, $t1, mylabel30
	j mylabel31
mylabel30:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel31:
mylabel33:
	lw $t4, -176($fp)
	lw $t5, -168($fp)
	blt $t5, $t4, mylabel34
	j mylabel35
mylabel34:
	lw $t6, -168($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s0, $t9, $t6
	sw $s0, -180($fp)
	lw $t6, -180($fp)
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -84
	sw $s0, -184($fp)
	addi $sp, $sp, -4 
	add $s0, $s0, $t6
	sw $s0, -188($fp)
	move $t6, $fp
	addi $t6, $t6, -188
	lw $t6, 0($t6)
	li $s0, 1
	sw $s0, 0($t6)
	lw $s1, -168($fp)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $s3, $s2, $s1
	sw $s3, -192($fp)
	lw $s1, -192($fp)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -124
	sw $s3, -196($fp)
	addi $sp, $sp, -4 
	add $s3, $s3, $s1
	sw $s3, -200($fp)
	move $s1, $fp
	addi $s1, $s1, -200
	lw $s1, 0($s1)
	li $s3, 1
	sw $s3, 0($s1)
	lw $s4, -168($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s6, $s5, $s4
	sw $s6, -204($fp)
	lw $s4, -204($fp)
	addi $sp, $sp, -4 
	move $s6, $fp
	addi $s6, $s6, -164
	sw $s6, -208($fp)
	addi $sp, $sp, -4 
	add $s6, $s6, $s4
	sw $s6, -212($fp)
	move $s4, $fp
	addi $s4, $s4, -212
	lw $s4, 0($s4)
	li $s6, 1
	sw $s6, 0($s4)
	lw $t2, -168($fp)
	addi $sp, $sp, -4 
	addi $t7, $t2, 1
	sw $t7, -216($fp)
	lw $t2, -216($fp)
	lw $t7, -168($fp)
	move $t7, $t2
	sw $t7, -168($fp)
	j mylabel33
mylabel35:
	addi $sp, $sp, -4 
	move $t2, $fp
	addi $t2, $t2, -44
	sw $t2, -220($fp)
	addi $sp, $sp, -4 
	addi $t2, $t2, 0
	sw $t2, -224($fp)
	move $t2, $fp
	addi $t2, $t2, -224
	lw $t2, 0($t2)
	li $t7, 0
	sw $t7, 0($t2)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -40
	sw $t0, -228($fp)
	move $a0, $t0 
	lw $a1, -184($fp) 
	lw $a2, -196($fp) 
	lw $a3, -208($fp) 
	addi $sp, $sp, -4 
	addi $sp, $sp, -4 
	lw $t1, -220($fp) 
	sw $t1, 0($sp) 
	addi $sp, $sp, -4 
	lw $t1, -176($fp) 
	sw $t1, 0($sp) 
	li $t2, 0
	addi $sp, $sp, -4 
	sw $t2, 0($sp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal dfs
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $t1, $v0
	sw $t1, -236($fp)
	lw $t3, -220($fp)
	addi $sp, $sp, -4 
	addi $t4, $t3, 0
	sw $t4, -248($fp)
	addi $sp, $sp, -4 
	move $t5, $fp
	addi $t5, $t5, -248
	lw $t5, 0($t5)
	lw $t5, 0($t5)
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
