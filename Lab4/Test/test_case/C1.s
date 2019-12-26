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
	addi $sp, $sp, -32 
	addi $sp, $sp, -32 
	addi $sp, $sp, -32 
	addi $sp, $sp, -32 
	addi $sp, $sp, -4 
	li $t0, 0
	sw $t0, -132($fp)
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -136($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t2, $v0
	sw $t2, -140($fp)
	lw $t3, -140($fp)
	addi $sp, $sp, -4 
	move $t4, $t3
	sw $t4, -144($fp)
mylabel0:
	lw $t5, -144($fp)
	lw $t6, -136($fp)
	blt $t6, $t5, mylabel1
	j mylabel2
mylabel1:
	lw $t7, -136($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $t9, $t8, $t7
	sw $t9, -148($fp)
	lw $s0, -148($fp)
	addi $sp, $sp, -4 
	move $s1, $fp
	addi $s1, $s1, -32
	sw $s1, -152($fp)
	addi $sp, $sp, -4 
	add $s2, $s1, $s0
	sw $s2, -156($fp)
	li $s3, 1
	li $s4, 0
	addi $sp, $sp, -4 
	sub $s5, $s4, $s3
	sw $s5, -160($fp)
	move $s6, $fp
	addi $s6, $s6, -156
	lw $s6, 0($s6)
	lw $s7, -160($fp)
	sw $s7, 0($s6)
	lw $t0, -136($fp)
	addi $sp, $sp, -4 
	addi $t1, $t0, 1
	sw $t1, -164($fp)
	lw $t0, -164($fp)
	lw $t1, -136($fp)
	move $t1, $t0
	sw $t1, -136($fp)
	j mylabel0
mylabel2:
	lw $t0, -136($fp)
	li $t0, 0
	sw $t0, -136($fp)
	addi $sp, $sp, -4 
	li $t0, 1
	sw $t0, -168($fp)
mylabel3:
	li $t0, 1
	lw $t1, -168($fp)
	beq $t1, $t0, mylabel4
	j mylabel5
mylabel4:
	lw $t2, -144($fp)
	lw $t3, -136($fp)
	beq $t3, $t2, mylabel6
	j mylabel7
mylabel6:
	addi $sp, $sp, -4 
	li $t4, 1
	sw $t4, -172($fp)
	addi $sp, $sp, -4 
	li $t4, 0
	sw $t4, -176($fp)
mylabel8:
	lw $t4, -144($fp)
	lw $t7, -176($fp)
	blt $t7, $t4, mylabel9
	j mylabel10
mylabel9:
	lw $t9, -176($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s1, $s0, $t9
	sw $s1, -180($fp)
	lw $t9, -180($fp)
	addi $sp, $sp, -4 
	move $s1, $fp
	addi $s1, $s1, -64
	sw $s1, -184($fp)
	addi $sp, $sp, -4 
	add $s1, $s1, $t9
	sw $s1, -188($fp)
	move $t9, $fp
	addi $t9, $t9, -188
	lw $t9, 0($t9)
	li $s1, 1
	sw $s1, 0($t9)
	lw $s2, -176($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $t5, $s5, $s2
	sw $t5, -192($fp)
	lw $t5, -192($fp)
	addi $sp, $sp, -4 
	move $s2, $fp
	addi $s2, $s2, -96
	sw $s2, -196($fp)
	addi $sp, $sp, -4 
	add $s2, $s2, $t5
	sw $s2, -200($fp)
	move $t5, $fp
	addi $t5, $t5, -200
	lw $t5, 0($t5)
	li $s2, 1
	sw $s2, 0($t5)
	lw $t6, -176($fp)
	li $t8, 4
	addi $sp, $sp, -4 
	mul $s3, $t8, $t6
	sw $s3, -204($fp)
	lw $t6, -204($fp)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -128
	sw $s3, -208($fp)
	addi $sp, $sp, -4 
	add $s3, $s3, $t6
	sw $s3, -212($fp)
	move $t6, $fp
	addi $t6, $t6, -212
	lw $t6, 0($t6)
	li $s3, 1
	sw $s3, 0($t6)
	lw $s4, -176($fp)
	addi $sp, $sp, -4 
	addi $s6, $s4, 1
	sw $s6, -216($fp)
	lw $s4, -216($fp)
	lw $s6, -176($fp)
	move $s6, $s4
	sw $s6, -176($fp)
	j mylabel8
mylabel10:
	lw $s4, -176($fp)
	li $s4, 0
	sw $s4, -176($fp)
mylabel11:
	lw $s4, -144($fp)
	lw $s6, -176($fp)
	blt $s6, $s4, mylabel12
	j mylabel13
mylabel12:
	lw $s7, -176($fp)
	li $t0, 4
	addi $sp, $sp, -4 
	mul $t1, $t0, $s7
	sw $t1, -220($fp)
	lw $t1, -220($fp)
	lw $s7, -152($fp)
	addi $sp, $sp, -4 
	add $t2, $s7, $t1
	sw $t2, -224($fp)
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -224
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	li $t2, 4
	addi $sp, $sp, -4 
	mul $s7, $t2, $t1
	sw $s7, -232($fp)
	lw $t1, -232($fp)
	lw $s7, -184($fp)
	addi $sp, $sp, -4 
	add $t3, $s7, $t1
	sw $t3, -236($fp)
	li $t1, 1
	addi $sp, $sp, -4 
	move $t3, $fp
	addi $t3, $t3, -236
	lw $t3, 0($t3)
	lw $t3, 0($t3)
	bne $t3, $t1, mylabel14
	j mylabel17
mylabel17:
	lw $s7, -176($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t7, $t4, $s7
	sw $t7, -244($fp)
	lw $t7, -244($fp)
	lw $s0, -152($fp)
	addi $sp, $sp, -4 
	add $t9, $s0, $t7
	sw $t9, -248($fp)
	addi $sp, $sp, -4 
	move $t7, $fp
	addi $t7, $t7, -248
	lw $t7, 0($t7)
	lw $t7, 0($t7)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s0, $t9, $t7
	sw $s0, -256($fp)
	lw $t7, -256($fp)
	lw $s0, -196($fp)
	addi $sp, $sp, -4 
	add $s1, $s0, $t7
	sw $s1, -260($fp)
	li $t7, 1
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -260
	lw $s0, 0($s0)
	lw $s0, 0($s0)
	bne $s0, $t7, mylabel14
	j mylabel16
mylabel16:
	lw $s1, -176($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $t5, $s5, $s1
	sw $t5, -268($fp)
	lw $t5, -268($fp)
	lw $s1, -152($fp)
	addi $sp, $sp, -4 
	add $s2, $s1, $t5
	sw $s2, -272($fp)
	addi $sp, $sp, -4 
	move $t5, $fp
	addi $t5, $t5, -272
	lw $t5, 0($t5)
	lw $t5, 0($t5)
	li $s1, 4
	addi $sp, $sp, -4 
	mul $s2, $s1, $t5
	sw $s2, -280($fp)
	lw $t5, -280($fp)
	lw $s2, -208($fp)
	addi $sp, $sp, -4 
	add $t8, $s2, $t5
	sw $t8, -284($fp)
	li $t5, 1
	addi $sp, $sp, -4 
	move $t8, $fp
	addi $t8, $t8, -284
	lw $t8, 0($t8)
	lw $t8, 0($t8)
	bne $t8, $t5, mylabel14
	j mylabel15
mylabel14:
	lw $s2, -172($fp)
	li $s2, 0
	sw $s2, -172($fp)
	lw $s2, -144($fp)
	lw $t6, -176($fp)
	move $t6, $s2
	sw $t6, -176($fp)
	j mylabel18
mylabel15:
	lw $t6, -176($fp)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $s3, $s2, $t6
	sw $s3, -292($fp)
	lw $t6, -292($fp)
	lw $s3, -152($fp)
	addi $sp, $sp, -4 
	add $s4, $s3, $t6
	sw $s4, -296($fp)
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -296
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $s4, $s3, $t6
	sw $s4, -304($fp)
	lw $t6, -304($fp)
	lw $s4, -184($fp)
	addi $sp, $sp, -4 
	add $s6, $s4, $t6
	sw $s6, -308($fp)
	move $t6, $fp
	addi $t6, $t6, -308
	lw $t6, 0($t6)
	li $s4, 0
	sw $s4, 0($t6)
	addi $sp, $sp, -4 
	li $s6, 0
	sw $s6, -312($fp)
mylabel19:
	li $s6, 1
	lw $t0, -144($fp)
	addi $sp, $sp, -4 
	sub $t2, $t0, $s6
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	lw $t2, -312($fp)
	blt $t2, $t0, mylabel20
	j mylabel21
mylabel20:
	lw $t1, -312($fp)
	li $t3, 4
	addi $sp, $sp, -4 
	mul $t4, $t3, $t1
	sw $t4, -320($fp)
	lw $t1, -320($fp)
	lw $t4, -196($fp)
	addi $sp, $sp, -4 
	add $s7, $t4, $t1
	sw $s7, -324($fp)
	lw $t1, -312($fp)
	addi $sp, $sp, -4 
	addi $t4, $t1, 1
	sw $t4, -328($fp)
	lw $t1, -328($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $s7, $t4, $t1
	sw $s7, -332($fp)
	lw $t1, -332($fp)
	lw $s7, -196($fp)
	addi $sp, $sp, -4 
	add $t9, $s7, $t1
	sw $t9, -336($fp)
	move $t1, $fp
	addi $t1, $t1, -324
	lw $t1, 0($t1)
	addi $sp, $sp, -4 
	move $t9, $fp
	addi $t9, $t9, -336
	lw $t9, 0($t9)
	lw $t9, 0($t9)
	sw $t9, 0($t1)
	lw $s7, -312($fp)
	addi $sp, $sp, -4 
	addi $t7, $s7, 1
	sw $t7, -344($fp)
	lw $t7, -344($fp)
	lw $s7, -312($fp)
	move $s7, $t7
	sw $s7, -312($fp)
	j mylabel19
mylabel21:
	li $t7, 1
	lw $s7, -144($fp)
	addi $sp, $sp, -4 
	sub $s0, $s7, $t7
	sw $s0, -348($fp)
	lw $s0, -348($fp)
	li $s7, 4
	addi $sp, $sp, -4 
	mul $s5, $s7, $s0
	sw $s5, -352($fp)
	lw $s0, -352($fp)
	lw $s5, -196($fp)
	addi $sp, $sp, -4 
	add $s1, $s5, $s0
	sw $s1, -356($fp)
	move $s0, $fp
	addi $s0, $s0, -356
	lw $s0, 0($s0)
	li $s1, 1
	sw $s1, 0($s0)
	lw $s5, -176($fp)
	li $t5, 4
	addi $sp, $sp, -4 
	mul $t8, $t5, $s5
	sw $t8, -360($fp)
	lw $t8, -360($fp)
	lw $s5, -152($fp)
	addi $sp, $sp, -4 
	add $s2, $s5, $t8
	sw $s2, -364($fp)
	li $t8, 0
	addi $sp, $sp, -4 
	move $s2, $fp
	addi $s2, $s2, -364
	lw $s2, 0($s2)
	lw $s2, 0($s2)
	bne $s2, $t8, mylabel22
	j mylabel23
mylabel22:
	lw $s5, -176($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $t6, $s3, $s5
	sw $t6, -372($fp)
	lw $t6, -372($fp)
	lw $s5, -152($fp)
	addi $sp, $sp, -4 
	add $s4, $s5, $t6
	sw $s4, -376($fp)
	li $t6, 1
	addi $sp, $sp, -4 
	move $s4, $fp
	addi $s4, $s4, -376
	lw $s4, 0($s4)
	lw $s4, 0($s4)
	addi $sp, $sp, -4 
	sub $s5, $s4, $t6
	sw $s5, -384($fp)
	lw $s4, -384($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s6, $s5, $s4
	sw $s6, -388($fp)
	lw $s4, -388($fp)
	lw $s6, -196($fp)
	addi $sp, $sp, -4 
	add $t0, $s6, $s4
	sw $t0, -392($fp)
	move $t0, $fp
	addi $t0, $t0, -392
	lw $t0, 0($t0)
	li $s4, 0
	sw $s4, 0($t0)
mylabel23:
	li $s6, 1
	lw $t2, -144($fp)
	addi $sp, $sp, -4 
	sub $t3, $t2, $s6
	sw $t3, -396($fp)
	lw $t2, -396($fp)
	lw $t3, -312($fp)
	move $t3, $t2
	sw $t3, -312($fp)
mylabel24:
	li $t2, 0
	lw $t3, -312($fp)
	bgt $t3, $t2, mylabel25
	j mylabel26
mylabel25:
	lw $t4, -312($fp)
	li $t1, 4
	addi $sp, $sp, -4 
	mul $t9, $t1, $t4
	sw $t9, -400($fp)
	lw $t4, -400($fp)
	lw $t9, -208($fp)
	addi $sp, $sp, -4 
	add $t7, $t9, $t4
	sw $t7, -404($fp)
	li $t4, 1
	lw $t7, -312($fp)
	addi $sp, $sp, -4 
	sub $t9, $t7, $t4
	sw $t9, -408($fp)
	lw $t7, -408($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s7, $t9, $t7
	sw $s7, -412($fp)
	lw $t7, -412($fp)
	lw $s7, -208($fp)
	addi $sp, $sp, -4 
	add $s0, $s7, $t7
	sw $s0, -416($fp)
	move $t7, $fp
	addi $t7, $t7, -404
	lw $t7, 0($t7)
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -416
	lw $s0, 0($s0)
	lw $s0, 0($s0)
	sw $s0, 0($t7)
	li $s7, 1
	lw $s1, -312($fp)
	addi $sp, $sp, -4 
	sub $t5, $s1, $s7
	sw $t5, -424($fp)
	lw $t5, -424($fp)
	lw $s1, -312($fp)
	move $s1, $t5
	sw $s1, -312($fp)
	j mylabel24
mylabel26:
	lw $t5, -208($fp)
	addi $sp, $sp, -4 
	addi $s1, $t5, 0
	sw $s1, -428($fp)
	move $t5, $fp
	addi $t5, $t5, -428
	lw $t5, 0($t5)
	li $s1, 1
	sw $s1, 0($t5)
	lw $t8, -176($fp)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $s3, $s2, $t8
	sw $s3, -432($fp)
	lw $t8, -432($fp)
	lw $s3, -152($fp)
	addi $sp, $sp, -4 
	add $t6, $s3, $t8
	sw $t6, -436($fp)
	li $t6, 1
	lw $t8, -144($fp)
	addi $sp, $sp, -4 
	sub $s3, $t8, $t6
	sw $s3, -440($fp)
	lw $t8, -440($fp)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -436
	lw $s3, 0($s3)
	lw $s3, 0($s3)
	bne $s3, $t8, mylabel27
	j mylabel28
mylabel27:
	lw $s5, -176($fp)
	li $t0, 4
	addi $sp, $sp, -4 
	mul $s4, $t0, $s5
	sw $s4, -448($fp)
	lw $s4, -448($fp)
	lw $s5, -152($fp)
	addi $sp, $sp, -4 
	add $s6, $s5, $s4
	sw $s6, -452($fp)
	addi $sp, $sp, -4 
	move $s4, $fp
	addi $s4, $s4, -452
	lw $s4, 0($s4)
	lw $s4, 0($s4)
	addi $sp, $sp, -4 
	addi $s5, $s4, 1
	sw $s5, -460($fp)
	lw $s4, -460($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s6, $s5, $s4
	sw $s6, -464($fp)
	lw $s4, -464($fp)
	lw $s6, -208($fp)
	addi $sp, $sp, -4 
	add $t2, $s6, $s4
	sw $t2, -468($fp)
	move $t2, $fp
	addi $t2, $t2, -468
	lw $t2, 0($t2)
	li $s4, 0
	sw $s4, 0($t2)
mylabel28:
	lw $s6, -176($fp)
	addi $sp, $sp, -4 
	addi $t3, $s6, 1
	sw $t3, -472($fp)
	lw $t3, -472($fp)
	lw $s6, -176($fp)
	move $s6, $t3
	sw $s6, -176($fp)
mylabel18:
	j mylabel11
mylabel13:
	li $t3, 1
	lw $s6, -172($fp)
	beq $s6, $t3, mylabel29
	j mylabel30
mylabel29:
	lw $t1, -132($fp)
	addi $sp, $sp, -4 
	addi $t4, $t1, 1
	sw $t4, -476($fp)
	lw $t1, -476($fp)
	lw $t4, -132($fp)
	move $t4, $t1
	sw $t4, -132($fp)
mylabel30:
	li $t1, 1
	lw $t4, -136($fp)
	addi $sp, $sp, -4 
	sub $t9, $t4, $t1
	sw $t9, -480($fp)
	lw $t4, -480($fp)
	lw $t9, -136($fp)
	move $t9, $t4
	sw $t9, -136($fp)
	j mylabel31
mylabel7:
mylabel32:
	li $t4, 0
	lw $t9, -136($fp)
	bge $t9, $t4, mylabel35
	j mylabel34
mylabel35:
	lw $t7, -136($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s7, $s0, $t7
	sw $s7, -484($fp)
	lw $t7, -484($fp)
	lw $s7, -152($fp)
	addi $sp, $sp, -4 
	add $t5, $s7, $t7
	sw $t5, -488($fp)
	li $t5, 1
	lw $t7, -144($fp)
	addi $sp, $sp, -4 
	sub $s7, $t7, $t5
	sw $s7, -492($fp)
	lw $t7, -492($fp)
	addi $sp, $sp, -4 
	move $s7, $fp
	addi $s7, $s7, -488
	lw $s7, 0($s7)
	lw $s7, 0($s7)
	bge $s7, $t7, mylabel33
	j mylabel34
mylabel33:
	lw $s1, -136($fp)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $t6, $s2, $s1
	sw $t6, -500($fp)
	lw $t6, -500($fp)
	lw $s1, -152($fp)
	addi $sp, $sp, -4 
	add $t8, $s1, $t6
	sw $t8, -504($fp)
	li $t6, 1
	li $t8, 0
	addi $sp, $sp, -4 
	sub $s1, $t8, $t6
	sw $s1, -508($fp)
	move $s1, $fp
	addi $s1, $s1, -504
	lw $s1, 0($s1)
	lw $s3, -508($fp)
	sw $s3, 0($s1)
	li $t0, 1
	lw $s5, -136($fp)
	addi $sp, $sp, -4 
	sub $t2, $s5, $t0
	sw $t2, -512($fp)
	lw $t2, -512($fp)
	lw $s5, -136($fp)
	move $s5, $t2
	sw $s5, -136($fp)
	j mylabel32
mylabel34:
	li $t2, 1
	li $s5, 0
	addi $sp, $sp, -4 
	sub $s4, $s5, $t2
	sw $s4, -516($fp)
	lw $s4, -516($fp)
	lw $t3, -136($fp)
	beq $t3, $s4, mylabel36
	j mylabel37
mylabel36:
	lw $s6, -168($fp)
	li $s6, 0
	sw $s6, -168($fp)
	j mylabel38
mylabel37:
	lw $s6, -136($fp)
	li $t1, 4
	addi $sp, $sp, -4 
	mul $t4, $t1, $s6
	sw $t4, -520($fp)
	lw $t4, -520($fp)
	lw $s6, -152($fp)
	addi $sp, $sp, -4 
	add $t9, $s6, $t4
	sw $t9, -524($fp)
	lw $t4, -136($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s6, $t9, $t4
	sw $s6, -528($fp)
	lw $t4, -528($fp)
	lw $s6, -152($fp)
	addi $sp, $sp, -4 
	add $s0, $s6, $t4
	sw $s0, -532($fp)
	addi $sp, $sp, -4 
	move $t4, $fp
	addi $t4, $t4, -532
	lw $t4, 0($t4)
	lw $t4, 0($t4)
	addi $sp, $sp, -4 
	addi $s0, $t4, 1
	sw $s0, -540($fp)
	move $t4, $fp
	addi $t4, $t4, -524
	lw $t4, 0($t4)
	lw $s0, -540($fp)
	sw $s0, 0($t4)
	lw $s6, -136($fp)
	addi $sp, $sp, -4 
	addi $t5, $s6, 1
	sw $t5, -544($fp)
	lw $t5, -544($fp)
	lw $s6, -136($fp)
	move $s6, $t5
	sw $s6, -136($fp)
mylabel38:
mylabel31:
	j mylabel3
mylabel5:
	lw $t5, -132($fp)
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
