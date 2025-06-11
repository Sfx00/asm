.global ft_strdup

.intel_syntax noprefix

.section .text
ft_strdup:
    push rdi
    call ft_strlen
    inc rax
    mov rdi, rax
    call malloc
    test rax, rax
    jz error

    pop rdi
    xor rbx, rbx

loop:
    mov cl, byte ptr [rdi + rbx]
    test cl, cl
    jz end
    mov byte ptr [rax + rbx],  cl
    inc rbx
    jmp loop
     
end:
    mov byte ptr [rax + rbx], 0
    ret

error:
    mov rax, 0
    ret