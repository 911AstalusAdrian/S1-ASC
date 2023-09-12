
    ;Read two numbers a and b (in base 10) from the keyboard. 
    ;Calculate and print their arithmetic average in base 16
    
bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    decimal db "%d", 0
    message_a db "Give a: ", 0
    message_b db "Give b: ", 0
    final_message db "The arithmetic average is: %d", 0
    value_a dd 0
    value_b dd 0
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
    
    mov eax, [value_a]
    add eax, [value_b]
    cdq
    
    mov ebx, 2
    idiv ebx

    push dword eax
    push dword final_message
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]