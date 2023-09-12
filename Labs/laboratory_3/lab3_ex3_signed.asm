
    ; x/2+100*(a+b)-3/(c+d)+e*e
    ; a,c-word
    ; b,d-byte
    ; e-doubleword
    ; x-qword

bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class = data
    a DW 25
    c DW 1
    b DB -32
    d DB 1
    e DD 210
    x DQ 3456
segment code use32 class= code
start:
    ; the result will be stored in EDX:EAX
    ; x/2
    ; x is a qword, so we put it into EDX:EAX
    mov EAX, dword [x] ; Lower part of x in EAX
    mov EDX, dword [x+4] ; Higher part of x in EDX 
    mov EBX, 2 ; 2 in EBX so we can divide EDX:EAX by 2
    idiv EBX ; EAX <- EDX:EAX/EBX = 1728 , EDX <- EDX:EAX%EBX = 0
    mov EBX, EAX ; clearing EAX register
    ; EBX <- EAX  = 1728
    
    ; 100*(a+b)
    mov AL, [b] ; byte b in the AL register ; AL <- b = -32
    cbw ; converting the byte AL into the word AX ; AX <- b = -2
    add AX, [a] ; AX <- AX + a = -7
    mov CX, 100
    imul CX ; DX:AX <- AX*CX = -700
    push DX ; higher part of DX:AX in the stack
    push AX ; lower part of DX:AX in the stack
    pop EAX ; EAX <- DX:AX = -700
    add EBX, EAX ; EBX <- EBX+EAX = 1028 = x/2 + 100*(a+b)
    
    ; 3/(c+d)
    mov AL, [d] ; AL <- d = 1
    cbw ; converting AL into AX so we can add a word
    add AX, [c] ; AX <- AX + c = 2
    mov CX, AX ; clearing the AX register, CX <- AX = 2
    mov AX, 3
    cwd ; putting 3 in DX:AX so we can divide it by c+d
    idiv CX ; AX <- DX:AX/CX, DX <- DX:AX%CX
    ; getting the value in AX in EAX
    cwde ; AX -=> EAX
    sub EBX, EAX ; EBX <- EBX - EAX = 1027 = x/2 + 100*(a+b) - 3/(c+d)
    
    ; e*e
    mov ECX, 0 ; making ECX 0, so we can have the value of EBX on ECX:EBX
    mov EAX, [e] ; EAX <- e = 210
    imul dword [e] ; EDX:EAX <- EAX * e = 44100
    
    ;x/2 + 100*(a+b) - 3/(c+d) + e*e 
    add EAX, EBX ; adding EBX to EAX
    adc EDX, ECX ; adding ECX to EDX (with carry)
    ; EDX:EAX = 45217
    push dword 0
    call [exit]