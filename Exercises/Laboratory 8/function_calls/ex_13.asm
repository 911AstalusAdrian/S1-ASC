
    ;Read two numbers a and b (base 10) from the keyboard and calculate: (a+b)*(a-b). 
    ;The result of multiplication will be stored in a variable called "result" (defined in the data segment).
    
bits 32
global start
extern exit, scanf, printf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    decimal db "%d", 0
    message_a db "Give a: ", 0
    message_b db "Give b: ", 0
    message_result db "(a+b)*(a-b): %d: ", 0
    value_a dd 0
    value_b dd 0
    result dq 0
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
    push dword decimal
    call [scanf]
    add esp, 4*2
    
    ; we compute a+b in EAX, which will be multiplied with (a-b)
    mov eax, dword [value_a]
    add eax, dword [value_b]
    
    ; a-b is computed in EBX
    mov ebx, dword [value_a]
    sub ebx, dword [value_b]
    
    imul EBX; EDX:EAX <- EAX*EBX
    
    ; We put EDX:EAX into the qword 'result'
    mov dword [result], eax
    mov dword [result+4], edx
    
    push dword [result+4]
    push dword [result]
    push dword message_result
    call [printf]
    add esp, 4*3
    push dword 0
    call [exit]