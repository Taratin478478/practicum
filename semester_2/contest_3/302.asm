extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    n1 dd 0
    n2 dd 0
    n3 dd 0
    count dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_udec
    mov ebx, eax
    xor eax, eax
    mov ecx, 32
    c:
    mov edx, ebx
    and edx, 1
    add eax, edx
    shr ebx, 1
    dec ecx
    jecxz ec
    jmp c
    ec:
    call io_print_dec
    
    xor eax, eax
    ret