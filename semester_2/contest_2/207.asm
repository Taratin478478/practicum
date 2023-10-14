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
    
    xor ebx, ebx
    
    call io_get_udec
    movzx ecx, al
    shl ecx, 0
    add ebx, ecx
    
    call io_get_udec
    movzx ecx, al
    shl ecx, 8
    add ebx, ecx
    
    call io_get_udec
    movzx ecx, al
    shl ecx, 16
    add ebx, ecx
    
    call io_get_udec
    movzx ecx, al
    shl ecx, 24
    add ebx, ecx
    
    mov eax, ebx
    call io_print_udec
    
    xor eax, eax
    ret