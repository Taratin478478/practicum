extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline

section .data
    n dd 0
    k dd 0
    r dd 1
    t dd 0
    a dd 0
    f dd 1

global main
section .text
main:
    push ebp
    mov ebp, esp; for correct debugging
    
    call io_get_udec
    push eax
    call io_get_udec
    push eax
    call gcd
    sub esp, 8
    push eax
    call io_get_udec
    push eax
    call gcd
    sub esp, 8
    push eax
    call io_get_udec
    push eax
    call gcd
    call io_print_udec
    xor eax, eax
    leave
    ret

gcd:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    cmp eax, ebx
    jge .c
    xchg eax, ebx
    .c:  
        xor edx, edx
        div ebx
        mov eax, ebx
        mov ebx, edx
        cmp ebx, 0
        je .ec
        jmp .c
    .ec:
    leave
    ret