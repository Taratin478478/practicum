extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    n dd 0
    k dd 0
    r dd 0

global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_udec
    mov [n], eax
    call io_get_dec
    mov ebx, 32
    sub ebx, eax
    mov [k], ebx
    mov ebx, 0
    c:
    mov eax, [n]
    mov ecx, ebx
    shl eax, cl
    mov  ecx, [k]
    shr eax, cl
    cmp eax, [r]
    jle a
    mov [r], eax
    a:
    inc ebx
    cmp ebx, [k]
    jg ec
    jmp c
    ec:
    mov eax, [r]
    call io_print_dec
            
    xor eax, eax
    ret