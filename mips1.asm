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
		.include "include/syscall_macros.s"

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
    read_int($a3)
    jal percent_unsigned_base

    move $t1, $v0	    # print_int(count)
    li $v0, 4
    syscall
	
    li $a0, '\n'	    # print_char('\n')
    li $v0, 11
    syscall
    
    move $a0, $t1 	    # exit(0)
    li $v0, 11
    syscall
    
    print_int($t1)
    
    terminate($zero)
    
    li $a0, 0 
    li $v0, 17
    syscall 

percent_unsigned_base:
    # $v0: count
    # $a0: buffer
    # $a1: size
    # $a2: value
    # $a3: user input
    # $t0: holding 9
    # $t1: counter 
    # $t2: print count
    
    
    addiu $sp, $sp, 16 
    
    li $t0, 9 
    
    while_loop:
    	ble $a2, $zero, next 
    	div $a2, $a3
    	mfhi $a2 
 
    
    convert:
    	ble $a2, $t0, less
    	bgeu $a2, $t0, greater
    	
    less:
    	addi $a2, $a2, '0'
    	b push_value 
    	
    greater:
    	subiu $a2, $a2, 10
    	addi $a2, $a2, 'A'
    	b push_value
    	
    push_value:
    
    	sw $a2, ($sp)
    	subiu $sp, $sp,4 
    	
        mflo $a2
        addiu $t1, $t1, 1
        bge $a2, $zero, while_loop
        	
    next:
       addiu $sp, $sp, 4
       
       move $t2, $t1
    
    get_stack:
    	lw $a2, ($sp)
    	addiu $sp, $sp, 4
    	sb $a2, ($a0)
    	addiu $a0, $a0, 1 
    	subiu $t2, $t2,1
    	bnez $t2, get_stack
    	
    	subiu $sp, $sp, 16 
    	
    done:
    	move $v0,$t1
    	subu $a0, $a0, $v0	
        jr $ra
