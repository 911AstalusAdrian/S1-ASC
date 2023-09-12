
 ; 4*4

bits 32
global start
extern exit
import exit msvcrt.dll
segment  data use32 class=data
    a dq 10h
    b equ 10
    c dw 10
    d dd -10
    e db 10b
    f dw 10101010h
segment  code use32 class=code
start:
    mov AL, 4
    mov BL, 4
    mul BL
    push dword 0
    call [exit]