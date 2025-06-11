.global ft_lstlast

.intel_syntax noprefix


.section .text
ft_lstlast:
    test rdi, rdi
    jz end

loop:
    mov rax, qword ptr [rdi + 8]
    test rax, rax
    jz end

    mov rdi, rax
    jmp loop

end:
    mov rax, rdi
    ret