extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline

section .data


global main
section .text
main:
    push ebp
    mov ebp, esp

    
    call io_get_udec
    push eax
    mov ebx, eax
    call io_get_udec
    push eax
    mov esi, -1
    
    .c1:
        call numsum
        add ebx, eax
        mov [esp + 4], eax
        cmp eax, esi
        mov esi, eax
        jne .c1
    .ec1:
    
    mov eax, ebx
    call io_print_udec
    xor eax, eax
    leave
    ret

numsum:
    push ebp
    mov ebp, esp
    push ebx
    xor ebx, ebx
    mov eax, [ebp + 12]
    cmp eax, 0
    je .ec2
    mov ecx, [ebp + 8]
    .c2:
        xor edx, edx
        div ecx
        add ebx, edx
        cmp eax, 0
        jne .c2
    .ec2:
    mov eax, ebx
    pop ebx
    
    leave
    ret