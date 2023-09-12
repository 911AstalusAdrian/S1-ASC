
    ; Read two numbers a and b (in base 10) from the keyboard and calculate their product. 
    ; This value will be stored in a variable called "result" (defined in the data segment).

bits 32
extern printf, exit, scanf
import printf msvcrt.dll
import scanf msvcrt.dll
import exit msvcrt.dll
global start
segment data use32 class=data
    decimal_format db "%d", 0
    message_a db "Read a: ", 0
    message_b db "Read b: ", 0
    message_product db "The product a*b is: ", 13, 10
    result dd 0
    number_a dw 0
    number_b dw 0
segment code use32 class=code
start:
    ;We print a message for the first number
    push dword message_a
    call [printf]
    add esp, 4
    
    ;We call scanf to read the number from the keyboard
    push dword number_a
    push dword decimal_format
    call [scanf]
    add esp, 4*2
    
    ; We do the same things for the second number
    push dword message_b
    call [printf]
    add esp, 4
    
    push dword number_b
    push dword decimal_format
    call [scanf]
    add esp, 4*2
    
    mov eax, 0
    mov ax, [number_a]
    mov ebx, 0
    mov bx, [number_b]

    mul bx
    ; DX:AX <- a*b

    push dx
    push ax
    pop eax
    mov [result], eax
    
    ;push decimal_format
    push dword [result]
    push decimal_format
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]
    
    