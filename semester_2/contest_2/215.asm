extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    x1 dd 0
    x2 dd 0
    x3 dd 0
    y1 dd 0
    y2 dd 0
    y3 dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    xor ebx, ebx
    
    call io_get_dec
    mov [x1], eax
    call io_get_dec
    mov [y1], eax
    call io_get_dec
    mov [x2], eax
    call io_get_dec
    mov [y2], eax
    call io_get_dec
    mov [x3], eax
    call io_get_dec
    mov [y3], eax
    
    xor ebx, ebx
    mov eax, [x1]
    mul dword [y2]
    add ebx, eax
    mov eax, [x2]
    mul dword [y3]
    add ebx, eax
    mov eax, [x3]
    mul dword [y1]
    add ebx, eax
    
    mov eax, [y1]
    mul dword [x2]
    sub ebx, eax
    mov eax, [y2]
    mul dword [x3]
    sub ebx, eax
    mov eax, [y3]
    mul dword [x1]
    sub ebx, eax
    
    mov ecx, ebx
    shr ecx, 31
    mov eax, ebx
    not eax
    inc eax
    mul ecx
    xor ecx, 1
    imul ebx, ecx
    add eax, ebx
    mov ecx, 2
    div ecx
    mov ebx, edx
    
    call io_print_dec
    mov eax, '.'
    call io_print_char
    mov eax, ebx
    mov ecx, 5
    mul ecx
    call io_print_dec
    xor eax, eax
    ret