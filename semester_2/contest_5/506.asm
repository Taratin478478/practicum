extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline
extern scanf, printf, strstr, strcmp, strcpy, fscanf, fprintf, fopen, qsort, malloc, free, fclose, strlen, fread, fseek, ftell, realloc, fwrite

section .data
    fss db `%s`, 0
    fsc db `%c`, 0
    fsd db `%d`, 0
    fsu db `%u`, 0
    fsnl db `\n`, 0
    infile dd 0
    outfile dd 0
    bininname db `input.bin`, 0
    binoutname db `output.bin`, 0
    inputname db `input.txt`, 0
    strangename db `data.in`, 0
    outputname db `output.txt`, 0
    reads db `r`, 0
    readbins db `rb`, 0
    writes db `w`, 0
    writebins db `wb`, 0
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
    
    mov [esp], dword bininname
    mov [esp + 4], dword readbins
    call fopen
    mov [infile], eax
    mov [esp], dword binoutname
    mov [esp + 4], dword writebins
    call fopen
    mov [outfile], eax
    mov [esp], dword 4
    call malloc
    mov ebx, eax; массив
    mov [esp], edi
    mov [esp + 4], dword 4
    mov [esp + 8], dword 1
    mov eax, [infile]
    mov [esp + 12], eax
    mov esi, 0
    mov edi, 4
    .c1:
        lea eax, [ebx + esi]
        mov [esp], eax
        call fread
        test eax, eax
        jz .ec1
        add esi, 4
        cmp esi, edi
        jne .c1
        imul edi, 2
        mov [esp], ebx
        mov [esp + 4], edi
        call realloc
        mov ebx, eax
        mov [esp + 4], dword 4
        mov [esp + 8], dword 1
        mov eax, [infile]
        mov [esp + 12], eax
        jmp .c1
    .ec1:
    
    mov [esp], dword n
    mov eax, [outfile]
    mov [esp + 12], eax
    lea edi, [ebx + esi]
    xor esi, esi
    
    .c2:; проверка на неубывающую пирамиду
        lea eax, [ebx + 2 * esi + 4]
        cmp eax, edi
        je .ec2
        mov ecx, [ebx + esi]
        cmp [eax], ecx
        jl .p 
        add eax, 4
        cmp eax, edi
        je .ec2
        cmp [eax], ecx
        jl .p
        add esi, 4
        jmp .c2
    .ec2:
        mov [n], dword 1
        jmp .end
    .p:
    xor esi, esi
    .c3:; проверка на невозрастающую пирамиду
        lea eax, [ebx + 2 * esi + 4]
        cmp eax, edi
        je .ec3
        mov ecx, [ebx + esi]
        cmp [eax], ecx
        jg .n 
        add eax, 4
        cmp eax, edi
        je .ec3
        cmp [eax], ecx
        jg .n
        add esi, 4
        jmp .c3
    .ec3:
        mov [n], dword -1
        jmp .end
    .n:
        mov [n], dword 0
    .end:
    call fwrite
    mov [esp], ebx
    call free
    xor eax, eax
    leave
    ret
    
    
    
