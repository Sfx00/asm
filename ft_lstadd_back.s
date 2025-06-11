.global ft_lstadd_back

.intel_syntax noprefix

.section .text
ft_lstadd_back:
    push rdi
    mov rdi, qword ptr[rdi]
    call ft_lstlast
    pop rdi
    test rax, rax
    jz empty
    mov qword ptr[rax + 8], rsi
    ret

empty:
    mov qword ptr[rdi], rsi
    ret
