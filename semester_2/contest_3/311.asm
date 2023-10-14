extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec, io_newline


global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_udec
    mov ebx, eax
    call io_get_udec
    cmp eax, ebx
    jge c
    xchg eax, ebx
    c:  
        xor edx, edx
        div ebx
        mov eax, ebx
        mov ebx, edx
        cmp ebx, 0
        je ec
        jmp c
    ec:
    call io_print_udec
            
    xor eax, eax
    ret