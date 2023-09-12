bits 32
global start
extern exit, printf
import printf msvcrt.dll
import exit msvcrt.dll
    format db "%d", 0
segment code use32 class=code
start:
    mov eax, -14
    mov ebx, eax
    shl ebx, 1
    jc done
    shr ebx, 1
    jnc done
    shr ebx, 1
    jnc label1
    
    push eax
    push dword format
    call [printf]
    add esp, 4*2
    jmp done
    
    label1:
    neg eax
    push eax
    push dword format
    call [printf]
    add esp, 4*2
    
    done:
    push dword 0
    call [exit]
    