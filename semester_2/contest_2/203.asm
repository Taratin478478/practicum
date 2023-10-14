extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    a dd 0
    b dd 0
    c dd 0
    d dd 0
    e dd 0
    f dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    xor ebx, ebx
    
    call io_get_dec
    mov [a], eax
    call io_get_dec
    mov [b], eax
    call io_get_dec
    mov [c], eax
    call io_get_dec
    mov [d], eax
    call io_get_dec
    mov [e], eax
    call io_get_dec
    mov [f], eax
    
    mov eax, [a]
    mul dword [e]
    add ebx, eax
    mov eax, [a]
    mul dword [f]
    add ebx, eax
    mov eax, [b]
    mul dword [d]
    add ebx, eax
    mov eax, [b]
    mul dword [f]
    add ebx, eax
    mov eax, [c]
    mul dword [d]
    add ebx, eax
    mov eax, [c]
    mul dword [e]
    add eax, ebx
    call io_print_dec

    xor eax, eax
    ret