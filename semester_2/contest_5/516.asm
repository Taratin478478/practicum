;extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy, fscanf, fprintf, fopen, qsort, malloc, free, fclose

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
    
    hashtable times 1000033 dd 0
    n dd 0
    m dd 0
    string times 101 db 0
    mallocated times 1000033 dd 0

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

    mov ecx, [infile]
    mov [esp], ecx
    mov [esp + 4], dword fsd
    mov [esp + 8], dword n
    call fscanf
    mov esi, [n]
    mov edi, hashtable
    .c1:; заполняем хэш таблицу
        
        mov [esp], dword 105; 101 для имени и 4 для ip
        call malloc
        mov ebx, eax
        mov ecx, mallocated
        mov [ecx + 4 * esi - 4], ebx; запоминаем всю выделенную память, чтобы потом зафришить
        
        mov ecx, [infile]
        mov [esp], ecx
        mov [esp + 4], dword fss
        mov [esp + 8], ebx
        call fscanf
        
        mov [esp + 4], dword fsu
        add [esp + 8], dword 101
        call fscanf
        
        mov [esp], ebx
        call hash
        mov ecx, 4
        mul ecx
        
        .c2:; ищем незанятую ячейку
            cmp [edi + eax], dword 0
            je .ec2
            add eax, 4; если ячейка занята, проверяем следующую
            xor edx, edx
            mov ecx, 4000132
            div ecx
            mov eax, edx
            jmp .c2
        .ec2:
        
        mov [edi + eax], ebx
        
        dec esi
        jnz .c1
    .ec1:
    
    ;call io_newline
    
    mov ecx, [infile]
    mov [esp], ecx    
    mov [esp + 4], dword fsd
    mov [esp + 8], dword m
    call fscanf
    mov esi, [m]
    
    .c3:
        mov ecx, [infile]
        mov [esp], ecx 
        mov [esp + 4], dword fss
        mov [esp + 8], dword string
        call fscanf; что-то не так тут p.s. пофикшено
        
        mov [esp], dword string
        call hash
        mov ecx, 4
        mul ecx

        .c4:
            cmp [edi + eax], dword 0
            je .ec4
            
            mov [esp], dword string; проверяем, равны ли строчки, иначе смотрим следущую
            mov ebx, [edi + eax]
            mov [esp + 4], ebx
            mov ebx, eax
            call strcmp; вот тут была ошибка!!!
            cmp eax, 0
            mov eax, ebx
            mov ebx, [edi + eax]
            jne .alw4
            add ebx, 101
            mov eax, [ebx]
            mov [esp + 4], dword fsu
            jmp .alw3
            
            .alw4:
            add eax, 4
            xor edx, edx
            mov ecx, 4000132
            div ecx
            mov eax, edx
            jmp .c4
        .ec4:
        mov eax, -1; если не нашли
        mov [esp + 4], dword fsd
        .alw3:
        
        
        mov ecx, [outfile]
        mov [esp], ecx
        mov [esp + 8], eax
        call fprintf
        mov [esp + 4], dword fsnl
        call fprintf
        dec esi
        jnz .c3
    .ec3:
    mov ecx, [infile]
    mov [esp], ecx
    call fclose
    mov ecx, [outfile]
    mov [esp], ecx
    call fclose
    
    mov ebx, mallocated
    .c5:; фришим все
        mov ecx, [ebx]
        cmp ecx, 0
        je .ec5
        mov [esp], ecx
        call free
        add ebx, 4
    .ec5:
    xor eax, eax
    leave
    ret
    
    
hash:; полиномиальная хэш функция 
    push ebp
    mov ebp, esp
    push ebx
    push edi
    
    mov ebx, [ebp + 8]
    mov ecx, 1
    xor edi, edi
    .ch:
        movzx eax, byte [ebx]
        cmp eax, 0
        je .ech
        mul ecx
        add edi, eax
        imul ecx, 307
        inc ebx
        jmp .ch
    .ech:
    
    mov eax, edi
    xor edx, edx
    mov ecx, 1000033 
    div ecx
    mov eax, edx
    
    ;call io_print_udec
    ;call io_newline
    
    pop edi
    pop ebx
    leave
    ret