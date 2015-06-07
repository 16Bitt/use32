	use32

;Map an interrupt into the IDT
; int-no addr => --
int_map:
	push ebp
	mov ebp, esp

	mov edi, ARG1
	shl edi, 2
	add edi, dword [idt_handlers]
	mov eax, ARG0
	stosd

	mov esp, ebp
	pop ebp
	ret 8
