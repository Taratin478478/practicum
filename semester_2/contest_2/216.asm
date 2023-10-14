extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline

section .data
    a11 dd 0
    a12 dd 0
    a21 dd 0
    a22 dd 0
    b1 dd 0
    b2 dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_udec
    mov [a11], eax
    call io_get_udec
    mov [a12], eax
    call io_get_udec
    mov [a21], eax
    call io_get_udec
    mov [a22], eax
    call io_get_udec
    mov [b1], eax
    call io_get_udec
    mov [b2], eax
    
    mov ecx, 0
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    mov ebx, [a12]
    not ebx
    and eax, ebx
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    and eax, [a21]
    and eax, [a22]
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    and eax, [a21]
    and eax, [a22]
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    mov ebx, [a21]
    not ebx
    and eax, ebx
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    and eax, [a21]
    and eax, [a22]
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    and eax, [a21]
    and eax, [a22]
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, ecx
    call io_print_udec
    
    mov eax, ' '
    call io_print_char
    mov ecx, 0
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    mov ebx, [a12]
    not ebx
    and eax, ebx
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    mov ebx, [a12]
    not ebx
    and eax, ebx
    and eax, [a21]
    and eax, [a22]
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    mov ebx, [a21]
    not ebx
    and eax, ebx
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    and eax, [a21]
    and eax, [a22]
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    mov ebx, [a11]
    not ebx
    and eax, ebx
    and eax, [a12]
    and eax, [a21]
    and eax, [a22]
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    and eax, [a21]
    and eax, [a22]
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    mov ebx, [a12]
    not ebx
    and eax, ebx
    and eax, [a21]
    and eax, [a22]
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    mov ebx, [a21]
    not ebx
    and eax, ebx
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    mov ebx, [a21]
    not ebx
    and eax, ebx
    and eax, [a22]
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    mov ebx, [b1]
    not ebx
    and eax, ebx
    and eax, [b2]
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    and eax, [a21]
    mov ebx, [a22]
    not ebx
    and eax, ebx
    and eax, [b1]
    mov ebx, [b2]
    not ebx
    and eax, ebx
    or ecx, eax
    
    mov eax, -1
    and eax, [a11]
    and eax, [a12]
    and eax, [a21]
    and eax, [a22]
    and eax, [b1]
    and eax, [b2]
    or ecx, eax
    
    mov eax, ecx
    call io_print_udec

    
    xor eax, eax
    ret