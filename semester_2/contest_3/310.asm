extern io_get_dec, io_print_dec, io_print_string, io_print_char, io_get_hex, io_get_char, io_get_udec, io_print_udec
extern io_newline
    

section .data
    n dd 0
    r dd 0

global main
section .text
main:
    mov ebp, esp; for correct debugging
    
    call io_get_udec
    mov ebx, eax
    mov ecx, 2
    c:  
        mov eax, ebx
        xor edx, edx
        div ecx
        cmp edx, 0
        je ec
        cmp ecx, 31624
        mov eax, 1
        je ec
        inc ecx
        jmp c
    ec:
    call io_print_udec
            
    xor eax, eax
    ret