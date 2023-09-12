
    ;ex 06
    ;Two natural numbers a and b (a: dword, b: dword, defined in the data segment) are given. Calculate a/b and display the quotient in the following format: "<a>/<b> = <quotient>". Example: for a = 200, b = 5 it will display: "200/5 = 40".
    ;The values will be displayed in decimal format (base 10) with sign.
    ;ex 07
    ;Two natural numbers a and b (a: dword, b: dword, defined in the data segment) are given. Calculate a/b and display the remainder in the following format: "<a> mod <b> = <remainder>". Example: for a = 23, b = 5 it will display: "23 mod 5 = 3".
    ;The values will be displayed in decimal format (base 10) with sign.

bits 32 
global start
extern exit, printf
import printf msvcrt.dll
import exit msvcrt.dll
segment data use32 class=data
    quotient_message db "%d / %d = %d", 13, 10, 0
    remainder_message db "%d mod %d = %d", 0
    value_a dd 244
    value_b dd 12
segment code use32 class=code
start:
    mov eax, [value_a]
    cdq
    mov ebx, [value_b]
    idiv ebx
    ; EAX  quotient, EDX remainder
    
    pushad ; We push the registers on the stack so their values can be restored
    
    push dword eax
    push dword [value_b]
    push dword [value_a]
    push dword quotient_message
    call [printf]
    add esp, 4*4
    
    popad ; We pop back the registers with their initial values
    
    push dword edx
    push dword [value_b]
    push dword [value_a]
    push dword remainder_message
    call [printf]
    add esp, 4*4
    push dword 0
    call [exit]
