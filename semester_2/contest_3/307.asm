extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec, io_newline

section .data
    a times 10000 dd 0
    n dd 0
    
global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_dec
    mov [n], eax
    cmp eax, 1
    jne f
    call io_get_dec
    call io_print_dec
    jmp ec4
    f:
    mov ebx, 0
    
    
    c1:
        call io_get_dec
        mov [a + ebx * 4], eax
        inc ebx
        cmp ebx, [n]
        jne c1
    ec1:
    
    mov ecx, [n]
    dec ecx
    c2:
        mov ebx, 0 
        c3:
            mov eax, [a + ebx * 4]
            mov edx, [a + ebx * 4 + 4]
            cmp eax, edx
            jl l

            mov [a + ebx * 4 + 4], eax
            mov [a + ebx * 4], edx
            l:
            inc ebx
            cmp ebx, ecx
            jl c3
        ec3:
        dec ecx
        cmp ecx, 0
        jne c2
    ec2:
        
    mov ebx, 0
    
    c4:
        mov eax, [a + ebx * 4]
        call io_print_dec
        mov eax, ' '
        call io_print_char
        inc ebx
        cmp ebx, [n]
        jne c4
    ec4:
    
    xor eax, eax
    ret