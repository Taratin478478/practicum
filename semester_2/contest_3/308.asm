extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    n dd 0
    m dd 0
    k dd 0
    i1 dd 0
    i2 dd 0
    i3 dd 0
    a times 10000 dd 0
    b times 10000 dd 0
    c times 10000 dd 0

global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_dec
    mov [n], eax
    call io_get_dec
    mov [m], eax
    call io_get_dec
    mov [k], eax
    
    c1:
        mov [i2], dword 0
        c2:
            call io_get_dec
            mov ebx, [i1]
            imul ebx, 100
            add ebx, [i2]
            mov edx, a
            mov [edx + ebx * 4], eax
            mov ecx, [i2]
            inc ecx
            cmp ecx, [m]
            je ec2
            mov [i2], ecx
            jmp c2
        ec2:
        mov ecx, [i1]
        inc ecx
        cmp ecx, [n]
        je ec1
        mov [i1], ecx
        jmp c1
    ec1:
    
    mov [i1], dword 0
    c3:
        mov [i2], dword 0
        c4:
            call io_get_dec
            mov ebx, [i1]
            imul ebx, 100
            add ebx, [i2]
            mov edx, b
            mov [edx + ebx * 4], eax
            mov ecx, [i2]
            inc ecx
            cmp ecx, [k]
            je ec4
            mov [i2], ecx
            jmp c4
        ec4:
        mov ecx, [i1]
        inc ecx
        cmp ecx, [m]
        je ec3
        mov [i1], ecx
        jmp c3
    ec3:  
    
    mov [i1], dword 0
    c5:
        mov [i2], dword 0
        c6:
            mov [i3], dword 0
            c7:
                mov ebx, [i1]
                imul ebx, 100
                add ebx, [i3]
                mov edx, a
                mov eax, [edx + ebx * 4]
                mov ebx, [i3]
                imul ebx, 100
                add ebx, [i2]
                mov edx, b
                imul eax, [edx + ebx * 4]
                mov ebx, [i1]
                imul ebx, 100
                add ebx, [i2]
                mov edx, c
                add [edx + ebx * 4], eax
                
                mov ecx, [i3]
                inc ecx
                cmp ecx, [m]
                je ec7
                mov [i3], ecx
                jmp c7
            ec7:
            mov ebx, [i1]
            imul ebx, 100
            add ebx, [i2]
            mov edx, c
            mov eax, [edx + ebx * 4]
            call io_print_dec
            mov eax, ' '
            call io_print_char
            
            mov ecx, [i2]
            inc ecx
            cmp ecx, [k]
            je ec6
            mov [i2], ecx
            jmp c6
        ec6:
        call io_newline
        mov ecx, [i1]
        inc ecx
        cmp ecx, [n]
        je ec5
        mov [i1], ecx
        jmp c5
    ec5: 
            
    xor eax, eax
    ret