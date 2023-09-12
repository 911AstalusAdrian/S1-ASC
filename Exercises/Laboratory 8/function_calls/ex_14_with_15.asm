
    ;ex 14
    ;Read two numbers a and b (in base 16) from the keyboard and calculate a+b. Display the result in base 10
    
    ;ex 15
    ;Read two numbers a and b (in base 10) from the keyboard and calculate a+b. Display the result in base 16
    
bits 32
global start
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    decimal_format db "%d", 0
    hex_format db "%x", 0
    message_a db "Give a: ", 0
    message_b db "Give b: ", 0
    hex_sum db "a+b(base 16) = %d(base 10)", 13, 10, 0
    dec_sum db "a+b(base 10) = %x(base 16)", 13, 10, 0
    value_a dd 0
    value_b dd 0
segment code use32 class=code
start:

    ;ex 14
    push dword message_a
    call [printf]
    add esp, 4
    
    push dword value_a
    push dword hex_format
    call [scanf]
    add esp, 4*2
    
    push dword message_b
    call [printf]
    add esp, 4
    
    push dword value_b
    push dword hex_format
    call [scanf]
    add esp, 4*2
    
    mov eax, dword [value_a]
    add eax, dword [value_b]
    
    push dword eax
    push dword hex_sum
    call [printf]
    add esp, 4*2
    
    ;ex 15
    push dword message_a
    call [printf]
    add esp, 4
    
    push dword value_a
    push dword decimal_format
    call [scanf]
    add esp, 4*2
    
    push dword message_b
    call [printf]
    add esp, 4
    
    push dword value_b
    push dword decimal_format
    call [scanf]
    add esp, 4*2
    
    mov eax, dword [value_a]
    add eax, dword [value_b]
    
    push dword eax
    push dword dec_sum
    call [printf]
    add esp, 4*2
    push dword 0
    call [exit]