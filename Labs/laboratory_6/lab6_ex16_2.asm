
    ; Being given two alphabetical ordered strings of characters, s1 and s2, build using merge sort the ordered string of bytes that contain all characters from s1 and s2.

bits 32 
global start
extern exit
import exit msvcrt.dll
segment data use32 class=data
    s1 db 'a', 'b', 'd', 'f', 'i'
    len1 equ $-s1
    s2 db 'c', 'e', 'g', 'h'
    len2 equ $-s2
    s3 times len1+len2 db 0
    len3 equ $-s3
segment code use32 class=code
    ; Our final string will be stored in EDI
    start:
    mov ESI, s1 ; we move s1 into ESI
    ;mov EBX, s2 ; we move s2 into EBX
    mov EDI, s3 ; we move s3 into EDI
    mov ECX, len3 ; we move the length of s3 into ECX, so we can check if it is 0
    jecxz Final ; if the length of s3 is 0, we don't have bytes to sort
    mov EDX, 0 ; we use EDX as a 'counter for s2
    mov ECX, 0 ; we use ECX as a 'counter for S1
    MergeSort:
        cmp EDX, len2 ; we compare the counter of s2 with the length of s2 
        ; This way we see if we still have bits in s2
        jge MergeRemainingS1
        cmp ECX, len1 ; we compare the counter of s1 with the length of s2
        jge MergeRemainingS2
        lodsb ; we move into AL the byte from <DS:ESI>
        mov BL, [s2+EDX] ; we move in BL the byte from s2 on the position of the value of EDX
        cmp AL, BL
        jg SecondByteSmaller
        cld ; we clear the direction flag
        stosb ; we put the byte from AL into <ES:EDI> and increment EDI
        inc ECX ; we increment ECX so we know how many bytes from s1 we took
        jmp MergeSort ; after we put the byte into s3, we start the sort again
        SecondByteSmaller:
            ; we move the byte from BL in AL and we store it into <ES:EDI>
            mov AL, BL
            stosb
            inc EDX ; we increment EDX so we can take the next byte from s2
            dec ESI ; we decrease ESI so we can take again the same byte from s1
            jmp MergeSort ; we start the sort again
    MergeRemainingS1:
        cmp ECX, len1 ; we compare the counter of s1 with the length of s2
        jge Final
        cld ; we clear the direction flag
        lodsb ; we move the byte from <DS:ESI> in AL
        stosb ; we put the byte from AL in <ES:EDI>
        inc ECX
        jmp MergeRemainingS1
    MergeRemainingS2:
        cmp EDX, len2 ; we compare the counter of s2 with the length of s2 
        ; This way we see if we still have bits in s2
        jge Final
        mov AL, [s2+EDX]
        cld ; we clear the direction flag
        stosb ; we store the byte from AL in <ES:EDI>
        inc EDX
        jmp MergeRemainingS2
    Final:
    push dword 0
    call [exit]