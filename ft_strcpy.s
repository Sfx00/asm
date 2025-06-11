.global ft_strcpy

.intel_syntax noprefix


.section .text
ft_strcpy:
    xor rax, rax
    xor rbx, rbx
loop:
    mov bl, byte ptr[rsi + rax]
    test bl, bl
    jz end
    mov bl, byte ptr[rsi + rax]
    mov byte ptr[rdi + rax], bl
    inc rax
    jmp loop
end:
    mov byte ptr[rdi + rax], 0
    mov rax, rdi
    ret
