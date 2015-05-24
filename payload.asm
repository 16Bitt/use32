	use16
	org 0x8800

entrypoint:
	mov si, output
	call puts
	cli
	hlt

puts:
	pusha
	mov ah, 0x0E
putsloop:
	lodsb
	or al, al
	jz putsdone
	int 0x10
	jmp putsloop
putsdone:
	popa
	ret

output: db "Hello, World!"
