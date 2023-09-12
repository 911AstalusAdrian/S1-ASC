
    ;A negative number a (a: dword) is given. 
    ;Display the value of that number in base 10 and in the base 16 in the following format: 
    ;"a = <base_10> (base 10), a = <base_16> (base 16)"
    
bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    message db "a= %d(base 10), a= %x(base 16)", 0
    dec_format db "%d", 0
    our_value dd 0
segment code use32 class=code
start:
    
    push dword our_value
    push dword dec_format
    call [scanf]
    add esp, 4*2 
    
    push dword [our_value]
    push dword [our_value]
    push dword message
    call [printf]
    add esp, 4*3
    push dword 0
    call [exit]