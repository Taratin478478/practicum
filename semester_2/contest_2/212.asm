extern io_get_dec, io_print_dec, io_print_string, io_print_char
extern io_newline


section .data
    ace db 0
    king db 0
    queen db 0
    jack db 0
    ten db 0
    number db 0
    spade db 0
    club db 0
    diamond db 0
    heart db 0


global main
section .text
main:
    mov ebp, esp; for correct debugging

    call io_get_dec
    dec eax
    mov ecx, 13
    xor edx, edx
    div ecx
    mov ebx, eax 
    
    cmp ebx, 0; Определяем масть
    lahf
    shr ah, 6
    and ah, 1
    mov [spade], ah
    cmp ebx, 1
    lahf
    shr ah, 6
    and ah, 1
    mov [club], ah
    cmp ebx, 2
    lahf
    shr ah, 6
    and ah, 1
    mov [diamond], ah 
    cmp ebx, 3
    lahf
    shr ah, 6
    and ah, 1
    mov [heart], ah 
    
    cmp edx, 8; Определяем достоинство
    lahf
    and ah, 1
    mov [number], ah
    cmp edx, 8
    lahf
    shr ah, 6
    and ah, 1
    mov [ten], ah
    cmp edx, 9
    lahf
    shr ah, 6
    and ah, 1
    mov [jack], ah
    cmp edx, 10
    lahf
    shr ah, 6
    and ah, 1
    mov [queen], ah
    cmp edx, 11
    lahf
    shr ah, 6
    and ah, 1
    mov [king], ah
    cmp edx, 12
    lahf
    shr ah, 6
    and ah, 1
    mov [ace], ah
    
    add edx, 50
    mov eax, [number]
    imul eax, edx
    mov edx, [ten]
    imul edx, 'T'
    add eax, edx
    mov edx, [jack]
    imul edx, 'J'
    add eax, edx
    mov edx, [queen]
    imul edx, 'Q'
    add eax, edx
    mov edx, [king]
    imul edx, 'K'
    add eax, edx
    mov edx, [ace]
    imul edx, 'A'
    add eax, edx
    call io_print_char
    
    mov eax, [spade]
    imul eax, 'S'
    mov edx, [club]
    imul edx, 'C'
    add eax, edx
    mov edx, [diamond]
    imul edx, 'D'
    add eax, edx
    mov edx, [heart]
    imul edx, 'H'
    add eax, edx
    call io_print_char

    xor eax, eax
    ret