.global ft_strcmp


.intel_syntax noprefix


.section .text

ft_strcmp:
    xor rax, rax
loop: 
    mov bl, byte ptr[rdi + rax]
    test bl, bl
    jz end

    mov cl, byte ptr[rsi + rax]
    cmp bl, cl
    jne end
    inc rax
    jmp loop

end:
    movzx eax, bl
    movzx ecx, cl

    sub eax, ecx

    ret
    