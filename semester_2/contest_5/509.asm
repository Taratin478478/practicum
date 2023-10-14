extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy, fscanf, fprintf, fopen, qsort, malloc, free

section .data
    fss db `%s`, 0
    fsc db `%c`, 0
    fsd db `%d `, 0
    fsnl db `\n`, 0
    infile dd 0
    outfile dd 0
    inputname db `input.txt`, 0
    outputname db `output.txt`, 0
    reads db `r`, 0
    writes db `w`, 0
    
    n dd 0
    size dd 0
    trace1 dd 0; младший
    trace2 dd 0; старший
    maxtrace1 dd 0
    maxtrace2 dd 0x80000000; min signed ll
    matrix dd 0
    ressize dd 0

; Миловидов 105
global main
section .text
main:
    push ebp
    mov ebp, esp
    
    and esp, 0xfffffff0; выравнивание
    sub esp, 16
    
    mov [esp], dword fsd
    mov [esp + 4], dword n
    call scanf; число матриц
    
    .c1:
        mov [esp], dword fsd
        mov [esp + 4], dword size
        call scanf; размер матрицы
        mov eax, [size]
        mul eax
        mov ecx, 4
        mul ecx
        mov [esp], eax; размер памяти для матрицы
        call malloc; выделяем память под матрицу
        mov ebx, eax
        
        mov edi, 0; номер строки
        mov [trace1], dword 0; след
        mov [trace2], dword 0
        mov [esp], dword fsd
        
        .c2:
            mov esi, 0; номер столбца
            .c3:
                mov eax, edi; вычисляем адрес следующего элемента
                mul dword [size]
                add eax, esi
                mov ecx, 4
                mul ecx
                add eax, ebx
                
                mov [esp + 4], eax
                call scanf
                
                cmp esi, edi; проверяем, лежит ли элемент на диагонали
                jne .endtrace
                
                mov ecx, [esp + 4]
                mov eax, [ecx]
                cdq
                add [trace1], eax; добавляем к следу
                adc [trace2], edx
                
                .endtrace:
                
                inc esi
                cmp esi, [size]
                jne .c3
            .ec3:
            inc edi
            cmp edi, [size]
            jne .c2
        .ec2:
        
        mov eax, [trace2]
        cmp eax, [maxtrace2]; сравниваем след с текущим максимальным
        jl .notgreater
        jg .greater
        mov eax, [trace1]
        cmp eax, [maxtrace1]
        jbe .notgreater
        
        .greater:
        mov eax, [trace1]
        mov [maxtrace1], eax
        mov eax, [trace2]
        mov [maxtrace2], eax
        mov [matrix], ebx
        mov eax, [size]
        mov [ressize], eax
        
        .notgreater:
        
        dec dword [n]
        jnz .c1
    .ec1:
    
    mov ebx, [matrix]; выводим матрицу
    mov edi, 0
    .c4:
        mov esi, 0
        mov [esp], dword fsd
        .c5:
            mov eax, edi; вычисляем адрес следующего элемента
            mul dword [ressize]
            add eax, esi
            mov ecx, 4
            mul ecx
            add eax, ebx
            
            mov ecx, [eax]
            mov [esp + 4], ecx
            call printf
            
            inc esi
            cmp esi, [ressize]
            jne .c5
        .ec5:
        mov [esp], dword fsnl
        call printf
        inc edi
        cmp edi, [ressize]
        jne .c4
    .ec4:
    mov [esp], ebx
    call free
    
    xor eax, eax
    leave
    ret