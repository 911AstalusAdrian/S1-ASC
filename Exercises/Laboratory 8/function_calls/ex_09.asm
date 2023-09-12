    ;Read two numbers a and b (base 10) from the keyboard and calculate: (a+b)/(a-b). 
    ;The quotient will be stored in a variable called "result" (defined in the data segment). 
    ;The values are considered in signed representation.
    
bits 32
global start
extern exit, scanf, printf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    message_a db "Give a: ", 13, 10, 0
    message_b db "Give b: ", 13, 10 ,0
    decimal_format db "%d", 0
    message db "(a+b)/(a-b): %d", 0
    value_a dd 0
    value_b dd 0
segment code use32 class=code
start:
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
    
    
    mov eax, [value_a]
    sub eax, dword [value_b]
    mov ecx, eax ; we move a-b into another register so we have EAX (which will be converted into EDX:EAX) for the division
    
    mov eax, [value_a]
    add eax, dword [value_b]
    cdq ; convert dword in EAX into qword in EDX:EAX
    
    idiv ecx  ; a-b is in ECX so we divide EDX:EAX by ECX (EAX quotient, EDX remainder)
    
    push dword eax
    push dword message
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]