extern io_newline, io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec, io_print_hex

section .data
    a dd 0
    b dd 0
    c dd 0


global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    xor ebx, ebx
    
    call io_get_hex
    mov [a], eax
    call io_get_hex
    mov [b], eax
    call io_get_hex
    mov [c], eax
    
    mov eax, [a]
    mov ebx, [c]
    and eax, ebx
    mov ecx, [b]
    not ebx
    and ecx, ebx
    add eax, ecx
    
    
    call io_print_hex

    xor eax, eax
    ret