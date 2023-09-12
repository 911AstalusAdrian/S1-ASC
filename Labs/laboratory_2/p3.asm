
 ; (a+b+b)+(c-d)

bits 32
global start
extern exit 
import exit msvcrt.dll
segment data use32 class = data
    a DW 4
    b DW 5
    c DW 20
    d DW 10
segment code use32 class = code
start:
    MOV AX, word [a] ; AX = 4
    ADD AX, [b]      ; AX = AX + 5 = 9
    ADD AX, [b]      ; AX = AX + 5 = 14
    MOV BX, [c]      ; BX = 20
    SUB BX, [d]      ; BX = 20 - 10 = 10
    ADD AX, BX       ; AX = AX + BX = 14 + 10 = 24
    push dword 0
    call [exit]
    
