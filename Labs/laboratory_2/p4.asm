
    ; (a+b)/2 + (10-a/c)+b/4

bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class = data
    a DB 20
    b DB 100
    c DB 150
segment code use32 class= code
start:
    ; The result will be stored in CL

    ; (a+b)/2

    MOV AL, [a] ; AL = a = 20
    ADD AL, [b] ; AL = AL + b = 120
    MOV AH, 0   ; We put 0 in AH so that AX will have the same value as AL
    MOV BL, 2   ; BL = 2
    DIV BL      ; We divide AX by BL (which is 2)
    ; AL = AX/BL = 60, AH = AX%BL = 0
    MOV CL, AL  ; CL = AL = 60
    
    ; b/4
    
    MOV AL, [b] ; AL = b = 100
    MOV AH, 0   ; AH is 0 so AX will have the same value as AL (100)
    MOV BL, 4   ; BL = 4
    DIV BL      ; We divide AX by BL (which is 4)
    ; AL = AX/BL = 25, AH = AX%BL = 0
    ADD CL, AL  ; CL = CL + AL = 60 + 25 = 85
    ; CL = (a+b)/2 + b/4
    
    ; 10-a/c
    
    MOV AL, [a] ; AL = a = 20
    MOV AH, 0   ; AH = 0, then AX = 20
    MOV BL, [c] ; BL = c = 150
    DIV BL      ; We divide AX by BL (which is 150)
    ; AL = AX/BL = 0, AH = AX%BL = 20
    MOV BL, 10  ; BL = 10
    SUB BL, AL  ; BL = BL - AL = 10 - 0 = 10
    ADD CL, BL  ; CL = CL + BL = 85 + 10 = 95
    ;(a+b)/2 + (10-a/c)+b/4
    push dword 0
    call [exit]