
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
    a DW 12
    c DW 1
    b DB 23
    d DB 1
    e DD 120
    x DQ 2010
segment code use32 class= code
start:
    ; The result will be stored in the EDX:EAX register
    ; x/2+100*(a+b)-3/(c+d)+e*e
    
    ; x/2
    mov EAX, dword [x] ; the lower part of the qword x in the EAX register
    mov EDX, dword [x+4] ; the higher part of the qword in the EDX register
    ; EAX:EDX <- x = 2010
    mov EBX, 2 ; moving 2 in the EBX register so we can divide the qword
    div EBX 
    ; EAX <- EAX:EDX / EBX = 1005 , EDX <- EAX:EDX % EBX = 0
    mov ECX, EAX ; moving x/2 in the ECX register
    
    ; 100*(a+b)
    mov AL, [b] ; AL <- b = 23
    mov AH, 0   ; AH <- 0  => AX = 23
    add AX, [a] ; AX <- AX + a = 35
    mov BX, 100 ; BX gets the value 100, so we can multiply the AX register
    mul BX ; AX:DX <- AX * BX = 3500
    push DX ;the high part of the doubleword DX:AX is saved on the stack
    push AX ;the low part of the doubleword DX:AX is saved on the stack
    pop EAX ; EAX <- 100*(a+b) = 3500
    add ECX, EAX ; ECX <- ECX + EAX = 4505 = x/2+100*(a+b)
    
    ; 3/(c+d)
    mov BL, [d] ; BL <- d = 1
    mov BH, 0 ; BH <- 0  => BX = 1
    add BX, [c] ; BX <- BX + c = 2
    mov AX, 3 ; we move 3 in AX so we can divide it by c+d
    mov DX, 0 ; we move 0 in DX, so DX:AX <- AX = 3 
    div BX ; AX <- DX:AX / BX = 1,  DX <- DX:AX % BX = 1
    push word 0 ; adding a word with the value 0 to the stack
    push AX ; adding the value in AX to the stack
    pop EAX ; putting the value from the stack in the EAX register
    ; EAX <- AX = 1
    add ECX, EAX ; ECX <- ECX + EAX = 4506
    
    ;e*e
    mov EAX, [e]
    mul dword [e] ; EDX:EAX <- e*e = 14400
   

    mov EBX, 0 ; making EBX 0, so we have the qword EBX:ECX = ECX = 4506
    ; adding the qwords:  EDX:EAX <- EDX:EAX + EBX:ECX = 18906
    add EAX, ECX ; adding the lower parts of the qwords
    adc EDX, EBX ; adding the higher parts of the qwords (with carry)
    
    
    ; EDX:EAX <- x/2+100*(a+b)-3/(c+d)+e*e
    push dword 0
    call [exit]