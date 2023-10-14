extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    a dd 0
    f dd 0

global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_udec
    cmp eax, 0
    jne w
    call io_print_udec
    jmp ec
    w:
    mov [a], eax
    shr eax, 30
    cmp eax, 0
    je x
    mov [f], dword 1
    call io_print_udec
    x:
    mov ebx, 2
    
    c:
    mov eax, [a]
    mov ecx, ebx
    shl eax, cl
    shr eax, 29
    mov ecx, [f]
    cmp ecx, 1
    je y
    cmp eax, 0
    je z
    mov [f], dword 1
    y:
    call io_print_udec
    z:
    add ebx, 3
    cmp ebx, 32
    je ec
    jmp c
    ec:
    
    xor eax, eax
    ret