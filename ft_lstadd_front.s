.global ft_lstadd_front

.intel_syntax noprefix


.section .text

ft_lstadd_front:
    mov rbx, qword ptr [rdi]
    mov qword ptr [rsi + 8], rbx
    mov qword ptr[rdi], rsi
    ret