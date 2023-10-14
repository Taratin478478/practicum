extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline


global main
section .text
main:
    mov ebp, esp; for correct debugging
  
    call io_get_dec
    mov ebx, eax
    mov ecx, ebx
    shr ecx, 31
    not eax
    inc eax
    mul ecx
    xor ecx, 1
    xchg eax, ebx
    mul ecx
    add eax, ebx
    call io_print_dec
    
    xor eax, eax
    ret