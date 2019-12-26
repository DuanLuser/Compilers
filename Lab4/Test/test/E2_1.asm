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
	addi $sp, $sp, -400 
	addi $sp, $sp, -40 
	addi $sp, $sp, -4 
	li $t0, 0
	sw $t0, -444($fp)
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -448($fp)
mylabel0:
	li $t2, 10
	lw $t3, -444($fp)
	blt $t3, $t2, mylabel1
	j mylabel2
mylabel1:
	lw $t4, -448($fp)
	li $t4, 0
	sw $t4, -448($fp)
mylabel3:
	li $t5, 10
	lw $t6, -448($fp)
	blt $t6, $t5, mylabel4
	j mylabel5
mylabel4:
	lw $t7, -444($fp)
	li $t8, 40
	addi $sp, $sp, -4 
	mul $t9, $t8, $t7
	sw $t9, -452($fp)
	lw $s0, -452($fp)
	addi $sp, $sp, -4 
	move $s1, $fp
	addi $s1, $s1, -400
	sw $s1, -456($fp)
	addi $sp, $sp, -4 
	add $s2, $s1, $s0
	sw $s2, -460($fp)
	lw $s3, -448($fp)
	li $s4, 4
	addi $sp, $sp, -4 
	mul $s5, $s4, $s3
	sw $s5, -464($fp)
	lw $s6, -464($fp)
	lw $s7, -460($fp)
	addi $sp, $sp, -4 
	add $t0, $s7, $s6
	sw $t0, -468($fp)
	lw $t0, -448($fp)
	lw $t1, -444($fp)
	addi $sp, $sp, -4 
	add $t4, $t1, $t0
	sw $t4, -472($fp)
	move $t0, $fp
	addi $t0, $t0, -468
	lw $t0, 0($t0)
	lw $t1, -472($fp)
	sw $t1, 0($t0)
	lw $t4, -448($fp)
	addi $sp, $sp, -4 
	addi $t7, $t4, 1
	sw $t7, -476($fp)
	lw $t4, -476($fp)
	lw $t7, -448($fp)
	move $t7, $t4
	sw $t7, -448($fp)
	j mylabel3
mylabel5:
	lw $t4, -444($fp)
	addi $sp, $sp, -4 
	addi $t7, $t4, 1
	sw $t7, -480($fp)
	lw $t4, -480($fp)
	lw $t7, -444($fp)
	move $t7, $t4
	sw $t7, -444($fp)
	j mylabel0
mylabel2:
	lw $t4, -444($fp)
	li $t4, 0
	sw $t4, -444($fp)
mylabel6:
	li $t4, 10
	lw $t7, -444($fp)
	blt $t7, $t4, mylabel7
	j mylabel8
mylabel7:
	lw $t9, -448($fp)
	li $t9, 0
	sw $t9, -448($fp)
	lw $t9, -444($fp)
	li $s0, 4
	addi $sp, $sp, -4 
	mul $s1, $s0, $t9
	sw $s1, -484($fp)
	lw $t9, -484($fp)
	addi $sp, $sp, -4 
	move $s1, $fp
	addi $s1, $s1, -440
	sw $s1, -488($fp)
	addi $sp, $sp, -4 
	add $s1, $s1, $t9
	sw $s1, -492($fp)
	move $t9, $fp
	addi $t9, $t9, -492
	lw $t9, 0($t9)
	li $s1, 0
	sw $s1, 0($t9)
mylabel9:
	li $s2, 10
	lw $s3, -448($fp)
	blt $s3, $s2, mylabel10
	j mylabel11
mylabel10:
	lw $s5, -444($fp)
	li $s6, 4
	addi $sp, $sp, -4 
	mul $s7, $s6, $s5
	sw $s7, -496($fp)
	lw $s5, -496($fp)
	lw $s7, -488($fp)
	addi $sp, $sp, -4 
	add $t2, $s7, $s5
	sw $t2, -500($fp)
	lw $t2, -444($fp)
	li $s5, 4
	addi $sp, $sp, -4 
	mul $s7, $s5, $t2
	sw $s7, -504($fp)
	lw $t2, -504($fp)
	lw $s7, -488($fp)
	addi $sp, $sp, -4 
	add $t3, $s7, $t2
	sw $t3, -508($fp)
	lw $t2, -444($fp)
	li $t3, 40
	addi $sp, $sp, -4 
	mul $s7, $t3, $t2
	sw $s7, -512($fp)
	lw $t2, -512($fp)
	lw $s7, -456($fp)
	addi $sp, $sp, -4 
	add $t5, $s7, $t2
	sw $t5, -516($fp)
	lw $t2, -448($fp)
	li $t5, 4
	addi $sp, $sp, -4 
	mul $s7, $t5, $t2
	sw $s7, -520($fp)
	lw $t2, -520($fp)
	lw $s7, -516($fp)
	addi $sp, $sp, -4 
	add $t6, $s7, $t2
	sw $t6, -524($fp)
	addi $sp, $sp, -4 
	move $t2, $fp
	addi $t2, $t2, -524
	lw $t2, 0($t2)
	lw $t2, 0($t2)
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -508
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	addi $sp, $sp, -4 
	add $s7, $t6, $t2
	sw $s7, -536($fp)
	move $t2, $fp
	addi $t2, $t2, -500
	lw $t2, 0($t2)
	lw $t6, -536($fp)
	sw $t6, 0($t2)
	lw $s7, -448($fp)
	addi $sp, $sp, -4 
	addi $t8, $s7, 1
	sw $t8, -540($fp)
	lw $t8, -540($fp)
	lw $s7, -448($fp)
	move $s7, $t8
	sw $s7, -448($fp)
	j mylabel9
mylabel11:
	lw $t8, -444($fp)
	addi $sp, $sp, -4 
	addi $s7, $t8, 1
	sw $s7, -544($fp)
	lw $t8, -544($fp)
	lw $s7, -444($fp)
	move $s7, $t8
	sw $s7, -444($fp)
	j mylabel6
mylabel8:
	lw $t8, -444($fp)
	li $t8, 0
	sw $t8, -444($fp)
mylabel12:
	li $t8, 10
	lw $s7, -444($fp)
	blt $s7, $t8, mylabel13
	j mylabel14
mylabel13:
	lw $s4, -444($fp)
	li $t0, 4
	addi $sp, $sp, -4 
	mul $t1, $t0, $s4
	sw $t1, -548($fp)
	lw $t1, -548($fp)
	lw $s4, -488($fp)
	addi $sp, $sp, -4 
	add $t4, $s4, $t1
	sw $t4, -552($fp)
	addi $sp, $sp, -4 
	move $t1, $fp
	addi $t1, $t1, -552
	lw $t1, 0($t1)
	lw $t1, 0($t1)
	move $a0, $t1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t1, -444($fp)
	addi $sp, $sp, -4 
	addi $t4, $t1, 1
	sw $t4, -560($fp)
	lw $t1, -560($fp)
	lw $t4, -444($fp)
	move $t4, $t1
	sw $t4, -444($fp)
	j mylabel12
mylabel14:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
