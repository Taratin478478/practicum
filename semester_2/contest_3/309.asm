extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    x1 dd 0
    y1 dd 0
    x2 dd 0
    y2 dd 0
    x3 dd 0
    y3 dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_dec
    mov [x1], eax
    call io_get_dec
    mov [y1], eax
    call io_get_dec
    mov [x2], eax
    call io_get_dec
    mov [y2], eax
    call io_get_dec
    mov [x3], eax
    call io_get_dec
    mov [y3], eax
    call io_get_dec
    call io_get_dec
    call io_get_dec
    mov ebx, eax
    call io_get_dec
    
    mov ecx, 0
    
    cmp ebx, [x1]
    je ifno
    jg f1
    dec ecx
    jmp f2
    f1:
    inc ecx
    f2:
    
    cmp ebx, [x2]
    je ifno
    jg f3
    dec ecx
    jmp f4
    f3:
    inc ecx
    f4:
    
    cmp ebx, [x3]
    je ifno
    jg f5
    dec ecx
    jmp f6
    f5:
    inc ecx
    f6:
    
    cmp ecx, 3
    je ifno
    cmp ecx, -3
    je ifno
    
    mov ecx, 0
    
    cmp eax, [y1]
    je ifno
    jg f7
    dec ecx
    jmp f8
    f7:
    inc ecx
    f8:
    
    cmp eax, [y2]
    je ifno
    jg f9
    dec ecx
    jmp f10
    f9:
    inc ecx
    f10:
    
    cmp eax, [y3]
    je ifno
    jg f11
    dec ecx
    jmp f12
    f11:
    inc ecx
    f12:
    
    cmp ecx, 3
    je ifno
    cmp ecx, -3
    je ifno
    
    mov eax, 'Y'
    call io_print_char
    mov eax, 'E'
    call io_print_char
    mov eax, 'S'
    call io_print_char
    jmp end
    ifno:
        mov eax, 'N'
        call io_print_char
        mov eax, 'O'
        call io_print_char
    end:
            
    xor eax, eax
    ret