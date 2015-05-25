	use32

p_entry:
	mov edi, dword [vbe_addr]
	mov ax, 0xF00F
	mov ecx, 0xFFFF

fuck_it:
	stosw
	loop fuck_it
	
	cli
	hlt

