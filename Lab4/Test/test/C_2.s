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

mod:
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
	div $t1, $t0
	addi $sp, $sp, -4 
	mflo $t2
	sw $t2, -12($fp)
	lw $t3, -8($fp)
	lw $t4, -12($fp)
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -16($fp)
	lw $t6, -16($fp)
	lw $t7, -4($fp)
	addi $sp, $sp, -4 
	sub $t8, $t7, $t6
	sw $t8, -20($fp)
	lw $t9, -20($fp)
	addi $sp, $sp, -4 
	move $s0, $t9
	sw $s0, -24($fp)
	lw $s1, -24($fp)
	addi $sp, $sp, -4 
	move $s2, $s1
	sw $s2, -28($fp)
	lw $s3, -24($fp)
	move $v0, $s3 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
power:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $a1, -8($fp) 
	lw $s4, -8($fp)
	addi $sp, $sp, -4 
	addi $s5, $s4, 1
	sw $s5, -12($fp)
	lw $s6, -8($fp)
	lw $s7, -12($fp)
	addi $sp, $sp, -4 
	sub $t0, $s7, $s6
	sw $t0, -16($fp)
	lw $t0, -16($fp)
	addi $sp, $sp, -4 
	move $t1, $t0
	sw $t1, -20($fp)
mylabel0:
	lw $t0, -20($fp)
	addi $sp, $sp, -4 
	sub $t1, $t0, $t0
	sw $t1, -24($fp)
	lw $t0, -24($fp)
	addi $sp, $sp, -4 
	addi $t1, $t0, 90
	sw $t1, -28($fp)
	li $t0, 89
	lw $t1, -28($fp)
	addi $sp, $sp, -4 
	sub $t2, $t1, $t0
	sw $t2, -32($fp)
	lw $t1, -32($fp)
	addi $sp, $sp, -4 
	addi $t2, $t1, 1
	sw $t2, -36($fp)
	li $t1, 2
	lw $t2, -36($fp)
	addi $sp, $sp, -4 
	sub $t3, $t2, $t1
	sw $t3, -40($fp)
	lw $t2, -40($fp)
	lw $t3, -8($fp)
	bgt $t3, $t2, mylabel1
	j mylabel2
mylabel1:
	lw $t4, -4($fp)
	lw $t5, -20($fp)
	addi $sp, $sp, -4 
	mul $t6, $t5, $t4
	sw $t6, -44($fp)
	lw $t4, -44($fp)
	lw $t5, -20($fp)
	move $t5, $t4
	sw $t5, -20($fp)
	lw $t4, -8($fp)
	li $t5, 2
	addi $sp, $sp, -4 
	mul $t6, $t5, $t4
	sw $t6, -48($fp)
	lw $t4, -8($fp)
	li $t6, 1
	addi $sp, $sp, -4 
	mul $t7, $t6, $t4
	sw $t7, -52($fp)
	lw $t4, -52($fp)
	lw $t7, -48($fp)
	addi $sp, $sp, -4 
	sub $t8, $t7, $t4
	sw $t8, -56($fp)
	li $t4, 1
	lw $t7, -56($fp)
	addi $sp, $sp, -4 
	sub $t8, $t7, $t4
	sw $t8, -60($fp)
	lw $t7, -60($fp)
	lw $t8, -8($fp)
	move $t8, $t7
	sw $t8, -8($fp)
	j mylabel0
mylabel2:
	lw $t7, -20($fp)
	move $v0, $t7 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
getNumDigits:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	li $t8, 0
	sw $t8, -8($fp)
	li $t8, 0
	lw $t9, -4($fp)
	blt $t9, $t8, mylabel3
	j mylabel4
mylabel3:
	li $s0, 1
	li $s1, 0
	addi $sp, $sp, -4 
	sub $s2, $s1, $s0
	sw $s2, -12($fp)
	lw $s2, -12($fp)
	move $v0, $s2 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel4:
mylabel5:
	li $s4, 0
	lw $s5, -4($fp)
	bgt $s5, $s4, mylabel6
	j mylabel7
