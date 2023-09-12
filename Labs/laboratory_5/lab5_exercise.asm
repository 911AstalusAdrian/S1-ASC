
    ; Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements found on odd positions in S2 and the elements found on even positions in S1.
    ; Example:
    ; S1: 'a', 'b', 'c', 'b', 'e', 'f'
    ; S2: '1', '2', '3', '4', '5'
    ; D: '1', '3', '5', 'b', 'b', 'f'

bits 32
global  start 
extern  exit
import  exit msvcrt.dll
segment  data use32 class=data
    s1 db 'a','b','c','d','e','f' ; the string of bytes s1
    l equ $-s1 ; compute the length of the string in s1
    s2 db '1', '2', '3', '4', '5' ; the string of bytes s2
    p equ $-s2 ; compute the length of the string in s2
    D times l db 0 ; reserve s1 bytes for the destination string and initialise it

segment  code use32 class=code ; code segment
start:
    mov ECX, p ; we put the length of s2 in ECX in order to make the loop
    mov ESI, 0
    mov EDX, 0
    jecxz Ending1
    RepetaS2:
        test ESI, 1
        jnz notOdd
        mov AL, [s2+ESI]
        mov [D+EDX], AL
        inc EDX
        notOdd:
        inc ESI
    Ending1: ; the end of the first loop
    loop RepetaS2
   
    mov ECX, l ; we put the length of s1 in ECX in order to make the loop
    mov ESI, 0
    jecxz Ending2
    RepetaS1:
        test ESI, 1
        jz notEven
        mov AL, [s1+ESI]
        mov [D+EDX], AL
        inc EDX
        notEven:
        inc ESI
    loop RepetaS1
    Ending2: ;the end of the second loop
    push dword 0
    call [exit]