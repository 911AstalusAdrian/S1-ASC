    ;Read one byte and one word from the keyboard. Print on the screen "YES" if the bits of the byte read are found consecutively among the bits of the word and "NO" otherwise. Example: a = 10 = 0000 1010b
    ;                   b = 256 = 0000 0001 0000 0000b
    ;                   The value printed on the screen will be NO.
    ;a = 0Ah = 0000 1010b
    ;b = 6151h = 0110 0001 0101 0001b
    ;The value printed on the screen will be YES (you can find the bits on positions 5-12).
    
bits 32
global start
extern exit, scanf, printf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    message_a db "Read a: ", 0
    message_b db "Read b: ", 0
    hex db "%x", 0
    message_yes db "YES", 0
    message_no db "NO", 0
    value_a db 0
    value_b dw 0
segment code use32 class=code
start:
    push dword message_a
    call [printf]
    add esp, 4
   
    push dword value_a
    push dword hex
    call [scanf]
    add esp, 4*2
   
    push dword message_b
    call [printf]
    add esp, 4
   
    push dword value_b
    push dword hex
    call [scanf]
    add esp, 4*2
   
    mov ecx, 8 ; we'll do the loop 8 times, because there are 8 ways in which we can find the bits of a in the bits of b
    xor eax, eax
    mov ax, [value_b]
    each_consecutive_bits:
        mov bl, al
        sub bl, [value_a] ; we subtract from the lower byte the value a
        ; if the result is 0, it means the bytes were the same as the ones of a
        cmp bl, 0
        jne next
        push dword message_yes
        call [printf]
        add esp, 4
        jmp ending
        next:
        ; we push and then pop ecx, because we need the initial value for the loop
        ; we also use ecx register (CL) for shifting the bits
        push ecx
        mov cl, 1
        shr ax, cl
        pop ecx
    loop each_consecutive_bits
   
    push dword message_no
    call [printf]
    add esp, 4
    
    ending:
    push dword 0
    call [exit]