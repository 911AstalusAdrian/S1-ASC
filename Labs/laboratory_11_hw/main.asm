
    ; Read a string of unsigned numbers in base 10 from keyboard. 
    ; Determine the maximum value of the string and write it in the file max.txt (it will be created) in 16  base.

bits 32
global  start
extern  printf, exit, scanf, gets, fopen, fprintf
import fprintf msvcrt.dll
import fopen msvcrt.dll
import gets msvcrt.dll
import scanf msvcrt.dll
import  printf msvcrt.dll
import  exit msvcrt.dll
;extern Convert
;extern Biggest_number
segment  data use32 class=data
    access_mode db "w", 0
    file_name db "max.txt", 0
    file_descriptor dd -1
	read_message db "Read a string of unsigned numbers: ", 0
    format_string db  "%s", 0
    format_hex db "%x", 0
    our_string times 50 dw 0
    max_value dd 0
    
segment  code use32 class=code
start:

    push dword access_mode
    push dword file_name
    call [fopen]
    add ESP, 4*2
    
    mov [file_descriptor], eax

    push dword read_message
    call [printf]
    add esp, 4
    
    push dword our_string
    call [gets]
    add esp, 4
    ; EAX <- the offset of the string
    
    mov edx, our_string
    each_number:
        mov ebx, 0
        mov bl, byte [edx]
        cmp bl, 0
        je done
        push edx
        ;call Convert
        cmp eax, dword [max_value]
        jbe each_number
        mov dword [max_value], eax
        jmp each_number
    
    done:
    
    mov edx, dword [max_value]
    push dword edx
    push dword format_hex
    push dword [file_descriptor]
    call [fprintf]
    add esp, 4*3
    
    push dword 0
    call [exit]
    
    
    
    
    
    
    
    
    
   