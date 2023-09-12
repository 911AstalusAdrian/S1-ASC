
    ;Two natural numbers a and b (a, b: dword, defined in the data segment) are given. 
    ;Calculate a/b and display the quotient and the remainder in the following format: 
    ;"Quotient = <quotient>, remainder = <remainder>". 
    ;Example: for a = 23, b = 10 it will display: "Quotient = 2, remainder = 3".
    ;The values will be displayed in decimal format (base 10) with sign.
    
bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    message db "Quotient = %d, remaninder = %d", 0
    value_a dd 135
    value_b dd 10
segment code use32 class=code
start:
    mov eax, [value_a]
    cdq ; EAX gets extended to EDX:EAX in the signed representation
    mov ebx, [value_b]
    idiv ebx ; EAX <- quotient, EDX <- remainder
    
    push dword edx
    push dword eax
    push dword message
    call [printf]
    add esp, 4*3
    
    push dword 0
    call [exit]