extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy, fscanf, fprintf, fopen, qsort, malloc, free, fclose, strlen, fread, fseek, ftell, realloc

section .data
    fss db `%s`, 0
    fsc db `%c`, 0
    fsd db `%d`, 0
    fsu db `%u`, 0
    fsnl db `\n`, 0
    infile dd 0
    outfile dd 0
    binname db `data.in`, 0
    inputname db `input.txt`, 0
    strangename db `data.in`, 0
    outputname db `output.txt`, 0
    reads db `r`, 0
    readbins db `rb`, 0
    writes db `w`, 0
    seekend db `SEEK_END`, 0
    seekset db `SEEK_SET`, 0
    
    n dd 0

; Миловидов 105
global main
section .text
main:
    push ebp
    mov ebp, esp
    and esp, 0xfffffff0
    sub esp, 16
    
    mov esi, 0
    mov edi, 4
    mov [esp], dword 4
    call malloc
    mov ebx, eax
    
    mov [esp], dword fsu
    .c1:
        lea eax, [ebx + esi]
        mov [esp + 4], eax
        call scanf
        lea eax, [ebx + esi]
        cmp [eax], dword 0
        je .ec1
        add esi, 4
        cmp esi, edi
        jne .c1
        imul edi, 2
        mov [esp], ebx
        mov [esp + 4], edi
        call realloc
        mov ebx, eax
        mov [esp], dword fsu
        jmp .c1
    .ec1:
    xor eax, eax
    sub esi, 4
    jz .ec2
    mov edi, [ebx + esi]
    .c2:
        sub esi, 4
        cmp [ebx + esi], edi
        jnl .l
        inc eax
        .l:
        test esi, esi
        jnz .c2
    .ec2:
    mov [esp], dword fsu
    mov [esp + 4], eax
    call printf
    mov [esp], ebx
    call free
    xor eax, eax
    leave
    ret
    
    
