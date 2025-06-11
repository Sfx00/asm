.global ft_strlen

.intel_syntax noprefix

.section .text
ft_strlen:
    xor rax, rax
loop:
    mov bl,byte ptr[rdi + rax]
    test bl, bl
    jz end
    inc eax
    jmp loop

end:
    ret
