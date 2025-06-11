.global ft_lstnew

.intel_syntax noprefix


.section .text
ft_lstnew:
    push rdi
    mov rdi, 16
    call malloc

    test rax, rax
    jz malloc_fail
    pop rdi

    mov qword ptr[rax], rdi
    mov qword ptr[rax + 8], 0

    ret

malloc_fail:
    pop rdi
    ret