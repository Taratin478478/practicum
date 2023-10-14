extern io_get_dec, io_print_dec, io_print_string, io_print_char
extern io_newline




global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_dec
    dec eax
    mov ebx, eax
    imul ebx, 41
    mov ecx, 2
    xor edx, edx
    div ecx
    add ebx, eax
    call io_get_dec
    add eax, ebx
    call io_print_dec

    xor eax, eax
    ret