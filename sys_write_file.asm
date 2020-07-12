; Assembly syscall write with output file by 0pc0de Alchimiste
BITS 64

global _main

section .rodata

	path db 'flags.txt', 0
	write_file db "Hello", 0
	write_file_len equ $-write_file
	file_not_exist db "Le fichier n'existe pas.", 0
	file_not_exist_len equ $-file_not_exist
	file_exist db "Good.", 0
	file_exist_len equ $-file_exist
	
section .text

_main:
	mov rax, 2
	mov rdi, path
	mov rsi, 02
	mov rdx, 777
	syscall
	push rax
	cmp rax, 3
	je _writing
	jmp _file_not_found

_writing:
	mov rax, 1
	pop rsi
	mov rdi,rsi
	mov rsi, write_file
	mov rdx, write_file_len
	syscall
	jmp _good

_good:
	mov rax, 1
	mov rdi, 1
	mov rsi, file_exist
	mov rdx, file_exist_len
	syscall
	jmp _exit

_file_not_found:
	mov rax, 1
	mov rdi, 1
	mov rsi, file_not_exist
	mov rdx, file_not_exist_len
	syscall
	jmp _exit

_exit:
	mov rax, 0x3C
	mov rdi, 0
	syscall
