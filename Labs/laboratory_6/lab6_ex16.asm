
    ; Being given two alphabetical ordered strings of characters, s1 and s2, build using merge sort the ordered string of bytes that contain all characters from s1 and s2.

bits 32 
global start
extern exit
import exit msvcrt.dll
segment data use32 class=data
    s1 db 'a', 'b', 'd', 'f', 'i'
    l1 equ $-s1
    s2 db 'c', 'e', 'g', 'h'
    l2 equ $-s2
    s3 times l1+l2 db 0
segment code use32 class=code
    start:
    ; We 'clear' the registers EBP, EDI and ESI and initialise ECX and EDX with the lengths of our strings
    mov ECX, l1
    mov EDX, l2
    mov EDI, 0 ; EDI is used as an index for the first string
    mov ESI, 0 ; ESI is used as an index for the second string
    mov EBP, 0 ; EBP is used as an index for the third string
    MergeSort:
        
        mov AL, [s1+EDI] ; we take the byte of s1 which is on the EDI position
        mov BL, [s2+ESI] ; we take the byte of s2 which is on the ESI position
        cmp AL, BL       ; we compare the two bytes, performing a fictive subtraction
        jle StringOne    ; if the byte from s1 is 'smaller', we add it to s3
        jg StringTwo     ; if the byte from s2 is 'smaller', we add it to s3
        ; In this case, the ASCII code of the characters is compared
        
        StringOne:
            mov [s3+EBP], AL ; we add the compared byte from s1 to s3 on the EBP position
            inc EBP          ; we increment EBP, so we can put the next byte on the next position in s3
            inc EDI          ; we also increment EDI so we can use the next byte from s1 in the comparison
            jmp SkipS2       ; we 'skip' over 'StringTwo'
            
        StringTwo:
           mov [s3+EBP], BL  ; we add the compared byte from s2 to s3 on the EBP position
           inc EBP           ; we increment EBP, so we can put the next byte on the next position in s3
           inc ESI           ; we also increment EDI so we can use the next byte from s1 in the comparison
        
        SkipS2:
        ; after we added either a byte from s1, or a byte from s2, we check if there are any bytes from the strings to be compared
            cmp EDI, ECX     ; we check if there are any bytes left in s1 (if the length of our counter for s1 is smaller than the length of s1)
            je MergeRemainingS2  ; when the counter value is equal to the length of s1, it means that there are no more bytes in s1 to be compared and we add the remaining bits from s2
            cmp ESI, EDX     ; we check if there are any bytes left in s2 (if the length of our counter for s2 is smaller than the length of s2)
            je MergeRemainingS1  ; when the counter value is equal to the length of s1, it means that there are no more bytes in s1 to be compared and we add the remaining bits from s2
            ; if the condition for the first jump isn't accomplished, we go to the second comparison
            ; if the condition for the second jump isn't accomplished either, it means that we still have bits to compare in both the strings, and we jump to the beggining
            jmp MergeSort
    
    MergeRemainingS1:
        ; we add the remaining bits from s1 to s3, because there are no more bits in s2 to be compared
        mov AL, [s1+EDI]    ; we take the byte of s1 which is on the EDI position
        mov [s3+EBP], AL    ; we add byte from s1 to s3 on the EBP position
        inc EDI             ; we increment EDI so we can use the next byte from s1 in the comparison
        inc EBP             ; we increment EBP, so we can put the next byte on the next position in s3
        cmp EDI, ECX        ; we check if there are any bytes left in s1 (if the length of our counter for s1 is smaller than the length of s1)
        jl MergeRemainingS1 ; if there are still bits in s1, we jump back to the beginning of 'MergeRemainingS1'
        jge SortEnd         ; after we added all the bits from s1, we jump to the end
    
    MergeRemainingS2:
        ; similar to 'MergeRemainingS2', but applied for s2
        mov BL, [s2+ESI]    ; we take the byte of s2 which is on the ESI position
        mov [s3+EBP], BL    ; we add the byte from s2 to s3 on the EBP position
        inc ESI             ; we also increment EDI so we can use the next byte from s1 in the comparison
        inc EBP             ; we increment EBP, so we can put the next byte on the next position in s3
        cmp ESI, EDX        ; we check if there are any bytes left in s2 (if the length of our counter for s2 is smaller than the length of s2)
        jl MergeRemainingS2 ; if there are still bits in s2, we jump back to the beginning of 'MergeRemainingS2'
    
    SortEnd:
    
    push dword 0
    call [exit]