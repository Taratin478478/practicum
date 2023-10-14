extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    count dd 0
    n dd 2147483647
    k dd 0
    r dd 0

global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_udec
    mov [count], eax
    mov ebx, 0
    c:
    call io_get_dec
    cmp eax, [n]
    mov [n], eax
    jg a
    mov eax, [k]
    mov [k], dword 0
    cmp eax, [r]
    jle a
    mov [r], eax
    a:
    inc dword [k]
    dec dword [count]
    cmp dword [count], 0
    je ec
    jmp c
    ec:
    mov eax, [k]
    cmp eax, [r]
    jg b
    mov eax, [r]
    b:
    call io_print_dec
            
    xor eax, eax
    ret