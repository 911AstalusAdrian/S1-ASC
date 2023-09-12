
    ;Read two doublewords a and b in base 16 from the keyboard. 
    ;Display the sum of the low parts of the two numbers and the difference between the high parts of the two numbers in base 16 Example:
    ;a = 00101A35h
    ;b = 00023219h
    ;sum = 4C4Eh
    ;difference = Eh
    
bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    message_a db "Give a: ", 0
    message_b db "Give b: ", 0
    sum db "sum = %x", 13, 10, 0
    diff db "difference = %x", 13, 10, 0
    hexadecimal db "%x", 0
    value_a dd 0
    value_b dd 0
segment code use32 class=code
start:
    push dword message_a
    call [printf]
    add esp, 4
    
    push dword value_a
    push dword hexadecimal
    call [scanf]
    add esp, 4*2
    
    push dword message_b
    call [printf]
    add esp, 4
    
    push dword value_b
    push dword hexadecimal
    call [scanf]
    add esp, 4*2
    
    mov eax, [value_a]
    mov ebx, [value_b]
    
    xor edx, edx
    mov dx, ax ; we put the low word of a in dx and add the lower word of b
    add dx, bx ; our sum is stored in EDX (the sum of the two words can be more than a word)
    
    mov cl, 16 ; we rotate the values with 16 positions to get the high words in ax and bx
    shr eax, cl
    shr ebx, cl
    
    xor ecx, ecx
    mov cx, ax
    sub cx, bx
    push ecx
    
    ; PUSH ECX BEFORE CALLING A C FUNCTION (ECX might change)
    
    push dword edx
    push dword sum
    call [printf]
    add esp, 4*2
    
    pop ecx
    push dword ecx
    push dword diff
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]


