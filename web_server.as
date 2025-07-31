.global _start

.intel_syntax noprefix

.section .data

msg: .asciz "HTTP/1.0 200 OK\r\n\r\n"
request: .space 256
get_request: .space 20
tmp: .space 8192

cont: .space 255

s_bytes: .quad 0
socklen_t: .long 16

sockaddr:
    .word 2
    .space 14

sockaddr_in:
    .word 2
    .word 0x5000
    .long 0
    .space 8

.section .text

_start:
    
socket:
    mov rax, 41
    mov rdi, 2
    mov rsi, 1
    mov rdx, 0
    syscall
    #save fd socket of server 
    mov r12, rax
    
bind:
    mov rdi, r12
    lea rsi, [sockaddr_in]
    mov rdx, 16
    mov rax, 49
    syscall

# listen and accept request

listen:
    mov rdi, r12
    mov rsi, 0
    mov rax, 50
    syscall
    test rax, rax
    js exit

accept:
    mov rdi, r12
    mov rsi, 0
    mov rdx, 0
    mov rax, 43
    syscall
    push rax

# call fork
    mov rax, 57
    syscall
    test rax, rax
    jz call_child

/*
# wait
    mov rax, 61
    mov rdi, 0
    mov rsi, 0
    mov rdx, 0
    mov r10, 0
    syscall
*/

# close connection 
    mov rax, 3
    pop rdi
    syscall
    jmp listen


call_child:

# close server socket
    mov rax, 3
    mov rdi, r12
    syscall

# read
    # r13 have fd of client socket
    pop r13
    mov rdi, r13
    lea rsi, [request]
    mov rdx, 21
    mov rax, 0
    syscall
    # read.. 
    mov rdi, r13
    lea rsi, [tmp]
    mov rdx, 500
    mov rax, 0
    syscall

    mov s_bytes, rax


choose:
    mov dl, request
    cmp dl, 80
    je POST
    cmp dl, 71
    je GET
    jmp finish
    
    
GET:
    # open file for just read only
    lea rdi, [request]
    mov  byte ptr [rdi + 20], 0 
    mov rax, 2
    lea rdi, [request + 4]
    mov rsi, 0
    syscall

    # save fd of file
    mov r14, rax
    
    # read from file
    mov rdi, r14
    lea rsi, [cont]
    mov rdx, 255
    mov rax, 0
    syscall

    # return of read 
    push rax;


    # close the file
    mov rax, 3
    mov rdi, r14
    syscall

    # send HTTP response to client (OK!)
    mov rdi, r13
    lea rsi, [msg]
    mov rdx, 19
    mov rax, 1
    syscall

    # write content in socket of client
    mov rax, 1
    mov rdi, r13
    lea rsi, [cont]
    pop rdx
    syscall

    # exit
    mov rax, 60
    mov rdi, 0
    syscall









POST:

# open
    mov rax, 2
    lea rdi, [request + 5]
    mov rsi, 65
    mov rdx, 511
    syscall

    #r14 fd the open file
    mov r14, rax

    mov rax, s_bytes

parsing:
    mov dl, [tmp + rax]
    cmp dl, 10
    je send
    sub rax, 1
    jmp parsing

send:
    mov rdi, r14
    add rax, 1
    lea rsi, [tmp + rax]
    mov rdx, s_bytes
    sub rdx, rax
    mov rax, 1
    syscall

    # close file
    mov rax, 3
    mov rdi, r14
    syscall

finish:
# send HTTP response to client (OK!)
    mov rdi, r13
    lea rsi, [msg]
    mov rdx, 19
    mov rax, 1
    syscall

# close connection
    mov rax, 3
    mov rdi, r13
    syscall

# exit
    mov rax, 60
    mov rdi, 0
    syscall

# exit parrent and close socket of server
exit:
    mov rax, 3
    mov rdi, r12
    syscall
    mov rdi, 0
    mov rax, 60
    syscall

