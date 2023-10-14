extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline

section .data


global main
section .text
main:
    push ebp
    mov ebp, esp

    
    call io_get_dec
    push eax
    call io_get_dec
    mov ebx, eax
    call io_get_dec
    xor edx, edx
    mov ecx, 2011
    div ecx
    push edx
    push edx
    
    .c1:
        call hashfunc
        mov ecx, 2011
        mov edx, [esp]
        mov [esp + 4], edx
        xor edx, edx
        div ecx
        mov [esp], edx
        dec ebx
        jnz .c1
    .ec1:
    
    mov eax, [esp]
    call io_print_udec
    xor eax, eax
    leave
    ret

hashfunc:
    push ebp
    mov ebp, esp
    push ebx
    mov eax, [ebp + 12]; right
    xor ebx, ebx
    mov ecx, [ebp + 16]; k
    
    .c2:
        inc ebx
        xor edx, edx
        div ecx
        cmp eax, 0
        jne .c2
    .ec2:
    
    mov eax, [ebp + 8]; left
    xor edx, edx
    
    .c3:
        mul ecx
        dec ebx
        jnz .c3
    .ec3:
    
    add eax, [ebp + 12]
    mov ebx, [ebp - 4]
    leave
    ret