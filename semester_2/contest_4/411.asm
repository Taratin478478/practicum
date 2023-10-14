extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline

section .data


global main
section .text
main:
    push ebp
    mov ebp, esp

    call io_get_udec
    mov ebx, eax
    .c1:
        call io_get_udec
        push eax
        call div3
        pop eax
        
        dec ebx
        jnz .c1
    .ec1:

    xor eax, eax
    leave
    ret

div3:
    push ebp
    mov ebp, esp
    push ebx
    xor edx, edx
    mov eax, [ebp + 8]
    .c2:
        shr eax, 2
        jnc .nc2
        inc edx
        .nc2:
        cmp eax, 0
        jne .c2
    .ec2:
    mov eax, [ebp + 8]
    shl eax, 1
    .c3:
        shr eax, 2
        jnc .nc3
        dec edx
        .nc3:
        cmp eax, 0
        jne .c3
    .ec3:
    cmp edx, 0
    jge .ge
    neg edx
    
    .ge:
    cmp edx, 0
    je .yes
    cmp edx, 3
    je .yes
    cmp edx, 1
    je .no
    cmp edx, 2
    je .no
    jmp .rec
    .yes:
    mov eax, 'Y'
    call io_print_char
    mov eax, 'E'
    call io_print_char
    mov eax, 'S'
    call io_print_char
    call io_newline
    jmp .end
    .no:
    mov eax, 'N'
    call io_print_char
    mov eax, 'O'
    call io_print_char
    call io_newline
    jmp .end    
    .rec:
    push edx
    call div3
    pop edx
    .end:
    pop ebx
    leave
    ret