.global memset

.intel_syntax noprefix

.section .text

memset:
    xor rbx, rbx

loop:
    cmp rbx, rdx
    je end
    mov byte ptr [rdi + rbx], sil
    inc rbx
    jmp loop

end:
    mov rax, rdi
    ret