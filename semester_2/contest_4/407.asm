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
    
    .c1:
        call atfunc
        mov ecx, 2011
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

atfunc:
    push ebp
    mov ebp, esp
    push ebx
    xor ebx, ebx
    mov eax, [ebp + 8]
    cmp eax, 0
    je .ec2
    mul eax
    mov ecx, [ebp + 12]
    .c2:
        xor edx, edx
        imul ebx, ecx
        div ecx
        add ebx, edx
        cmp eax, 0
        jne .c2
    .ec2:
    mov eax, ebx
    mov ebx, [ebp - 4]
    
    leave
    ret