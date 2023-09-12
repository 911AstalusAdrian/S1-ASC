bits 32
global Convert

Convert:
    mov edx, [esp+4]
    xor eax, eax
    .top:
        movzx ecx, byte[edx]
        inc edx
        cmp ecx, '0'
        jb .done
        cmp ecx, '9'
        ja .done
        sub ecx, '0'
        imul eax, 10
        add eax, ecx
        jmp .top
    
    .done:
        ret 4
       