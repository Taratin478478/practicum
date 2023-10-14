;extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy, fscanf, fprintf, fopen, qsort, malloc, free, fclose, strlen, fread, fseek, ftell

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
    
    mov [esp], dword strangename; открываем файлы ввода и вывода
    mov [esp + 4], dword reads
    call fopen
    mov ebx, eax
    
    mov [esp], ebx
    mov [esp + 4], dword fsu
    mov [esp + 8], dword n
    mov esi, -1
    .c:
        inc esi
        call fscanf
        cmp eax, -1
        jne .c
    .ec:
    
    mov [esp], dword fsu
    mov [esp + 4], esi
    call printf
    
    .end:
    xor eax, eax
    leave
    ret