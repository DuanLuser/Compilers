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
	sub $t0, $t1, $t0
	mul $t1, $t1, $t0
	move $v0, $t1 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
mylabel2:
main:
	addi $sp, $sp, -4 
	sw $fp, 0($sp) 
	move $fp, $sp 
	li $t0, 0
	li $t1, 1
	li $t2, 0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal read
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $t3, $v0
	move $t4, $t3
mylabel3:
	blt $t2, $t4, mylabel4
	j mylabel5
mylabel4:
	add $t5, $t0, $t1
	move $t6, $t5
	move $a0, $t1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal write
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $t0, $t1
	move $t1, $t6
	addi $t7, $t2, 1
	move $t2, $t7
	j mylabel3
mylabel5:
	li $v0, 0 
	move $sp, $fp 
	lw $fp, 0($sp) 
	addi $sp, $sp, 4 
	jr $ra
