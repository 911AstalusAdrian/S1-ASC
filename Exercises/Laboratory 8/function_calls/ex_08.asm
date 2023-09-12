
    ;A natural number a (a: dword, defined in the data segment) is given. 
    ;Read a natural number b from the keyboard and calculate: a + a/b. Display the result of this operation. 
    ;The values will be displayed in decimal format (base 10) with sign.

bits 32
global start
extern exit, scanf, printf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    message_a db "a = %d", 13, 10, 0
    message_b db "give b: ", 0
    message db "a + a/b: %d", 0
    decimal_format db "%d", 0
    value_a dd -542
    value_b dd 0
segment code use32 class=code
start:
    push dword [value_a]
    push dword message_a
    call [printf]
    add esp, 4*2

    push dword message_b
    call [printf]
    add esp, 4
    
    push dword value_b
    push dword decimal_format
    call [scanf]
    add esp, 4*2
    
    mov eax, [value_a]
    cdq ; convert value_a into a qword
    mov ebx, [value_b]
    idiv ebx
    ; a/b will be now stored in EAX
    add eax, [value_a]
    
    push dword eax
    push dword message
    call [printf]
    add esp, 4*2
    push dword 0
    call [exit]