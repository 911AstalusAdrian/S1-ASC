
    ;A file name (defined in data segment) is given. 
    ;Create a file with the given name, then read words from the keyboard until character '$' is read from the keyboard. 
    ;Write only the words that contain at least one digit to file.
    
bits 32
global start
extern exit, scanf, printf, fopen, fclose, fprintf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
segment data use32 class=data
    file_name db "another.txt", 0
    access_mode db "w", 0
    string_type db "%s", 0
    message db "Give a word: ", 0
    space db " ", 0
    file_descriptor dd -1
    has_digit db 0
    our_word resd 5
segment code use32 class=code
start:
    
    push dword access_mode
    push dword file_name
    call [fopen]
    add esp, 4*2
    
    cmp eax, 0
    je ending
    mov [file_descriptor], eax
    
    each_word:
        push dword message
        call [printf]
        add esp, 4
        
        mov dword [our_word], 0
        push dword our_word
        push dword string_type
        call [scanf]
        add esp, 4*2
        
        cmp dword [our_word], '$'
        je ending
        
        mov byte [has_digit], 0
        mov esi, our_word
        each_character:
            lodsb
            cmp al, 0
            je end_character
            cmp al, '0'
            je digit
            cmp al, '1'
            je digit
            cmp al, '2'
            je digit
            cmp al, '3'
            je digit
            cmp al, '4'
            je digit
            cmp al, '5'
            je digit
            cmp al, '6'
            je digit
            cmp al, '7'
            je digit
            cmp al, '8'
            je digit
            cmp al, '9'
            je digit
            
            jmp no_digit
            digit:
                
                
                push dword our_word
                push dword [file_descriptor]
                call [fprintf]
                add esp, 4*2
                
                push dword space
                push dword [file_descriptor]
                call [fprintf]
                add esp, 4*2
                jmp end_character
            no_digit:
            jmp each_character
            end_character:
         jmp each_word
    
    ending:
    
    push dword 0
    call [exit]