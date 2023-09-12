; (d-a)-(a-c)-d  - Unsigned
    ; a - byte, c - double word, d - qword

bits 32 
global start
extern exit
import exit msvcrt.dll
segment data use32 class = data
    a DB 150
    c DD 3550
    d DQ 25650
segment code use32 class = code
start:
    ; final result stored in ECX:EBX
    
    mov ebx, dword [d] ; moving the firs part of the qword into the EBX register
    mov ecx, dword [d+4] ; moving the second part of the qword into the ECX register
    ; ECX:EBX <- d qword
    ; moving the byte a into the eax register, which we then convert it into a qword (EDX:EAX)
    mov eax, 0
    mov al, [a]
    cdq
    ; ECX:EBX <- ECX:EBX - EDX:EAX = 25500
    sub ebx, eax
    sbb ecx, edx
    mov eax, 0  ; reinitialising the eax register to 0
    mov al, [a]
    sbb eax, dword [c] ; a-c = -3400
    cdq ; converting the eax register into a qword (EDX:EAX <- -3400
    ; ECX:EBX <- ECX:EBX - EDX:EAX = 25500 - (-3400) = 28900
    sub ebx, eax
    sbb ecx, edx
    ; ECX:EBX - dword d = 28900 - 25650 = 3250
    sub ebx, dword[d]
    sbb ecx, dword[d+4]
    push dword 0
    call [exit]