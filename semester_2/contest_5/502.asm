extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr

section .data
    a dd 0
    str1 times 1001 db 0
    str2 times 1001 db 0
    str3 db "1 2", 0
    str4 db "2 1", 0
    str5 db `%s`, 0
    str6 db `%c`, 0

; Миловидов 105
global main
section .text
main:
    push ebp
    mov ebp, esp
    
    and esp, 0xfffffff0; выравнивание
    sub esp, 16
    mov [esp + 4], dword str1
    mov [esp], dword str5
    call scanf
    mov [esp + 4], dword str2
    mov [esp], dword str5
    call scanf
    mov [esp + 4], dword str1   
    mov [esp], dword str2
    call strstr; проверяем вхождение 1 в 2
    cmp eax, 0
    je .g
    mov [esp + 4], dword str3   
    mov [esp], dword str5
    call printf
    jmp .end
    .g:
    mov [esp + 4], dword str2
    mov [esp], dword str1
    call strstr; проверяем вхождение 2 в 1
    cmp eax, 0
    je .p0
    mov [esp + 4], dword str4   
    mov [esp], dword str5
    call printf
    jmp .end
    .p0:
    mov [esp + 4], dword '0'
    mov [esp], dword str6   
    call printf
    
    .end:
    xor eax, eax
    leave
    ret