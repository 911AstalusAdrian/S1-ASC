
    ; A text file is given. Read the content of the file, count the number of letters 'y' and 'z' and display the values on the screen. The file name is defined in the data segment.
    
bits 32
global start        
extern exit, printf, scanf, fopen, fclose, fread          
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
segment data use32 class=data
    file_name db "lab_file.txt",0  ; file name to be created
    access_mode db "r", 0           ; file access mode r - read
	file_descriptor dd -1           ; variable to hold the file descriptor 
    z dd 0                          ; variable used to count the number of letters 'z'
    y dd 0                          ; variable used to count the number of letters 'y'
    len equ 100                       ; maximum nr of characters to read
    text times len db 0             ; string to hold the text read from the file
    format_decimal db "%d", 13, 10, 0
    message_y db "The number of letters 'y' is: ", 0
    message_z db "The number of letters 'z' is: ", 0
   
segment code use32 class=code
    start:
    push dword access_mode          ; we push the file name and
    push dword file_name            ; access mode on the stack
    call [fopen]                    ; eax = fopen(file_name, access_mode)
    add esp, 4*2                    ; clean the stack
    mov [file_descriptor], eax      ; store the file descriptor returned by fopen
    
    ; we check if fopen() has successfully created the file
    cmp eax, 0
    je final
    
    push dword [file_descriptor]
    push dword len
    push dword 1
    push dword text
    call [fread]
    add ESP, 4*4
    cmp eax, 0
    je cleanup
    
    mov ecx, eax
    dec ecx
    each_character:
        mov al, [text+ecx]
        cmp al, 122
        je letter_z
        cmp al, 90
        je letter_z
        cmp al, 89
        je letter_y
        cmp al, 121
        je letter_y
        jmp end_loop
        letter_z:
            inc dword [z]
            jmp end_loop
        letter_y:
            inc dword [y]
            jmp end_loop
        end_loop:
        loop each_character
        
    cleanup:
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
    
    push dword message_y
    call [printf]
    add esp, 4
    mov eax, [y]
    push dword eax
    push dword format_decimal
    call [printf]
    add esp, 4*2
    push dword message_z
    call [printf]
    add esp, 4
    mov eax, [z]
    push dword eax
    push dword format_decimal
    call [printf]
    add esp, 4*2
    final:
    push dword 0      ; place on stack parameter for exit
    call [exit]       ; call exit to terminate the program