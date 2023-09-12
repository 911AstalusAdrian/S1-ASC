    
    ; Given the words A and B, compute the doubleword C as follows:
    ; the bits 0-7 of C have the value 1
    ; the bits 8-11 of C are the same as the bits 4-7 of A
    ; the bits 12-19 are the same as the bits 2-9 of B
    ; the bits 20-23 are the same as the bits 0-3 of A
    ; the bits 24-31 are the same as the high byte of B
    
bits 32
global  start 
extern  exit
import  exit msvcrt.dll
segment  data use32 class=data
     a dw 0111011101010111b
     b dw 1001101110111110b 
     c resd 1
segment  code use32 class=code ; code segment
start:
    
    mov EBX, 0 ; we compute the result in EBX
    
    ; the bits 0-7 of C have the value 1
    or EBX, 00000000000000000000000011111111b ; we force the value of bits 0-7 of the result to be 1
    
    ; the bits 8-11 of C are the same as bits 4-7 of A
    mov AX, [a] ; we isolate the bits 4-7 of A
    mov DX, 0
    and AX, 0000000011110000b
    push DX
    push AX     ; we convert the word AX into the dword EAX
    pop EAX     ; EAX will have the bits 4-7 of A
    mov CL, 4
    rol EAX, CL ; we rotate to the left, to bring the bits in the positions 8-11
    or EBX, EAX ; we copy the bits 8-11 of EAX into EBX
    
    ; the bits 12-19 are the same as the bits 2-9 of B
    mov AX, [b] ; we isolate the bits 2-9 of B
    mov DX, 0
    and AX, 0000001111111100b
    push DX
    push AX     ; we convert the word AX into the dword EAX
    pop EAX     ; EAX will have the bits 2-9 of B
    mov CL, 10
    rol EAX, CL ; we rotate to the left, bringing the bits in the right positions
    or EBX, EAX ; we copy the bits 12-19 of EAX into EBX
    
    ; the bits 20-23 are the same as bits 0-3 of A
    mov AX, [a] ; we isolate the bits 0-3 of A
    mov DX, 0
    and AX, 0000000000001111b
    push DX
    push AX     ; we convert the word AX into the dword EAX
    pop EAX     ; EAX will have the bits 0-3 of A
    mov CL, 20
    rol EAX, CL ; we rotate to the left, bringing the bits in the right positions
    or EBX, EAX ; we copy the bits 20-23 of EAX into EBX
    
    ;the bits 24-31 are the same as the high byte of B
    mov AX, [b]
    mov DX, 0
    and AX, 1111111100000000b ; we isolate the high byte of B
    push DX
    push AX     ; we convert the word AX into the dword EAX
    pop EAX
    mov CL, 16
    rol EAX, CL ; we rotate to the left so that the bits are in the right positions
    or EBX, EAX ; we copy the bits 24-31 of EAX into EBX
    
    mov dword [c], EBX ; dword c will have the value from the register EBX 
    push dword 0
    call [exit]