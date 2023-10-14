extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    n1 dd 0
    n2 dd 0
    n dd 0
    count dd 0
    array times 1000000 dd 0
    m1 dd 0
    m2 dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_dec
    mov [count], eax
    dec eax
    mov [n], eax
    cmp dword [count], 0
    je ec1
    call io_get_dec
    mov [n2], eax
    dec dword [count]
    cmp dword [count], 0
    je ec1
    call io_get_dec
    mov [n1], eax
    dec dword [count]
    cmp dword [count], 0
    je ec1
    
    c1:
    call io_get_dec
    mov ebx, [n1]
    mov ecx, [n2]
    cmp ebx, eax
    jge f1
    cmp ebx, ecx
    jge f1
    mov edx, array
    mov ecx, [m1]
    mov ebx, [n]
    sub ebx, [count]
    mov [edx + 4 * ecx], ebx
    inc dword [m1]
    f1:
    mov ebx, [n1]
    mov ecx, [n2]
    cmp ebx, eax
    jle f2
    cmp ebx, ecx
    jle f2
    mov edx, array
    mov ecx, [m2]
    mov ebx, [n]
    sub ebx, [count]
    mov [edx + 4 * ecx + 500000 * 4], ebx
    inc dword [m2]
    f2:
    mov ebx, [n1]
    mov [n2], ebx
    mov [n1], eax    
    dec dword [count]
    cmp dword [count], 0
    je ec1
    jmp c1
    ec1:
      
    mov eax, [m1]
    mov ebx, eax
    mov dword [count], 0
    call io_print_dec
    call io_newline
    cmp dword [count], ebx
    je aec2
    c2:
    mov edx, array
    mov ecx, [count]
    mov eax, [edx + ecx * 4]
    call io_print_dec
    mov eax, ' '
    call io_print_char
    inc dword [count]
    cmp dword [count], ebx
    je ec2
    jmp c2
    ec2:
    call io_newline
    aec2:
    
    mov eax, [m2]
    mov ebx, eax
    mov dword [count], 0
    call io_print_dec
    call io_newline
    cmp dword [count], ebx
    je aec3
    c3:
    mov edx, array
    mov ecx, [count]
    mov eax, [edx + ecx * 4 + 500000 * 4]
    call io_print_dec
    mov eax, ' '
    call io_print_char
    inc dword [count]
    cmp dword [count], ebx
    je ec3
    jmp c3
    ec3:
    call io_newline
    aec3:
    

    
    xor eax, eax
    ret