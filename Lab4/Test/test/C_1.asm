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
	addi $sp, $sp, -40 
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -88($fp)
	addi $sp, $sp, -4 
	li $t2, 0
	sw $t2, -92($fp)
mylabel0:
	li $t3, 10
	lw $t4, -88($fp)
	blt $t4, $t3, mylabel1
	j mylabel2
mylabel1:
	lw $t5, -88($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $t7, $t6, $t5
	sw $t7, -96($fp)
	lw $t8, -96($fp)
	addi $sp, $sp, -4 
	move $t9, $fp
	addi $t9, $t9, -44
	sw $t9, -100($fp)
	addi $sp, $sp, -4 
	add $s0, $t9, $t8
	sw $s0, -104($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $s1, $v0
	sw $s1, -108($fp)
	move $s2, $fp
	addi $s2, $s2, -104
	lw $s2, 0($s2)
	lw $s3, -108($fp)
	sw $s3, 0($s2)
	lw $s4, -88($fp)
	addi $sp, $sp, -4 
	addi $s5, $s4, 1
	sw $s5, -112($fp)
	lw $s6, -112($fp)
	lw $s7, -88($fp)
	move $s7, $s6
	sw $s7, -88($fp)
	j mylabel0
mylabel2:
	li $t0, 2
	lw $t1, -4($fp)
	div $t1, $t0
	addi $sp, $sp, -4 
	mflo $t2
	sw $t2, -116($fp)
	lw $t1, -116($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -120($fp)
mylabel3:
	li $t1, 0
	lw $t2, -120($fp)
	bge $t2, $t1, mylabel4
	j mylabel5
mylabel4:
	lw $t5, -92($fp)
	li $t5, 0
	sw $t5, -92($fp)
	lw $t5, -120($fp)
	lw $t7, -88($fp)
	move $t7, $t5
	sw $t7, -88($fp)
mylabel6:
	li $t5, 0
	lw $t7, -92($fp)
	beq $t7, $t5, mylabel7
	j mylabel8
mylabel7:
	lw $t8, -92($fp)
	li $t8, 1
	sw $t8, -92($fp)
	li $t8, 2
	lw $t9, -88($fp)
	addi $sp, $sp, -4 
	mul $s0, $t9, $t8
	sw $s0, -124($fp)
	lw $t9, -124($fp)
	addi $sp, $sp, -4 
	addi $s0, $t9, 1
	sw $s0, -128($fp)
	lw $t9, -128($fp)
	addi $sp, $sp, -4 
	move $s0, $t9
	sw $s0, -132($fp)
	li $t9, 2
	lw $s0, -88($fp)
	addi $sp, $sp, -4 
	mul $s1, $s0, $t9
	sw $s1, -136($fp)
	lw $s0, -136($fp)
	addi $sp, $sp, -4 
	addi $s1, $s0, 2
	sw $s1, -140($fp)
	lw $s0, -140($fp)
	addi $sp, $sp, -4 
	move $s1, $s0
	sw $s1, -144($fp)
	lw $s0, -4($fp)
	lw $s1, -132($fp)
	blt $s1, $s0, mylabel9
	j mylabel10
mylabel9:
	lw $s4, -132($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s6, $s5, $s4
	sw $s6, -148($fp)
	lw $s4, -148($fp)
	lw $s6, -100($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s4
	sw $s7, -152($fp)
	addi $sp, $sp, -4 
	move $s4, $fp
	addi $s4, $s4, -152
	lw $s4, 0($s4)
	lw $s4, 0($s4)
	addi $sp, $sp, -4 
	move $s6, $s4
	sw $s6, -160($fp)
	lw $s4, -4($fp)
	lw $s6, -144($fp)
	blt $s6, $s4, mylabel13
	j mylabel12
mylabel13:
	lw $s7, -144($fp)
	li $t3, 4
	addi $sp, $sp, -4 
	mul $t4, $t3, $s7
	sw $t4, -164($fp)
	lw $t4, -164($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t6, $s7, $t4
	sw $t6, -168($fp)
	lw $t4, -132($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $s7, $t6, $t4
	sw $s7, -172($fp)
	lw $t4, -172($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $s2, $s7, $t4
	sw $s2, -176($fp)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -176
	lw $t4, 0($t4)
	lw $t4, 0($t4)
	addi $sp, $sp, -4 
	move $s2, $fp
	addi $s2, $s2, -168
	lw $s2, 0($s2)
	lw $s2, 0($s2)
	blt $s2, $t4, mylabel11
	j mylabel12
mylabel11:
	lw $s7, -144($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $t0, $s3, $s7
	sw $t0, -188($fp)
	lw $t0, -188($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t1, $s7, $t0
	sw $t1, -192($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -192
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	lw $t1, -160($fp)
	move $t1, $t0
	sw $t1, -160($fp)
	lw $t0, -144($fp)
	lw $t1, -132($fp)
	move $t1, $t0
	sw $t1, -132($fp)
mylabel12:
	lw $t0, -88($fp)
	li $t1, 4
	addi $sp, $sp, -4 
	mul $s7, $t1, $t0
	sw $s7, -200($fp)
	lw $t0, -200($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t2, $s7, $t0
	sw $t2, -204($fp)
	lw $t0, -160($fp)
	addi $sp, $sp, -4 
	move $t2, $fp
	addi $t2, $t2, -204
	lw $t2, 0($t2)
	lw $t2, 0($t2)
	bgt $t2, $t0, mylabel14
	j mylabel15
mylabel14:
	lw $s7, -92($fp)
	li $s7, 0
	sw $s7, -92($fp)
	lw $s7, -132($fp)
	li $t5, 4
	addi $sp, $sp, -4 
	mul $t7, $t5, $s7
	sw $t7, -212($fp)
	lw $t7, -212($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t8, $s7, $t7
	sw $t8, -216($fp)
	lw $t7, -88($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s7, $t8, $t7
	sw $s7, -220($fp)
	lw $t7, -220($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t9, $s7, $t7
	sw $t9, -224($fp)
	move $t7, $fp
	addi $t7, $t7, -216
	lw $t7, 0($t7)
	addi $sp, $sp, -4 
	move $t9, $fp
	addi $t9, $t9, -224
	lw $t9, 0($t9)
	lw $t9, 0($t9)
	sw $t9, 0($t7)
	lw $s7, -88($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s1, $s0, $s7
	sw $s1, -232($fp)
	lw $s1, -232($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $s5, $s7, $s1
	sw $s5, -236($fp)
	move $s1, $fp
	addi $s1, $s1, -236
	lw $s1, 0($s1)
	lw $s5, -160($fp)
	sw $s5, 0($s1)
	lw $s7, -132($fp)
	lw $s4, -88($fp)
	move $s4, $s7
	sw $s4, -88($fp)
mylabel15:
mylabel10:
	j mylabel6
mylabel8:
	li $s4, 1
	lw $s7, -120($fp)
	addi $sp, $sp, -4 
	sub $s6, $s7, $s4
	sw $s6, -240($fp)
	lw $s6, -240($fp)
	lw $s7, -120($fp)
	move $s7, $s6
	sw $s7, -120($fp)
	j mylabel3
mylabel5:
	lw $s6, -120($fp)
	li $s6, 10
	sw $s6, -120($fp)
	lw $s6, -88($fp)
	li $s6, 0
	sw $s6, -88($fp)
mylabel16:
	lw $s6, -4($fp)
	lw $s7, -88($fp)
	blt $s7, $s6, mylabel17
	j mylabel18
mylabel17:
	lw $t3, -88($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $t4, $t6, $t3
	sw $t4, -244($fp)
	lw $t3, -244($fp)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -84
	sw $t4, -248($fp)
	addi $sp, $sp, -4 
	add $t4, $t4, $t3
	sw $t4, -252($fp)
	lw $t3, -100($fp)
	addi $sp, $sp, -4 
	addi $t4, $t3, 0
	sw $t4, -256($fp)
	move $t3, $fp
	addi $t3, $t3, -252
	lw $t3, 0($t3)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -256
	lw $t4, 0($t4)
	lw $t4, 0($t4)
	sw $t4, 0($t3)
	lw $s2, -88($fp)
	addi $sp, $sp, -4 
	addi $s3, $s2, 1
	sw $s3, -264($fp)
	lw $s2, -264($fp)
	lw $s3, -88($fp)
	move $s3, $s2
	sw $s3, -88($fp)
	lw $s2, -100($fp)
	addi $sp, $sp, -4 
	addi $s3, $s2, 0
	sw $s3, -268($fp)
	li $s2, 1
	lw $s3, -120($fp)
	addi $sp, $sp, -4 
	sub $t1, $s3, $s2
	sw $t1, -272($fp)
	lw $t1, -272($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $t0, $s3, $t1
	sw $t0, -276($fp)
	lw $t0, -276($fp)
	lw $t1, -100($fp)
	addi $sp, $sp, -4 
	add $t2, $t1, $t0
	sw $t2, -280($fp)
	move $t0, $fp
	addi $t0, $t0, -268
	lw $t0, 0($t0)
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -280
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	sw $t1, 0($t0)
	lw $t2, -92($fp)
	li $t2, 0
	sw $t2, -92($fp)
	li $t2, 1
	lw $t5, -120($fp)
	addi $sp, $sp, -4 
	sub $t8, $t5, $t2
	sw $t8, -288($fp)
	lw $t5, -288($fp)
	lw $t8, -120($fp)
	move $t8, $t5
	sw $t8, -120($fp)
	addi $sp, $sp, -4 
	li $t5, 0
	sw $t5, -292($fp)
mylabel19:
	li $t5, 0
	lw $t8, -92($fp)
	beq $t8, $t5, mylabel20
	j mylabel21
mylabel20:
	lw $t7, -92($fp)
	li $t7, 1
	sw $t7, -92($fp)
	li $t7, 2
	lw $t9, -292($fp)
	addi $sp, $sp, -4 
	mul $s0, $t9, $t7
	sw $s0, -296($fp)
	lw $t9, -296($fp)
	addi $sp, $sp, -4 
	addi $s0, $t9, 1
	sw $s0, -300($fp)
	lw $t9, -300($fp)
	lw $s0, -132($fp)
	move $s0, $t9
	sw $s0, -132($fp)
	li $t9, 2
	lw $s0, -292($fp)
	addi $sp, $sp, -4 
	mul $s1, $s0, $t9
	sw $s1, -304($fp)
	lw $s0, -304($fp)
	addi $sp, $sp, -4 
	addi $s1, $s0, 2
	sw $s1, -308($fp)
	lw $s0, -308($fp)
	lw $s1, -144($fp)
	move $s1, $s0
	sw $s1, -144($fp)
	lw $s0, -120($fp)
	lw $s1, -132($fp)
	blt $s1, $s0, mylabel22
	j mylabel23
mylabel22:
	lw $s5, -132($fp)
	li $s4, 4
	addi $sp, $sp, -4 
	mul $s6, $s4, $s5
	sw $s6, -312($fp)
	lw $s5, -312($fp)
	lw $s6, -100($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s5
	sw $s7, -316($fp)
	addi $sp, $sp, -4 
	move $s5, $fp
	addi $s5, $s5, -316
	lw $s5, 0($s5)
	lw $s5, 0($s5)
	lw $s6, -160($fp)
	move $s6, $s5
	sw $s6, -160($fp)
	lw $s5, -120($fp)
	lw $s6, -144($fp)
	blt $s6, $s5, mylabel26
	j mylabel25
mylabel26:
	lw $s7, -144($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $t3, $t6, $s7
	sw $t3, -324($fp)
	lw $t3, -324($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t4, $s7, $t3
	sw $t4, -328($fp)
	lw $t3, -132($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $s7, $t4, $t3
	sw $s7, -332($fp)
	lw $t3, -332($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $s2, $s7, $t3
	sw $s2, -336($fp)
	addi $sp, $sp, -4 
	move $t3, $fp
	addi $t3, $t3, -336
	lw $t3, 0($t3)
	lw $t3, 0($t3)
	addi $sp, $sp, -4 
	move $s2, $fp
	addi $s2, $s2, -328
	lw $s2, 0($s2)
	lw $s2, 0($s2)
	blt $s2, $t3, mylabel24
	j mylabel25
mylabel24:
	lw $s7, -144($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $t0, $s3, $s7
	sw $t0, -348($fp)
	lw $t0, -348($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t1, $s7, $t0
	sw $t1, -352($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -352
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	lw $t1, -160($fp)
	move $t1, $t0
	sw $t1, -160($fp)
	lw $t0, -144($fp)
	lw $t1, -132($fp)
	move $t1, $t0
	sw $t1, -132($fp)
mylabel25:
	lw $t0, -292($fp)
	li $t1, 4
	addi $sp, $sp, -4 
	mul $s7, $t1, $t0
	sw $s7, -360($fp)
	lw $t0, -360($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t2, $s7, $t0
	sw $t2, -364($fp)
	lw $t0, -160($fp)
	addi $sp, $sp, -4 
	move $t2, $fp
	addi $t2, $t2, -364
	lw $t2, 0($t2)
	lw $t2, 0($t2)
	bgt $t2, $t0, mylabel27
	j mylabel28
mylabel27:
	lw $s7, -92($fp)
	li $s7, 0
	sw $s7, -92($fp)
	lw $s7, -132($fp)
	li $t5, 4
	addi $sp, $sp, -4 
	mul $t8, $t5, $s7
	sw $t8, -372($fp)
	lw $t8, -372($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t7, $s7, $t8
	sw $t7, -376($fp)
	lw $t7, -292($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s7, $t8, $t7
	sw $s7, -380($fp)
	lw $t7, -380($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $t9, $s7, $t7
	sw $t9, -384($fp)
	move $t7, $fp
	addi $t7, $t7, -376
	lw $t7, 0($t7)
	addi $sp, $sp, -4 
	move $t9, $fp
	addi $t9, $t9, -384
	lw $t9, 0($t9)
	lw $t9, 0($t9)
	sw $t9, 0($t7)
	lw $s7, -292($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s1, $s0, $s7
	sw $s1, -392($fp)
	lw $s1, -392($fp)
	lw $s7, -100($fp)
	addi $sp, $sp, -4 
	add $s4, $s7, $s1
	sw $s4, -396($fp)
	move $s1, $fp
	addi $s1, $s1, -396
	lw $s1, 0($s1)
	lw $s4, -160($fp)
	sw $s4, 0($s1)
	lw $s7, -132($fp)
	lw $s5, -292($fp)
	move $s5, $s7
	sw $s5, -292($fp)
mylabel28:
mylabel23:
	j mylabel19
mylabel21:
	j mylabel16
mylabel18:
	lw $s5, -88($fp)
	li $s5, 0
	sw $s5, -88($fp)
mylabel29:
	lw $s5, -4($fp)
	lw $s7, -88($fp)
	blt $s7, $s5, mylabel30
	j mylabel31
mylabel30:
	lw $s6, -88($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $t4, $t6, $s6
	sw $t4, -400($fp)
	lw $t4, -400($fp)
	lw $s6, -248($fp)
	addi $sp, $sp, -4 
	add $t3, $s6, $t4
	sw $t3, -404($fp)
	addi $sp, $sp, -4 
	move $t3, $fp
	addi $t3, $t3, -404
	lw $t3, 0($t3)
	lw $t3, 0($t3)
	move $a0, $t3
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t3, -88($fp)
	addi $sp, $sp, -4 
	addi $t4, $t3, 1
	sw $t4, -412($fp)
	lw $t3, -412($fp)
	lw $t4, -88($fp)
	move $t4, $t3
	sw $t4, -88($fp)
	j mylabel29
mylabel31:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
