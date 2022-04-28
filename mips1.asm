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

    li $a0, 1234	    # count = percent_base_10(1234)
    jal percent_base_10
    move $t1, $v0 		

    li $a0, '\n'	    # print_char('\n')
    li $v0, 11
    syscall

    move $a0, $t1	    # print_int(count)
    li $v0, 1
    syscall

    li $a0, 0 	    # exit(0)
    li $v0, 17
    syscall

percent_base_10:
    # $v0: count
    # $a0: value
    #c: remainder
    #d: count
    
    li $t0, 10 
    
    while_loop:
    	ble $a0, $zero, done 
    	div $a0, $t0
    	mfhi $a0 
    
    convert:
    	addi $a0, $a0, '0'
    
    print_c:
    	
    	li $v0, 11
    	syscall 
    	
    	mflo $a0
    	addiu $t1, $t1, 1
    	bge $a0., $zero, while_loop
    	
    done:
    	move $v0,$t1
    jr $ra
