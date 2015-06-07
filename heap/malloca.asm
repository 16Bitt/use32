	use32

;Malloc a 1024 byte aligned address
; addr => --
malloca:
	push ebp
	mov ebp, esp
	
	mov eax, [heap_loc]
	and eax, 0xFFFFF000
	add eax, 0x1000
	mov [heap_loc], eax

	push dword ARG0
	call malloc

	mov esp, ebp
	pop ebp
	ret 4
