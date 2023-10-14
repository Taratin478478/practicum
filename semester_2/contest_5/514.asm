;extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy, fscanf, fprintf, fopen, qsort, malloc, free, fclose

section .data
    fss db `%s`, 0
    fsc db `%c`, 0
    fsd db `%d `, 0
    fsu db `%u`, 0
    fsnl db `\n`, 0
    infile dd 0
    outfile dd 0
    inputname db `input.txt`, 0
    outputname db `output.txt`, 0
    reads db `r`, 0
    writes db `w`, 0
    
    n dd 0
    head dd 0; указатель на голову списка
    node dd 0
    mallocated times 4000 dd 0

; Миловидов 105
global main
section .text
main:
    push ebp
    mov ebp, esp
    and esp, 0xfffffff0
    
    sub esp, 16
    mov [esp], dword inputname; открываем файлы ввода и вывода
    mov [esp + 4], dword reads
    call fopen
    mov [infile], eax
    mov [esp], dword outputname
    mov [esp + 4], dword writes
    call fopen
    mov [outfile], eax
    
    mov [esp], dword 8; голова списка, 4 байта число и 4 байта указатель на следующую
    call malloc
    mov [eax + 4], dword 0; нулевой указатель на следующий элемент
    mov [head], eax
    mov ecx, [infile]
    mov [esp], ecx
    mov [esp + 4], dword fsd
    mov [esp + 8], dword n
    call fscanf
    cmp eax, -1
    je .end
    mov eax, [n]
    mov ebx, [head]
    mov [ebx], eax
    .c1:
        mov eax, [infile]
        mov [esp], eax
        mov [esp + 4], dword fsd
        mov [esp + 8], dword n
        call fscanf
        cmp eax, -1
        je .end
        mov [esp], dword 8; нода списка, 4 байта число и 4 байта указатель на следующую
        call malloc
        mov ecx, [n]
        mov [eax], ecx
        mov [eax + 4], dword 0; нулевой указатель на следующий элемент
        
        mov ebx, [head]
        .c2:; ищем, куда вставить новую ноду, текущий список уже отсортирован
            cmp [ebx], ecx
            jge .ec2
            mov edx, ebx
            mov ebx, [ebx + 4]
            cmp ebx, 0
            jne .c2
        .ec2:
        cmp ebx, [head]
        je .head
        mov [edx + 4], eax
        mov [eax + 4], ebx
        jmp .c1
        .head:
        mov [head], eax
        mov [eax + 4], ebx
        jmp .c1
    .ec1:
    .end:
    mov ebx, [head]
    mov eax, [outfile]
    mov [esp], eax
    mov [esp + 4], dword fsd
    .c4:; выводим список
        mov eax, [ebx]
        mov [esp + 8], eax
        call fprintf
        mov ebx, [ebx + 4]
        cmp ebx, 0
        jne .c4
    .ec4:
    
    mov ecx, [infile]
    mov [esp], ecx
    call fclose
    mov ecx, [outfile]
    mov [esp], ecx
    call fclose

    mov ebx, [head]    
    .c5:; фришим все
        mov [esp], ebx
        mov ebx, [ebx + 4]
        call free
        cmp ebx, 0
        jne .c5
    .ec5:

    xor eax, eax
    leave
    ret
    
    