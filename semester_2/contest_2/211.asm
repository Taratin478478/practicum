extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char
extern io_newline

section .data
    x dd 0
    y dd 0
    a dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_char
    sub eax, 64
    mov ebx, 8
    sub ebx, eax
    mov [x], ebx
    call io_get_dec
    mov ebx, 8
    sub ebx, eax
    mov [y], ebx
    xor ebx, ebx
    
    xor edx, edx
    mov eax, [y]
    inc eax
    mov ecx, 2
    div ecx 
    mov [a], eax
    
    xor edx, edx
    mov eax, [x]
    mov ecx, 2
    div ecx 
    imul eax, [a]
    add ebx, eax
    
    xor edx, edx
    mov eax, [y]
    mov ecx, 2
    div ecx 
    mov [a], eax
    
    xor edx, edx
    mov eax, [x]
    inc eax
    mov ecx, 2
    div ecx 
    imul eax, [a]
    add ebx, eax
    
    mov eax, ebx
    call io_print_dec
    
    xor eax, eax
    ret