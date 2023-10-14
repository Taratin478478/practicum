extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char
extern io_newline

section .data
    x1 dd 0
    y1 dd 0
    x2 dd 0
    y2 dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_char
    sub eax, 64
    mov [x1], eax
    call io_get_dec
    mov [y1], eax
    call io_get_char
    call io_get_char
    sub eax, 64
    mov [x2], eax
    call io_get_dec
    mov [y2], eax
    
    mov eax, [x1]
    sub eax, [x2]
    mov ebx, [x2]
    sub ebx, [x1]    
    mov ecx, eax
    shr ecx, 31
    xor ecx, 1
    mov edx, ebx
    shr edx, 31
    xor edx, 1
    imul eax, ecx
    imul ebx, edx
    add eax, ebx
    mov [x1], eax
    
    mov eax, [y1]
    sub eax, [y2]
    mov ebx, [y2]
    sub ebx, [y1]    
    mov ecx, eax
    shr ecx, 31
    xor ecx, 1
    mov edx, ebx
    shr edx, 31
    xor edx, 1
    imul eax, ecx
    imul ebx, edx
    add eax, ebx
    
    add eax, [x1]
    call io_print_dec
    
    xor eax, eax
    ret