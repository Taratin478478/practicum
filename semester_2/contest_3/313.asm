extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec, io_newline

section .data
    n dd 0
    i dd 0
    k dd 0
    a times 1000000 dd 0
    

global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_udec
    cmp eax, 0
    je ec3
    mov [n], eax
    mov ebx, eax
    
    c1:  
        call io_get_udec
        mov edx, a
        mov ecx, [i]
        mov [edx + ecx * 4], eax
        
        inc dword [i]
        cmp [i], ebx
        je ec1
        jmp c1
    ec1:
    
    call io_get_udec
    cmp eax, 0
    je kz
    mov [k], eax
    mov edx, a
    mov ecx, [i]
    dec ecx
    mov ebx, [edx + ecx * 4]
    mov ecx, 32
    sub ecx, [k]
    shl ebx, cl
    mov ecx, [k]
    mov eax, [edx]
    shr eax, cl
    or eax, ebx
    call io_print_udec
    mov [i], dword 1
    mov ecx, [n]
    cmp ecx, 1
    je ec2
    
    c2: 
        mov eax, ' '
        call io_print_char
        mov edx, a
        mov ecx, [i]
        mov eax, [edx + 4 * ecx]
        dec ecx
        mov ebx, [edx + 4 * ecx]
        mov ecx, [k]
        shr eax, cl
        mov ecx, 32
        sub ecx, [k]
        shl ebx, cl
        or eax, ebx
        call io_print_udec
        
        inc dword [i]
        mov edx, [n]
        cmp [i], edx
        je ec2
        jmp c2
    ec2:
    
    jmp ec3
    kz:
    mov [i], dword 0
    c3:
        mov edx, a
        mov ecx, [i]
        mov eax, [edx + ecx * 4]
        call io_print_udec
        mov eax, ' '
        call io_print_char
        
        inc dword [i]
        mov edx, [n]
        cmp [i], edx
        je ec3
        jmp c3
    ec3:    
    xor eax, eax
    ret