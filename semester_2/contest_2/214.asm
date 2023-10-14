extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    n dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    xor ebx, ebx
    
    call io_get_dec
    mov ebx, eax
    call io_get_dec
    imul ebx, eax
    call io_get_dec
    imul ebx, eax
    call io_get_dec
    add ebx, eax
    dec ebx
    xchg eax, ebx
    xor edx, edx
    div ebx
    mov [n], eax
    call io_get_dec
    xor edx, edx
    mov ecx, 6
    div ecx
    add eax, 5
    xor edx, edx
    div ecx
    mov ebx, eax
    call io_get_dec
    mov eax, [n]
    xor edx, edx
    dec eax
    mov ecx, 3
    div ecx
    inc eax
    mul ebx
    mov ebx, eax
    mov eax, [n]
    sub eax, ebx
    call io_print_dec
    
    xor eax, eax
    ret