extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy, fscanf, fprintf, fopen, qsort, fclose

section .data
    fss db `%s`, 0
    fsc db `%c`, 0
    fsd db `%d `, 0
    infile dd 0
    outfile dd 0
    inputname db `input.txt`, 0
    outputname db `output.txt`, 0
    reads db `r`, 0
    writes db `w`, 0
    
    n dd 0
    arr times 1000 dd 0

; Миловидов 105
global main
section .text
main:
    push ebp
    mov ebp, esp
    
    and esp, 0xfffffff0; выравнивание
    sub esp, 16
    mov [esp], dword inputname; открываем файлы ввода и вывода
    mov [esp + 4], dword reads
    call fopen
    mov [infile], eax
    mov [esp], dword outputname
    mov [esp + 4], dword writes
    call fopen
    mov [outfile], eax
    
    mov ebx, 0; длина
    mov eax, [infile]
    mov [esp], eax
    mov [esp + 4], dword fsd
    mov [esp + 8], dword arr
    .c1:; считываем все числа в массив
        call fscanf
        cmp eax, -1
        je .ec1
        inc ebx
        add [esp + 8], dword 4
        jmp .c1
    .ec1:
    
    mov [esp], dword arr; сортировка
    mov [esp + 4], ebx
    mov [esp + 8], dword 4
    mov [esp + 12], dword comparator
    call qsort
    
    mov eax, [outfile]
    mov [esp], eax
    mov [esp + 4], dword fsd
    mov esi, dword arr
    .c2:
        dec ebx
        mov eax, [esi]
        mov [esp + 8], eax
        call fprintf
        cmp ebx, 0
        je .ec2
        add esi, 4
        jmp .c2
    .ec2:

    mov ecx, [infile]
    mov [esp], ecx
    call fclose
    mov ecx, [outfile]
    mov [esp], ecx
    call fclose

    xor eax, eax
    leave
    ret

comparator:; обычный компаратор
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov edx, [ebp + 12]
    mov eax, [eax]
    mov edx, [edx]
    
    cmp eax, edx
    jl .lcmp
    jg .gcmp
    
    mov eax, 0
    leave
    ret
    
    .lcmp:
    mov eax, -1
    leave
    ret
    
    .gcmp:
    mov eax, 1
    leave
    ret