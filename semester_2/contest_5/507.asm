extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy

section .data
    a dd 0
    strarr times 5500 db 0
    str1 times 11 db 0
    forms db `%s`, 0
    fc db `%c`, 0
    fd db `%d`, 0
    n dd 0

; Миловидов 105
global main
section .text
main:
    push ebp
    mov ebp, esp
    
    and esp, 0xfffffff0; выравнивание
    sub esp, 16
    mov [esp + 4], dword n
    mov [esp], dword fd
    call scanf; считываем длину ввода
    mov esi, 0; длина массива различных строк
    cmp [n], dword 0
    je .end
    mov [esp + 4], dword strarr
    mov [esp], dword forms
    call scanf; первая строка
    mov esi, 1
    dec dword [n]
    cmp [n], dword 0
    je .end
    .c1:
        dec dword [n]
        mov [esp + 4], dword str1
        mov [esp], dword forms
        call scanf
        mov ebx, strarr; адрес строки из массива
        mov edi, 0; номер текущей строки
        .c2:; сравниваем все строки с новой
            mov [esp], ebx
            call strcmp
            cmp eax, 0
            je .cz; если уже есть в массиве
            add ebx, 11
            inc edi
            cmp edi, esi; проверяем, не дошли ли до конца
            jne .c2
        .ec2:; если нет в массиве
        mov [esp], ebx
        call strcpy
        inc esi
        .cz:
        cmp [n], dword 0
        jne .c1
    .ec1:
    
    .end:
    mov [esp], dword fd
    mov [esp + 4], esi
    call printf
    xor eax, eax
    leave
    ret