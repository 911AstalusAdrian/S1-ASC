
    ; c-a-(b+a)+c
    ; a - byte
    ; b - word
    ; c - dword

bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class = data
    a DB 10
    b DW 50
    c DD 200
segment code use32 class= code
start:

    ; the final result is stored in the ECX register

    mov al, byte [a] ; moving the byte in the AL register
    mov ah, 0; making the AH register 0, so AX can have the value of the byte a (AX <- 10)
    mov bx, word [b] ; moving the word in the BX register (BX <- 50)
    add bx, ax ; adding the byte in AX to the word in BX (BX <- a+b = 60)
   
    mov ecx, dword [c]  ; moving the dword in the ECX register (ECX <- 200)
    mov edx, 0 ; EDX <- 0
    mov dx, bx ; DX <- BX = 60  => EDX <- 60
    mov eax, 0 ; EAX <- 0
    mov al, byte [a] ; AL <- 10  => EAX <- 10
    sub ecx, eax ; ECX <- ECX - EAX = 190
    sub ecx, edx ; ECX <- ECX - EDX = 130
    mov eax, dword [c] ; EAX <- 200
    add ecx ,eax ; ECX <- ECX + EAX = 330
    push dword 0
    call [exit]