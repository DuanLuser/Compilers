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

hanoi:
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
	li $t0, 1
	lw $t1, -4($fp)
	beq $t1, $t0, mylabel0
	j mylabel1
mylabel0:
	li $t2, 1000000000
	lw $t3, -8($fp)
	addi $sp, $sp, -4 
	mul $t4, $t3, $t2
	sw $t4, -20($fp)
	lw $t5, -16($fp)
	lw $t6, -20($fp)
	addi $sp, $sp, -4 
	add $t7, $t6, $t5
	sw $t7, -24($fp)
	lw $t8, -24($fp)
	move $a0, $t8
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	j mylabel2
mylabel1:
	li $t9, 1
	lw $s0, -4($fp)
	addi $sp, $sp, -4 
	sub $s1, $s0, $t9
	sw $s1, -28($fp)
	lw $a0, -28($fp) 
	lw $a1, -8($fp) 
	lw $a2, -16($fp) 
	lw $a3, -12($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal hanoi
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -32($fp)
	li $t1, 1000000000
	lw $t2, -8($fp)
	addi $sp, $sp, -4 
	mul $t3, $t2, $t1
	sw $t3, -36($fp)
	lw $t4, -16($fp)
	lw $t5, -36($fp)
	addi $sp, $sp, -4 
	add $t6, $t5, $t4
	sw $t6, -40($fp)
	lw $t7, -40($fp)
	move $a0, $t7
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	li $t8, 1
	lw $t9, -4($fp)
	addi $sp, $sp, -4 
	sub $s0, $t9, $t8
	sw $s0, -44($fp)
	lw $a0, -44($fp) 
	lw $a1, -12($fp) 
	lw $a2, -8($fp) 
	lw $a3, -16($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal hanoi
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t0, $v0
	sw $t0, -48($fp)
mylabel2:
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
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t1, $v0
	sw $t1, -4($fp)
	lw $t2, -4($fp)
	addi $sp, $sp, -4 
	move $t3, $t2
	sw $t3, -8($fp)
	lw $a0, -8($fp) 
	li $t0, 1
	move $a1, $t0 
	li $t1, 2
	move $a2, $t1 
	li $t2, 3
	move $a3, $t2 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal hanoi
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t3, $v0
	sw $t3, -12($fp)
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
