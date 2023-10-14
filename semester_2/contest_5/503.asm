;extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy, fscanf, fprintf, fopen, qsort, malloc, free, fclose, strlen

section .data
    fss db `%s`, 0
    fsc db `%c`, 0
    fsd db `%d`, 0
    fsu db `%u`, 0
    fsnl db `\n`, 0
    infile dd 0
    outfile dd 0
    inputname db `input.txt`, 0
    outputname db `output.txt`, 0
    reads db `r`, 0
    writes db `w`, 0
    
    str1 times 101 db 0
    str2 times 101 db 0
    

; Миловидов 105
global main
section .text
main:
    push ebp
    mov ebp, esp
    and esp, 0xfffffff0
    sub esp, 16
    
    mov [esp], dword fss
    mov [esp + 4], dword str1
    call scanf
    mov [esp + 4], dword str2
    call scanf
    mov [esp], dword str1
    call strstr
    mov ebx, str1
    mov edi, eax
    cmp eax, 0
    jne .print1; если нашлась 2 в 1
    mov [esp], dword str2
    mov [esp + 4], dword str1
    call strstr
    mov ebx, str2
    mov edi, eax
    cmp eax, 0
    jne .print2; если нашлась 1 во 2
    mov [esp], dword fss; если не нашлась
    mov [esp + 4], dword str1
    call printf
    jmp .end
    .print1:
        mov esi, eax
        sub esi, ebx
        mov [ebx + esi], byte 0
        mov [esp], dword fss
        mov [esp + 4], ebx
        call printf
        mov [esp], dword fsc
        mov [esp + 4], dword '['
        call printf
        mov [esp], dword fss
        mov [esp + 4], dword str2
        call printf
        mov [esp], dword fsc
        mov [esp + 4], dword ']'
        call printf
        add esp, 4
        mov [esp], dword str2
        call strlen
        add ebx, esi
        add ebx, eax
        sub esp, 4
        mov [esp], dword fss
        mov [esp + 4], ebx
        call printf
        jmp .end
    .print2:
        mov esi, eax
        sub esi, ebx
        mov [ebx + esi], byte 0
        mov [esp], dword fss
        mov [esp + 4], ebx
        call printf
        mov [esp], dword fsc
        mov [esp + 4], dword '['
        call printf
        mov [esp], dword fss
        mov [esp + 4], dword str1
        call printf
        mov [esp], dword fsc
        mov [esp + 4], dword ']'
        call printf
        mov [esp], dword str1
        call strlen
        add ebx, esi
        add ebx, eax
        mov [esp], dword fss
        mov [esp + 4], ebx
        call printf
    .end:
    xor eax, eax
    leave
    ret
    
    
