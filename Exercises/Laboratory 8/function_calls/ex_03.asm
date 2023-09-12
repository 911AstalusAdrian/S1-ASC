
    ;Two natural numbers a and b (a, b: dword, defined in the data segment) are given. 
    ;Calculate their sum and display the result in the following format: "<a> + <b> = <result>". 
    ;Example: "1 + 2 = 3"
    ;The values will be displayed in decimal format (base 10) with sign.
    
bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    print_message db "%d + %d = %d", 0
    value_a dd 30
    value_b dd -120
segment code use32 class=code
start:
    mov eax, dword [value_a]
    mov ebx, dword [value_b]
    add eax, ebx
    
    push dword eax
    push dword [value_b]
    push dword [value_a]
    push dword print_message
    call [printf]
    add esp, 4*4
    
    push dword 0
    call [exit]
