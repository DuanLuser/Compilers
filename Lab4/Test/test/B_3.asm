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

isPrime:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	li $t0, 4
	lw $t1, -4($fp)
	div $t1, $t0
	addi $sp, $sp, -4 
	mflo $t2
	sw $t2, -8($fp)
	lw $t3, -8($fp)
	addi $sp, $sp, -4 
	move $t4, $t3
	sw $t4, -12($fp)
	addi $sp, $sp, -4 
	li $t5, 2
	sw $t5, -16($fp)
mylabel0:
	lw $t6, -12($fp)
	lw $t7, -16($fp)
	blt $t7, $t6, mylabel1
	j mylabel2
mylabel1:
	lw $t8, -16($fp)
	lw $t9, -4($fp)
	div $t9, $t8
	addi $sp, $sp, -4 
	mflo $s0
	sw $s0, -20($fp)
	lw $s1, -16($fp)
	lw $s2, -20($fp)
	addi $sp, $sp, -4 
	mul $s3, $s2, $s1
	sw $s3, -24($fp)
	lw $s4, -24($fp)
	lw $s5, -4($fp)
	beq $s5, $s4, mylabel3
	j mylabel4
mylabel3:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel4:
	lw $s6, -16($fp)
	addi $sp, $sp, -4 
	addi $s7, $s6, 1
	sw $s7, -28($fp)
	lw $t1, -28($fp)
	lw $t2, -16($fp)
	move $t2, $t1
	sw $t2, -16($fp)
	j mylabel0
mylabel2:
	li $v0, 1 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
isRever:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	lw $t1, -4($fp)
	addi $sp, $sp, -4 
	move $t2, $t1
	sw $t2, -8($fp)
	addi $sp, $sp, -40 
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -52($fp)
	addi $sp, $sp, -4 
	li $t1, 0
	sw $t1, -56($fp)
mylabel5:
	li $t1, 0
	lw $t2, -8($fp)
	bne $t2, $t1, mylabel6
	j mylabel7
mylabel6:
	lw $t3, -52($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -60($fp)
	lw $t3, -60($fp)
	addi $sp, $sp, -4 
	move $t5, $fp
	addi $t5, $t5, -48
	sw $t5, -64($fp)
	addi $sp, $sp, -4 
	add $t5, $t5, $t3
	sw $t5, -68($fp)
	li $t3, 10
	lw $t5, -8($fp)
	div $t5, $t3
	addi $sp, $sp, -4 
	mflo $t8
	sw $t8, -72($fp)
	li $t5, 10
	lw $t8, -72($fp)
	addi $sp, $sp, -4 
	mul $t9, $t8, $t5
	sw $t9, -76($fp)
	lw $t8, -76($fp)
	lw $t9, -8($fp)
	addi $sp, $sp, -4 
	sub $s0, $t9, $t8
	sw $s0, -80($fp)
	move $t8, $fp
	addi $t8, $t8, -68
	lw $t8, 0($t8)
	lw $t9, -80($fp)
	sw $t9, 0($t8)
	li $s0, 10
	lw $s1, -8($fp)
	div $s1, $s0
	addi $sp, $sp, -4 
	mflo $s2
	sw $s2, -84($fp)
	lw $s1, -84($fp)
	lw $s2, -8($fp)
	move $s2, $s1
	sw $s2, -8($fp)
	lw $s1, -52($fp)
	addi $sp, $sp, -4 
	addi $s2, $s1, 1
	sw $s2, -88($fp)
	lw $s1, -88($fp)
	lw $s2, -52($fp)
	move $s2, $s1
	sw $s2, -52($fp)
	j mylabel5
mylabel7:
	li $s1, 1
	lw $s2, -52($fp)
	addi $sp, $sp, -4 
	sub $s3, $s2, $s1
	sw $s3, -92($fp)
	lw $s2, -92($fp)
	lw $s3, -52($fp)
	move $s3, $s2
	sw $s3, -52($fp)
mylabel8:
	lw $s2, -52($fp)
	lw $s3, -56($fp)
	bne $s3, $s2, mylabel9
	j mylabel10
mylabel9:
	lw $s6, -56($fp)
	li $s7, 4
	addi $sp, $sp, -4 
	mul $t0, $s7, $s6
	sw $t0, -96($fp)
	lw $t0, -96($fp)
	lw $s6, -64($fp)
	addi $sp, $sp, -4 
	add $t6, $s6, $t0
	sw $t6, -100($fp)
	lw $t0, -52($fp)
	li $t6, 4
	addi $sp, $sp, -4 
	mul $s6, $t6, $t0
	sw $s6, -104($fp)
	lw $t0, -104($fp)
	lw $s6, -64($fp)
	addi $sp, $sp, -4 
	add $t7, $s6, $t0
	sw $t7, -108($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -108
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	addi $sp, $sp, -4 
	move $t7, $fp
	addi $t7, $t7, -100
	lw $t7, 0($t7)
	lw $t7, 0($t7)
	bne $t7, $t0, mylabel11
	j mylabel12
mylabel11:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel12:
	lw $s6, -56($fp)
	addi $sp, $sp, -4 
	addi $s4, $s6, 1
	sw $s4, -120($fp)
	lw $s4, -120($fp)
	lw $s6, -56($fp)
	move $s6, $s4
	sw $s6, -56($fp)
	li $s4, 1
	lw $s6, -52($fp)
	addi $sp, $sp, -4 
	sub $s5, $s6, $s4
	sw $s5, -124($fp)
	lw $s5, -124($fp)
	lw $s6, -52($fp)
	move $s6, $s5
	sw $s6, -52($fp)
	j mylabel8
mylabel10:
	li $v0, 1 
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
	li $s5, 100
	sw $s5, -4($fp)
	addi $sp, $sp, -4 
	li $s5, 110
	sw $s5, -8($fp)
	lw $s5, -4($fp)
	addi $sp, $sp, -4 
	move $s6, $s5
	sw $s6, -12($fp)
mylabel13:
	lw $s5, -8($fp)
	lw $s6, -12($fp)
	blt $s6, $s5, mylabel14
	j mylabel15
mylabel14:
	lw $a0, -12($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal isPrime
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -16($fp)
	li $t1, 1
	lw $t2, -16($fp)
	beq $t2, $t1, mylabel16
	j mylabel17
mylabel16:
	lw $t3, -12($fp)
	move $a0, $t3
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
mylabel17:
	lw $a0, -12($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal isRever
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -20($fp)
	li $t1, 1
	lw $t2, -20($fp)
	beq $t2, $t1, mylabel18
	j mylabel19
mylabel18:
	lw $t3, -12($fp)
	li $t4, 0
	addi $sp, $sp, -4 
	sub $t5, $t4, $t3
	sw $t5, -24($fp)
	lw $t6, -24($fp)
	move $a0, $t6
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
mylabel19:
	lw $t7, -12($fp)
	addi $sp, $sp, -4 
	addi $t8, $t7, 1
	sw $t8, -28($fp)
	lw $t9, -28($fp)
	lw $s0, -12($fp)
	move $s0, $t9
	sw $s0, -12($fp)
	j mylabel13
mylabel15:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
