
    ;A text file is given.
    ;ex 01
    ;Read the content of the file, count the number of vowels and display the result on the screen.
    ;ex 02
    ;A text file is given. Read the content of the file, count the number of consonants and display the result on the screen
    ;The name of text file is defined in the data segment.
    
bits 32 
global start
extern exit, printf, scanf, gets, fopen, fclose, fread
import fread msvcrt.dll
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
segment data use32 class=data
    file_name db "try.txt", 0
    access_mode db 'r', 0
    vowels_m db "The number of vowels is: %d", 13, 10, 0
    consonants_m db "The number of consonants is: %d", 13, 10, 0
    v_count dd 0
    c_count dd 0
    len equ 100 ; we read 100 bytes at a time
    file_descriptor dd -1
    buffer resb len
segment code use32 class=code
start:
    push dword access_mode
    push dword file_name
    call [fopen]
    add esp, 4*2
    
    cmp eax, 0
    je ending
    mov [file_descriptor], eax

    ; FREAD: destination string, character size, character number, file desc
    push dword [file_descriptor]
    push dword len
    push dword 1
    push dword buffer
    call [fread]
    add esp, 4*4
    
    mov ecx, eax
    mov esi, buffer
    cld
    while_not_end:
        lodsb ; byte in al
        cmp al, 'a'
            je vowel
        cmp al, 'e'
            je vowel
        cmp al, 'i'
            je vowel
        cmp al, 'o'
            je vowel
        cmp al, 'u'
            je vowel
        cmp al, 'A'
            je vowel
        cmp al, 'E'
            je vowel
        cmp al, 'I'
            je vowel
        cmp al, 'O'
            je vowel
        cmp al, 'U'
            je vowel
            
        inc dword [c_count]
        jmp next_char
        vowel:
        inc dword [v_count]
        next_char:
    loop while_not_end
    
    push dword [v_count]
    push dword vowels_m
    call [printf]
    add esp, 4*2
    
    push dword [c_count]
    push dword consonants_m
    call [printf]
    add esp, 4*2
    
    ending:
    
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
    
    push dword 0
    call [exit]