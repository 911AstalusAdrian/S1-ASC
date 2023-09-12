; a*a-(e+f)
; a - byte
; e,f - word
bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class = data
    a DB 30
    e DW 420
    f DW 155
segment code use32 class= code
start:
    ; The result will be in AX
    mov AL, [a] ; AL = a = 30
    mov BL, [a] ; BL = a = 30
    mul BL      ; We multiply the value in AL with the one in BL
    ; AX = AL*BL = 30*30 = 900
    mov CX, [e] ; CX = e = 420
    add CX, [f] ; CX = CL + f = 420 + 155 = 575
    sub AX, CX  ; AX = AX - CX = 900 - 575 = 325
    push dword 0
    call [exit]