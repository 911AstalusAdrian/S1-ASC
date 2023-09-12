
    ;Read a file name and a text from the keyboard. 
    ;Create a file with that name in the current folder and write the text that has been read to file. 
    ;Observations: The file name has maximum 30 characters. The text has maximum 120 characters.
    
bits 32
global start
extern exit, scanf, printf, fprintf, fopen, fclose, gets
import gets msvcrt.dll
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
segment data use32 class=data
    extension db ".txt", 0
    read_message db "Read a text: ", 0
    read_file db "Read a file_name: ", 0
    string_type db "%s", 0
    access_mode db "w", 0
    file_descriptor dd -1
    file_name resb 30
    actual_file resb 35
    text times 120 db 0
    
segment code use32 class=code
start:
    push dword read_message
    call [printf]
    add esp, 4
    
    push dword text
    call [gets]
    add esp, 4
        
    push dword read_file
    call [printf]
    add esp, 4
    
    push dword file_name
    call [gets]
    add esp, 4
    
    mov esi, file_name
    mov edi, actual_file
    add_name:
        lodsb
        cmp al, 0
        je exit_move
        stosb
    jmp add_name
    exit_move:
    
    mov esi, extension
    mov ecx, 4
    add_ext:
        lodsb
        stosb
    loop add_ext
    
    push dword access_mode
    push dword actual_file
    call [fopen]
    add esp, 4*2
    
    cmp eax, 0
    je we_done
    
    mov [file_descriptor], eax
    
    push dword text
    push dword [file_descriptor]
    call [fprintf]
    add esp, 4*2
    
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
    
    
    
    we_done:
    push dword 0
    call [exit]