extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec, io_newline

section .data
    n dd 0
    k dd 0
    r dd 1
    t dd 0
    a dd 0
    f dd 1

global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_udec
    cmp eax, 0
    jne ne
    mov [r], dword 0
    jmp ec3
    ne:
    mov [n], eax
    call io_get_udec
    mov [k], eax
    mov ecx, 31
    c1:
        mov eax, [n]
        shr eax, cl
        jnz ec1
        jecxz ec1
        dec ecx
        jmp c1
    ec1:
    mov [t], ecx
    
    dec ecx
    cmp ecx, [k]
    je ec2
    jg norm
    mov [r], dword 0
    jmp ec2
    norm:
    mov eax, 1; prev c
    mov ecx, [k]; n
    inc ecx
    c2:
        mul ecx
        mov ebx, ecx
        sub ebx, [k]
        div ebx
        add [r], eax
        inc ecx
        cmp ecx, [t]
        je ec2
        jmp c2 
    ec2:

    c3:
        dec dword [t]
        mov ecx, [t]
        mov edx, 1
        shl edx, cl
        mov eax, [n]
        and eax, edx
        shr eax, cl
        jz ifz

        mov ecx, [k]
        sub ecx, [t]
        cmp ecx, 1
        jg ec3
        
        
        mov eax, [t]; C из t по k - 1
        mov ecx, 1
        
        mov ebx, [k]
        cmp [t], dword 0
        jne p0
        cmp ebx, 0
        jl ec3
        cmp ebx, 1
        jg ec3
        inc dword [r]
        jmp ec3
        p0:
        cmp ebx, dword 0
        jl ec3
        jne p3
        mov eax, 0
        jmp ec4
        p3:
        dec ebx
        cmp ebx, 0
        jne p1
        mov eax, 1
        jmp ec4
        p1:
        cmp ebx, 1
        jne p2
        mov eax, [t]
        cmp eax, 0
        jne ec4
        inc eax
        jmp ec4
        p2:
        cmp ebx, [t]
        jne c4
        mov eax, 1
        jmp ec4        
        c4:
            mov ebx, [t]
            sub ebx, ecx
            mul ebx
            inc ecx
            div ecx
            inc ecx
            cmp ecx, [k]
            jge ec4
            dec ecx
            jmp c4
        ec4:
        add [r], eax
        jmp alw
        ifz:
        dec dword [k]
        cmp [k], dword 0
        jne alw
        cmp [t], dword 0
        jne alw
        inc dword [r]
        jmp ec3
        alw:

        mov eax, [t]
        cmp eax, 0
        jne c3
    ec3:
    mov eax, [r]

    call io_print_udec
    
    xor eax, eax
    ret