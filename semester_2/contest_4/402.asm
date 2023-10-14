extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline

section .data
    n dd 0
    k dd 0
    r dd 1
    t dd 0
    a dd 0
    f dd 1

global main
section .text
main:
    push ebp
    mov ebp, esp
    
    call io_get_udec
    push eax
    call ones
    
    call io_print_udec
    xor eax, eax
    leave
    ret

ones:
    push ebp
    mov ebp, esp
    push ebx
    
    
    mov eax, [ebp + 8]
    mov ecx, 3
    xor edx, edx
    div ecx
    and edx, 1
    mov ebx, eax
    mov eax, edx
    
    cmp ebx, 0
    je .end
    push ebx
    mov ebx, eax
    call ones
    add esp, 4
    add eax, ebx
    .end:
    pop ebx
    leave
    ret