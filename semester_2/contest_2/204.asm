extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    x dd 0
    n dd 0
    m dd 0
    y dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    xor ebx, ebx
    
    call io_get_dec
    mov [x], eax
    call io_get_dec
    mov [n], eax
    call io_get_dec
    mov [m], eax
    call io_get_dec
    mov [y], eax

    mov ecx, [n]
    sub ecx, [m]
    mov ebx, [y]
    sub ebx, 2011
    imul ecx, ebx
    mov eax, [x]
    add eax, ecx
    
    call io_print_dec

    xor eax, eax
    ret