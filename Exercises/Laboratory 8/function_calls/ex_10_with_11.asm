
    ;ex 10
    ;Read a number in base 10 from the keyboard and display the value of that number in base 16 
    ;Example: Read: 28; display: 1C
    
    ;ex 11
    ;Read a number in base 16 from the keyboard and display the value of that number in base 10 
    ;Example: Read: 1D; display: 29

bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    decimal_format db "%d", 0
    hex_format db "%x", 0
    message db "Read: ", 0
    message_hex db "Display: %x", 13, 10, 0
    message_dec db "Display: %d", 13, 10, 0
    our_value dd 0
segment code use32 class=code
start: 
    push dword message
    call [printf]
    add esp, 4
    
    push dword our_value
    push dword decimal_format
    call [scanf]
    add esp, 4*2
    
    push dword [our_value]
    push dword message_hex
    call [printf]
    add esp, 4*2
    
    
    ;ex 11
    push dword message
    call [printf]
    add esp, 4
    
    push dword our_value
    push dword hex_format
    call [scanf]
    add esp, 4*2
    
    push dword [our_value]
    push dword message_dec
    call [printf]
    add esp, 4*2
    
    
    push dword 0
    call [exit]