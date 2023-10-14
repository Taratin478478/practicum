extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    n1 dd 0
    n2 dd 0
    n3 dd 0
    count dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_dec
    mov ecx, eax
    sub ecx, 3
    mov [count], ecx
    call io_get_dec
    mov [n1], eax
    
    call io_get_dec
    cmp eax, [n1]
    jg f1
    mov [n2], eax
    jmp f2
    f1:
    mov ebx, [n1]
    mov [n1], eax
    mov [n2], ebx
    f2:
    
    call io_get_dec
    cmp eax, [n1]
    jg f3
    cmp eax, [n2]
    jg f4
    mov [n3], eax
    jmp f5
    f3:
    mov ebx, [n2]
    mov [n3], ebx
    mov ebx, [n1]
    mov [n2], ebx
    mov [n1], eax
    jmp f5
    f4:
    mov ebx, [n2]
    mov [n2], eax
    mov [n3], ebx
    f5:
    mov ecx, [count]
    jecxz ec
    mov [count], ecx
    c:
    call io_get_dec
    cmp eax, [n1]
    jg f6
    cmp eax, [n2]
    jg f7
    cmp eax, [n3]
    jg f8
    jmp f9
    f6:
    mov ebx, [n2]
    mov [n3], ebx
    mov ebx, [n1]
    mov [n2], ebx
    mov [n1], eax
    jmp f9
    f7:
    mov ebx, [n2]
    mov [n3], ebx
    mov [n2], eax
    jmp f9
    f8:
    mov [n3], eax
    f9:
    mov ecx, [count]
    dec ecx
    jecxz ec
    mov [count], ecx
    jmp c
    
    ec:
    mov eax, [n1]
    call io_print_dec
    mov eax, ' '
    call io_print_char
    mov eax, [n2]
    call io_print_dec
    mov eax, ' '
    call io_print_char
    mov eax, [n3]
    call io_print_dec
    
    xor eax, eax
    ret