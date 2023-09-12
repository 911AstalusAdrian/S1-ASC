
 ; a+13-c+d-7+b

bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class = data
    a DB 10
    b DB 7
    e DB 13
    d DB 22
segment code use32 class= code
start:
    MOV AL, [a] ; AL = a = 10
    ADD AL, 13  ; AL = Al + 13 = 23
    SUB AL, [e] ; AL = AL - 13 = 10
    ADD AL, [d] ; AL = AL + 22 = 32
    SUB AL, 7   ; AL = AL -7 = 25
    ADD AL, [b] ; AL = AL +7 = 32
    push dword 0
    call [exit]