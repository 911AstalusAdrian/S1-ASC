
    ;Read a decimal number and a hexadecimal number from the keyboard. 
    ;Display the number of 1's of the sum of the two numbers in decimal format. 
    ;Example:   a = 32 = 0010 0000b
    ;           b = 1Ah = 0001 1010b
    ;           32 + 1Ah = 0011 1010b
    ;The value printed on the screen will be 4
    
bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    decimal db "%d", 0
    hex db "%x", 0
    message_a db "Give a, in decimal: ", 0
    message_b db "Give b, in hexadecimal: ", 0
    value_a dd 0
    value_b dd 0
segment code use32 class=code
start:
    push dword message_a
    call [printf]
    add esp, 4
    
    push dword value_a
    push dword decimal
    call [scanf]
    add esp, 4*2
    
    push dword message_b
    call [printf]
    add esp, 4
    
    push dword value_b
    push dword hex
    call [scanf]
    add esp, 4*2
    
    ; a+b will be in eax
    mov eax, [value_a]
    add eax, [value_b]
    
    xor ebx, ebx ; the number of 1 bits will be stored in EBX
    mov ecx, 31 ; a dword has 32 bits (from 0 to 31) we use ECX to create a loop
    each_bit:
        mov edx, eax
        and edx, 1b
        cmp edx, 1b ; we check if the last bit of eax is one
        jnz not_one
        inc ebx
        not_one:
        shr eax, 1
    loop each_bit
    
    push dword ebx
    push dword decimal
    call [printf]
    add esp, 4*2
    push dword 0
    call [exit]