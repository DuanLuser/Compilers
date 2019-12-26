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

fact:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	addi $sp, $sp, -4 
	sw $a0, -4($fp) 
	li $t0, 1
	lw $t1, -4($fp)
	beq $t1, $t0, mylabel0
	j mylabel1
mylabel0:
	move $v0, $t1 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
	j mylabel2
mylabel1:
	sub $t2, $t1, $t0
	addi $sp, $sp, -4 
	sw $t0, -8($fp)
	sw $t1, -4($fp)
	addi $sp, $sp, -4 
	sw $t2, -12($fp)
	lw $a0, -12($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal fact
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $t0, $v0
	lw $t1, -4($fp)
	mul $t2, $t1, $t0
	move $v0, $t2 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel2:
main:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	li $t3, 1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $t4, $v0
	move $t5, $t4
	bgt $t5, $t3, mylabel3
	j mylabel4
mylabel3:
	addi $sp, $sp, -4 
	sw $t0, -4($fp)
	sw $t1, -4($fp)
	addi $sp, $sp, -4 
	sw $t2, -8($fp)
	addi $sp, $sp, -4 
	sw $t3, -12($fp)
	addi $sp, $sp, -4 
	sw $t4, -16($fp)
	addi $sp, $sp, -4 
	sw $t5, -20($fp)
	lw $a0, -20($fp) 
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	jal fact
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $t0, $v0
	move $t1, $t0
	j mylabel5
mylabel4:
	li $t1, 1
mylabel5:
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
