extern io_get_dec, io_print_dec, io_print_string, io_print_char
extern io_newline

section .data
    a dd 0
    b dd 0
    c dd 0
    t dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_dec
    mov ebx, eax
    call io_get_dec
    mul ebx
    mov [a], eax
    mov [b], edx
    call io_get_dec
    mov [c], eax
    call io_get_dec
    mov [t], eax
    mov edx, [b]
    mov eax, [a]
    div dword [t]
    mov [b], edx
    mul dword [c]
    mov [a], eax
    mov eax, [b]
    mul dword [c]
    div dword [t]
    add eax, [a]
    call io_print_dec

    xor eax, eax
    ret