
    ;Two natural numbers a and b (a, b: dword, defined in the data segment) are given. 
    ;Calculate their product and display the result in the following format: "<a> * <b> = <result>". 
    ;Example: "2 * 4 = 8"
    ;The values will be displayed in decimal format (base 10) with sign.
    
bits 32
global start 
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    message db "%d * %d = %d", 0
    value_a dd 13
    value_b dd -10
segment code use32 class=code
start:
    mov eax, dword [value_a]
    mov ebx, dword [value_b]
    imul ebx
    
    push dword edx
    push dword eax
    push dword [value_b]
    push dword [value_a]
    push dword message
    call [printf]
    add esp, 4*5
    
    push dword 0
    call [exit]