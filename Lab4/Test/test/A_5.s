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

compare:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $a1, -8($fp) 
	lw $t0, -8($fp)
	lw $t1, -4($fp)
	bgt $t1, $t0, mylabel0
	j mylabel1
mylabel0:
	lw $t2, -4($fp)
	move $v0, $t2 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel1:
	lw $t3, -8($fp)
	lw $t4, -4($fp)
	blt $t4, $t3, mylabel2
	j mylabel3
mylabel2:
	lw $t5, -8($fp)
	move $v0, $t5 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel3:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
Add:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $a1, -8($fp) 
	lw $t6, -8($fp)
	lw $t7, -4($fp)
	addi $sp, $sp, -4 
	add $t8, $t7, $t6
	sw $t8, -12($fp)
	lw $t9, -12($fp)
	move $v0, $t9 
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
	addi $sp, $sp, -20 
	addi $sp, $sp, -4 
	li $s0, 0
	sw $s0, -64($fp)
mylabel4:
	li $s1, 10
	lw $s2, -64($fp)
	blt $s2, $s1, mylabel5
	j mylabel6
mylabel5:
	lw $s3, -64($fp)
	li $s4, 4
	addi $sp, $sp, -4 
	mul $s5, $s4, $s3
	sw $s5, -68($fp)
	lw $s6, -68($fp)
	addi $sp, $sp, -4 
	move $s7, $fp
	addi $s7, $s7, -40
	sw $s7, -72($fp)
	addi $sp, $sp, -4 
	add $t6, $s7, $s6
	sw $t6, -76($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t6, $v0
	sw $t6, -80($fp)
	move $t6, $fp
	addi $t6, $t6, -76
	lw $t6, 0($t6)
	lw $t7, -80($fp)
	sw $t7, 0($t6)
	lw $t8, -64($fp)
	addi $sp, $sp, -4 
	addi $s0, $t8, 1
	sw $s0, -84($fp)
	lw $t8, -84($fp)
	lw $s0, -64($fp)
	move $s0, $t8
	sw $s0, -64($fp)
	j mylabel4
mylabel6:
	lw $t8, -64($fp)
	li $t8, 0
	sw $t8, -64($fp)
	addi $sp, $sp, -4 
	li $t8, 0
	sw $t8, -88($fp)
mylabel7:
	li $t8, 10
	lw $s0, -64($fp)
	blt $s0, $t8, mylabel8
	j mylabel9
mylabel8:
	lw $s3, -88($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s6, $s5, $s3
	sw $s6, -92($fp)
	lw $s3, -92($fp)
	addi $sp, $sp, -4 
	move $s6, $fp
	addi $s6, $s6, -60
	sw $s6, -96($fp)
	addi $sp, $sp, -4 
	add $s6, $s6, $s3
	sw $s6, -100($fp)
	lw $s3, -64($fp)
	li $s6, 4
	addi $sp, $sp, -4 
	mul $s7, $s6, $s3
	sw $s7, -104($fp)
	lw $s3, -104($fp)
	lw $s7, -72($fp)
	addi $sp, $sp, -4 
	add $t0, $s7, $s3
	sw $t0, -108($fp)
	lw $t0, -64($fp)
	addi $sp, $sp, -4 
	addi $s3, $t0, 1
	sw $s3, -112($fp)
	lw $t0, -112($fp)
	li $s3, 4
	addi $sp, $sp, -4 
	mul $s7, $s3, $t0
	sw $s7, -116($fp)
	lw $t0, -116($fp)
	lw $s7, -72($fp)
	addi $sp, $sp, -4 
	add $t1, $s7, $t0
	sw $t1, -120($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -108
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	move $a0, $t0 
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -120
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	move $a1, $t1 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal compare
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t2, $v0
	sw $t2, -132($fp)
	move $t3, $fp
	addi $t3, $t3, -100
	lw $t3, 0($t3)
	lw $t4, -132($fp)
	sw $t4, 0($t3)
	lw $t5, -64($fp)
	addi $sp, $sp, -4 
	addi $t6, $t5, 2
	sw $t6, -136($fp)
	lw $t7, -136($fp)
	lw $t8, -64($fp)
	move $t8, $t7
	sw $t8, -64($fp)
	lw $t9, -88($fp)
	addi $sp, $sp, -4 
	addi $s0, $t9, 1
	sw $s0, -140($fp)
	lw $s1, -140($fp)
	lw $s2, -88($fp)
	move $s2, $s1
	sw $s2, -88($fp)
	j mylabel7
mylabel9:
	lw $s3, -64($fp)
	li $s3, 0
	sw $s3, -64($fp)
mylabel10:
	li $s4, 5
	lw $s5, -64($fp)
	blt $s5, $s4, mylabel11
	j mylabel12
mylabel11:
	lw $s6, -64($fp)
	li $s7, 4
	addi $sp, $sp, -4 
	mul $t0, $s7, $s6
	sw $t0, -144($fp)
	lw $t0, -144($fp)
	lw $t1, -96($fp)
	addi $sp, $sp, -4 
	add $t2, $t1, $t0
	sw $t2, -148($fp)
	lw $t0, -64($fp)
	li $t1, 4
	addi $sp, $sp, -4 
	mul $t2, $t1, $t0
	sw $t2, -152($fp)
	lw $t0, -152($fp)
	lw $t2, -96($fp)
	addi $sp, $sp, -4 
	add $t5, $t2, $t0
	sw $t5, -156($fp)
	lw $t0, -64($fp)
	li $t2, 4
	addi $sp, $sp, -4 
	mul $t5, $t2, $t0
	sw $t5, -160($fp)
	lw $t0, -160($fp)
	lw $t5, -72($fp)
	addi $sp, $sp, -4 
	add $t6, $t5, $t0
	sw $t6, -164($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -156
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	move $a0, $t0 
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -164
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	move $a1, $t1 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal Add
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t2, $v0
	sw $t2, -176($fp)
	move $t3, $fp
	addi $t3, $t3, -148
	lw $t3, 0($t3)
	lw $t4, -176($fp)
	sw $t4, 0($t3)
	lw $t5, -64($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $t7, $t6, $t5
	sw $t7, -180($fp)
	lw $t8, -180($fp)
	lw $t9, -96($fp)
	addi $sp, $sp, -4 
	add $s0, $t9, $t8
	sw $s0, -184($fp)
	addi $sp, $sp, -4 
	move $s1, $fp
	addi $s1, $s1, -184
	lw $s1, 0($s1)
	lw $s1, 0($s1)
	move $a0, $s1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $s2, -64($fp)
	addi $sp, $sp, -4 
	addi $s3, $s2, 1
	sw $s3, -192($fp)
	lw $s4, -192($fp)
	lw $s5, -64($fp)
	move $s5, $s4
	sw $s5, -64($fp)
	j mylabel10
mylabel12:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
