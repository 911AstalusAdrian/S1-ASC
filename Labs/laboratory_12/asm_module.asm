
    ; Read a string of unsigned numbers in base 10 from keyboard. 
    ; Determine the maximum value of the string and write it in the file max.txt 
    ; (it will be created) in 16  base

bits 32
extern _fprintf, _fopen
global _maxValue
global _write
segment data public data use32
segment code public code use32
_maxValue:
    ; We create a stack frame for the called program
    push ebp
    mov ebp, esp
    mov eax, [ebp+8] ; the second number
    mov ebx, [ebp+12] ; the first number
    
    ; compare the two numbers
    ; the biggest one is put in eax and returned
    cmp eax, ebx
    jae skip
    mov eax, ebx
    skip:
    mov esp, ebp
    pop ebp
    ret

    
    