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

Add:
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
	lw $t0, -8($fp)
	lw $t1, -4($fp)
	addi $sp, $sp, -4 
	add $t2, $t1, $t0
	sw $t2, -32($fp)
	lw $t3, -12($fp)
	lw $t4, -32($fp)
	addi $sp, $sp, -4 
	add $t5, $t4, $t3
	sw $t5, -36($fp)
	lw $t6, -16($fp)
	lw $t7, -36($fp)
	addi $sp, $sp, -4 
	add $t8, $t7, $t6
	sw $t8, -40($fp)
	lw $t9, -20($fp)
	lw $s0, -40($fp)
	addi $sp, $sp, -4 
	add $s1, $s0, $t9
	sw $s1, -44($fp)
	lw $s2, -24($fp)
	lw $s3, -44($fp)
	addi $sp, $sp, -4 
	add $s4, $s3, $s2
	sw $s4, -48($fp)
	lw $s5, -28($fp)
	lw $s6, -48($fp)
	addi $sp, $sp, -4 
	add $s7, $s6, $s5
	sw $s7, -52($fp)
	lw $t0, -52($fp)
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
	li $t0, 1
	move $a0, $t0 
	li $t1, 2
	move $a1, $t1 
	li $t2, 3
	move $a2, $t2 
	li $t3, 4
	move $a3, $t3 
	li $t4, 7
	addi $sp, $sp, -4 
	sw $t4, 0($sp) 
	li $t5, 6
	addi $sp, $sp, -4 
	sw $t5, 0($sp) 
	li $t6, 5
	addi $sp, $sp, -4 
	sw $t6, 0($sp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal Add
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4 
	move $t7, $v0
	sw $t7, -16($fp)
	lw $t8, -16($fp)
	move $a0, $t8
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
