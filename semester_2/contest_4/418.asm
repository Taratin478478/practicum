extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_print_hex, io_get_char, io_get_udec, io_print_udec, io_get_string, io_newline

section .data


; Миловидов 105
global main
section .text
main:
    push ebp
    mov ebp, esp
    call io_get_dec
    push eax
    call io_get_dec
    push eax
    call io_get_dec
    push eax 
    call triplemul
    
    xor eax, eax
    leave
    ret

triplemul:
    push ebp
    mov ebp, esp
    push ebx; младший
    push esi; средний
    push edi; старший
    push 0; знак
    
    ; умножение, результат в edi:esi:ebx
    mov eax, [ebp + 8]
    cmp eax, 0
    jge .s1
    neg eax
    xor [esp], dword 1
    .s1:
    mov ecx, [ebp + 12]
    cmp ecx, 0
    jge .s2
    neg ecx
    xor [esp], dword 1
    .s2:
    mul ecx
    mov ecx, [ebp + 16]
    cmp ecx, 0
    jge .s3
    neg ecx
    xor [esp], dword 1
    .s3:
    mov edi, edx
    mul ecx
    mov ebx, eax
    mov esi, edx
    mov eax, edi
    mul ecx
    add esi, eax
    mov edi, edx
    jnc .c1
    inc edi
    
    ; делим и пушим каждую цифру
    .c1:
        mov eax, edi
        xor edx, edx
        mov ecx, 10
        div ecx
        mov edi, eax
        mov eax, esi
        div ecx
        mov esi, eax
        mov eax, ebx
        div ecx
        
        mov ebx, eax
        push edx
        cmp eax, 0
        jne .c1
    .ec1:
    mov ebx, ebp
    sub ebx, 16
    mov edx, [ebx]
    cmp edx, 0
    je .c2
    mov eax, '-'
    call io_print_char
    .c2:
        pop eax
        call io_print_dec
        cmp esp, ebx
        jne .c2
    .ec2:
    
    
    mov ebx, [ebp - 4]
    mov esi, [ebp - 8]
    mov edi, [ebp - 12]
    leave
    ret