extern io_get_dec, io_print_dec, io_print_string, io_print_char
extern io_newline



global main
section .text
main:
    mov ebp, esp; for correct debugging
    call io_get_dec
    mov ebx, eax
    call io_get_dec
    imul ebx, eax
    call io_get_dec
    imul ebx, eax
    call io_get_dec
    mov ecx, eax
    xor edx, edx
    idiv ecx
   
    call io_print_dec

    xor eax, eax
    ret