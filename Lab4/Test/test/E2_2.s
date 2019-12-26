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

print:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	li $t0, 0
	sw $t0, -8($fp)
mylabel0:
	li $t1, 4
	lw $t2, -8($fp)
	blt $t2, $t1, mylabel1
	j mylabel2
mylabel1:
	lw $t3, -8($fp)
	li $t4, 4
	addi $sp, $sp, -4 
	mul $t5, $t4, $t3
	sw $t5, -12($fp)
	lw $t6, -12($fp)
	lw $t7, -4($fp)
	addi $sp, $sp, -4 
	add $t8, $t7, $t6
	sw $t8, -16($fp)
	addi $sp, $sp, -4 
	move $t9, $fp
	addi $t9, $t9, -16
	lw $t9, 0($t9)
	lw $t9, 0($t9)
	move $a0, $t9
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	lw $s0, -8($fp)
	addi $sp, $sp, -4 
	addi $s1, $s0, 1
	sw $s1, -24($fp)
	lw $s2, -24($fp)
	lw $s3, -8($fp)
	move $s3, $s2
	sw $s3, -8($fp)
	j mylabel0
mylabel2:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
product:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	addi $sp, $sp, -4 
	sw $a1, -8($fp) 
	addi $sp, $sp, -4 
	li $s4, 0
	sw $s4, -12($fp)
	addi $sp, $sp, -4 
	li $s5, 0
	sw $s5, -16($fp)
mylabel3:
	li $s6, 4
	lw $s7, -16($fp)
	blt $s7, $s6, mylabel4
	j mylabel5
mylabel4:
	lw $t0, -16($fp)
	li $t3, 4
	addi $sp, $sp, -4 
	mul $t5, $t3, $t0
	sw $t5, -20($fp)
	lw $t0, -20($fp)
	lw $t5, -4($fp)
	addi $sp, $sp, -4 
	add $t6, $t5, $t0
	sw $t6, -24($fp)
	lw $t0, -16($fp)
	li $t5, 4
	addi $sp, $sp, -4 
	mul $t6, $t5, $t0
	sw $t6, -28($fp)
	lw $t0, -28($fp)
	lw $t6, -8($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t0
	sw $t7, -32($fp)
	addi $sp, $sp, -4 
	move $t0, $fp
	addi $t0, $t0, -32
	lw $t0, 0($t0)
	lw $t0, 0($t0)
	addi $sp, $sp, -4 
	move $t6, $fp
	addi $t6, $t6, -24
	lw $t6, 0($t6)
	lw $t6, 0($t6)
	addi $sp, $sp, -4 
	mul $t7, $t6, $t0
	sw $t7, -44($fp)
	lw $t0, -44($fp)
	lw $t6, -12($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t0
	sw $t7, -48($fp)
	lw $t0, -48($fp)
	lw $t6, -12($fp)
	move $t6, $t0
	sw $t6, -12($fp)
	lw $t0, -16($fp)
	addi $sp, $sp, -4 
	addi $t6, $t0, 1
	sw $t6, -52($fp)
	lw $t0, -52($fp)
	lw $t6, -16($fp)
	move $t6, $t0
	sw $t6, -16($fp)
	j mylabel3
mylabel5:
	lw $t0, -12($fp)
	move $v0, $t0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
main:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -40
	addi $sp, $sp, -16 
	addi $sp, $sp, -16 
	addi $sp, $sp, -4 
	li $t6, 0
	sw $t6, -36($fp)
mylabel6:
	li $t6, 4
	lw $t7, -36($fp)
	blt $t7, $t6, mylabel7
	j mylabel8
mylabel7:
	lw $t8, -36($fp)
	li $t9, 4
	addi $sp, $sp, -4 
	mul $s0, $t9, $t8
	sw $s0, -40($fp)
	lw $t8, -40($fp)
	addi $sp, $sp, -4 
	move $s0, $fp
	addi $s0, $s0, -16
	sw $s0, -44($fp)
	addi $sp, $sp, -4 
	add $s0, $s0, $t8
	sw $s0, -48($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t8, $v0
	sw $t8, -52($fp)
	move $t8, $fp
	addi $t8, $t8, -48
	lw $t8, 0($t8)
	lw $s0, -52($fp)
	sw $s0, 0($t8)
	lw $s1, -36($fp)
	li $s2, 4
	addi $sp, $sp, -4 
	mul $s3, $s2, $s1
	sw $s3, -56($fp)
	lw $s1, -56($fp)
	addi $sp, $sp, -4 
	move $s3, $fp
	addi $s3, $s3, -32
	sw $s3, -60($fp)
	addi $sp, $sp, -4 
	add $s3, $s3, $s1
	sw $s3, -64($fp)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $s1, $v0
	sw $s1, -68($fp)
	move $s1, $fp
	addi $s1, $s1, -64
	lw $s1, 0($s1)
	lw $s3, -68($fp)
	sw $s3, 0($s1)
	lw $s4, -36($fp)
	addi $sp, $sp, -4 
	addi $s5, $s4, 1
	sw $s5, -72($fp)
	lw $s4, -72($fp)
	lw $s5, -36($fp)
	move $s5, $s4
	sw $s5, -36($fp)
	j mylabel6
mylabel8:
	lw $s4, -36($fp)
	li $s4, 0
	sw $s4, -36($fp)
	lw $a0, -44($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal print
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -76($fp)
	lw $a0, -44($fp) 
	lw $a1, -60($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal product
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -80($fp)
	lw $t1, -80($fp)
	move $a0, $t1
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