mylabel6:
	li $s6, 10
	lw $s7, -4($fp)
	div $s7, $s6
	addi $sp, $sp, -4 
	mflo $s3
	sw $s3, -16($fp)
	lw $s3, -16($fp)
	lw $s7, -4($fp)
	move $s7, $s3
	sw $s7, -4($fp)
	lw $s3, -8($fp)
	addi $sp, $sp, -4 
	addi $s7, $s3, 2
	sw $s7, -20($fp)
	lw $s3, -20($fp)
	lw $s7, -8($fp)
	move $s7, $s3
	sw $s7, -8($fp)
	lw $s3, -8($fp)
	addi $sp, $sp, -4 
	addi $s7, $s3, 2
	sw $s7, -24($fp)
	lw $s3, -24($fp)
	lw $s7, -8($fp)
	move $s7, $s3
	sw $s7, -8($fp)
	li $s3, 3
	lw $s7, -8($fp)
	addi $sp, $sp, -4 
	sub $t0, $s7, $s3
	sw $t0, -28($fp)
	lw $t0, -28($fp)
	lw $s7, -8($fp)
	move $s7, $t0
	sw $s7, -8($fp)
	j mylabel5
mylabel7:
	lw $t0, -8($fp)
	move $v0, $t0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
isNarcissistic:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	lw $s7, -4($fp)
	addi $sp, $sp, -4 
	addi $t1, $s7, 1
	sw $t1, -8($fp)
	li $t1, 1
	lw $s7, -8($fp)
	addi $sp, $sp, -4 
	sub $t2, $s7, $t1
	sw $t2, -12($fp)
	lw $a0, -12($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal getNumDigits
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -16($fp)
	lw $t1, -16($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -20($fp)
	addi $sp, $sp, -4 
	li $t3, 0
	sw $t3, -24($fp)
	lw $t4, -4($fp)
	addi $sp, $sp, -4 
	move $t5, $t4
	sw $t5, -28($fp)
mylabel8:
	li $t6, 0
	lw $t7, -28($fp)
	bgt $t7, $t6, mylabel9
	j mylabel10
mylabel9:
	lw $a0, -28($fp) 
	li $t0, 10
	move $a1, $t0 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal mod
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t1, $v0
	sw $t1, -32($fp)
	lw $t2, -32($fp)
	addi $sp, $sp, -4 
	move $t3, $t2
	sw $t3, -36($fp)
	lw $t4, -36($fp)
	lw $t5, -28($fp)
	addi $sp, $sp, -4 
	sub $t6, $t5, $t4
	sw $t6, -40($fp)
	li $t7, 10
	lw $t8, -40($fp)
	div $t8, $t7
	addi $sp, $sp, -4 
	mflo $t9
	sw $t9, -44($fp)
	lw $s0, -44($fp)
	lw $s1, -28($fp)
	move $s1, $s0
	sw $s1, -28($fp)
	lw $a0, -36($fp) 
	lw $a1, -20($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal power
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -48($fp)
	lw $t1, -48($fp)
	lw $t2, -24($fp)
	addi $sp, $sp, -4 
	add $t3, $t2, $t1
	sw $t3, -52($fp)
	lw $t4, -52($fp)
	lw $t5, -24($fp)
	move $t5, $t4
	sw $t5, -24($fp)
	j mylabel8
mylabel10:
	lw $t6, -4($fp)
	lw $t7, -24($fp)
	beq $t7, $t6, mylabel11
	j mylabel12
mylabel11:
	li $v0, 1 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
	j mylabel13
mylabel12:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel13:
main:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	li $t8, 0
	sw $t8, -4($fp)
	addi $sp, $sp, -4 
	li $t9, 300
	sw $t9, -8($fp)
mylabel14:
	li $s0, 500
	lw $s1, -8($fp)
	blt $s1, $s0, mylabel15
	j mylabel16
mylabel15:
	lw $a0, -8($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal isNarcissistic
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -12($fp)
	li $t1, 1
	lw $t2, -12($fp)
	beq $t2, $t1, mylabel17
	j mylabel18
mylabel17:
	lw $t3, -8($fp)
	move $a0, $t3
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $t4, -4($fp)
	addi $sp, $sp, -4 
	addi $t5, $t4, 1
	sw $t5, -16($fp)
	lw $t6, -16($fp)
	lw $t7, -4($fp)
	move $t7, $t6
	sw $t7, -4($fp)
mylabel18:
	lw $t8, -8($fp)
	addi $sp, $sp, -4 
	addi $t9, $t8, 1
	sw $t9, -20($fp)
	lw $s0, -20($fp)
	lw $s1, -8($fp)
	move $s1, $s0
	sw $s1, -8($fp)
	j mylabel14
mylabel16:
	lw $s2, -4($fp)
	move $a0, $s2
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $s3, -4($fp)
	move $v0, $s3 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
