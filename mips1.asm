# Name: percent_base_10
# File: conversion.s
# Declaration:  int percent_base_10( int value)
# Semantics:
#    - iteratively divides the input value by 10.
#    - converts the remainder to ASCII
#    - print outs the ASCII character to the stdout
#    - returns the number of ASCII characters printed
# Edge Condition:
#    - value = 0;

# Starter Code:
    .text
    .globl main
    
main:
    # $t1: count

    li $t0, 16 
    li $v0, 9 
    move $a0, $t0 
    syscall
    
    move $a0, $v0

    move $a1, $t0
    li $a2, 1234	    # count = percent_base_10(1234)
    jal percent_base_10

    move $t1, $v0	    # print_int(count)
    li $v0, 4
    syscall
	
    li $a0, '\n'	    # print_char('\n')
    li $v0, 11
    syscall
    
    move $a0, $t1 	    # exit(0)
    li $v0, 11
    syscall
    
    li $a0, 0 
    li $v0, 17
    syscall 

percent_base_10:
    # $v0: count
    # $a0: buffer
    # $a1: size
    # $a2: value
    # $t0: holding 10
    # $t1: counter 
    # $t2: print count
    
    
    addiu $sp, $sp, 16 
    
    li $t0, 10 
    
    while_loop:
    	ble $a2, $zero, next 
    	div $a2, $t0
    	mfhi $a2 
 
    
    convert:
    	addi $a2, $a2, '0'
    	sw $a2, ($sp)
    	subiu $sp, $sp, 4 
    	
    	mflo $a2
    	addiu $t1, $t1, 1
    	bge $a2, $zero, while_loop
    
    next:
       addiu $sp. $sp, 4
       
       move $t2, $t1
    
    get_stsck:
    	lw $a2, ($sp)
    	addui $sp, $sp, 4
    	sb $a2, ($a0)
    	addiu $a0, $a0, 1 
    	subiu $t2, $t2,1
    	bnez $t2, get_stack
    	
    	subiu $sp, $sp, 16 
    	
    done:
    	move $v0,$t1
    	subu $a0, $a0, $v0	
        jr $ra
