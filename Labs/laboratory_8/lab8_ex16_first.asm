
    ; Read two numbers a and b (in base 10) from the keyboard. Calculate and print their arithmetic average in base 16
    
bits 32
global start        
extern exit, printf, scanf            
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll 
segment data use32 class=data
	a dd 0 
    b dd 0
    c dd 0
	message_for_a db "Give the value a: ", 0
    message_for_b db "Give the value b: ", 0
    message_for_result db "The arithmetic average in base 16 is: ", 0
	format_decimal  db "%d", 0  ; %d <=> a decimal number (base 10)
    format_hexadecimal db "%x", 0 ; %x <=> an unsigned hexadecimal number (base 16)
    
segment code use32 class=code
    start:
    
    push dword message_for_a
    call [printf]
    add ESP, 4*1  
    push dword a
    push dword format_decimal
    call [scanf]
    add ESP, 4*2
    
    push dword message_for_b
    call[printf]
    add ESP, 4*1
    push dword b
    push dword format_decimal
    call [scanf]
    add ESP, 4*2
    
    mov EAX, [a]
    mov EBX, [b]
    add EAX, EBX
    mov EDX, 0
    mov EBX, 2
    div EBX  
    mov [c], eax
    
    push message_for_result
    call [printf]
    add esp, 4*1
    push dword [c]
    push format_hexadecimal
    call [printf]
    add ESP, 4*2
    
    push dword 0      ; place on stack parameter for exit
    call [exit]       ; call exit to terminate the program