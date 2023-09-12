
    ;Read two numbers a and b (in base 10) from the keyboard and calculate a/b. 
    ;This value will be stored in a variable called "result" (defined in the data segment). 
    ;The values are considered in signed representation.

bits 32
global start
extern scanf, printf, exit
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    decimal_format db "%d", 0
    message_a db "Give a: ", 0
    message_b db "Give b: ", 0
    value_a dd 0
    value_b dd 0
    result dd 0
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
    cdq ; we convert EAX into EDX:EAX in the signed representation
    mov ebx, [value_b]
    idiv ebx  ;  EAX <- EDX:EAX / EBX, EDX <- EDX:EAX % EBX
    
    push dword eax
    push dword decimal_format
    call [printf]
    add esp, 4*2
    
    
    push dword 0
    call [exit]