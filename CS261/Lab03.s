    .section .text
    .global main

main:
    pushq	%rbp

    # printf("Enter two numbers --> ");
    mov $prompt1, %rdi
    xor %rax, %rax        # Must zero %rax before calling printf
    call printf

    # scanf ("%ld %ld", &i , &j);
    mov $format1, %rdi
    mov $i, %rsi          # $i is the memory adddress of the data 
    mov $j, %rdx
    xor %rax, %rax        # Must zero %rax before calling scanf
    call scanf

    # printf ("You entered i=%ld , j=%ld\n", i , j);
    mov $format2, %rdi
    mov i, %rsi           # %rsi = Mem[i] 
    mov j, %rdx           # %rdx = Mem[j]
    xor %rax, %rax        # Must zero %rax before calling printf
    call printf

    # absdiff
    mov $i, %rdi
    mov $j, %rsi
    xor %rax, %rax
    call absdiff

    # printf("Absolute Difference Between i & j is: ");
    mov $output, %rdi
    mov %rax, %rsi
    xor %rax, %rax
    call printf;

    popq	%rbp
    ret
#---------------------------------------------
    .section .data
# Remember: the value of each symbol is its memory address
i:  .quad 0
j:  .quad 0

    .section .rodata
prompt1:  .asciz "Enter two numbers --> "
format1:  .asciz  "%ld %ld"
format2:  .asciz "You entered i=%ld , j=%ld\n"
output:   .asciz "Absolute Difference Between i & j is: %ld\n"