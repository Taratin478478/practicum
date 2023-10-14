extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf

section .data
    a dd 0
    str1 db `0x%08X\n`, 0
    str2 db `%u`, 0
    str3 db `%c`, 0

global main
section .text
main:
    push ebp
    mov ebp, esp
    
    and esp, 0xfffffff0
    sub esp, 16
    .c1:
        mov [esp], dword str2
        mov [esp + 4], dword a
        call scanf
        mov [esp], dword str1
        mov eax, [a]
        mov [esp + 4], eax
        call printf
        mov [esp], dword str3
        mov [esp + 4], dword a
        call scanf
        mov al, [a]
        cmp al, ' '
        je .c1
    .ec1:
    xor eax, eax
    leave
    ret

func:
    push ebp
    mov ebp, esp



    leave
    ret