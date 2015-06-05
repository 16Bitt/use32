	use32

;Map an interrupt into the IDT
; int-no addr => --
int_map:
	push ebp
	mov ebp, esp
	
	;
	xor edi, edi
	imul edi, ARG1
	shl edi, 3
	add edi, interrupt_table
	
	;This loads the idt (at edi)
	mov eax, ARG0
	stosw
	mov al, 0x8
	stosb
	mov al, 0
	stosb
	mov al, 0x8E | 0x60
	stosb
	mov eax, ARG0
	shl eax, 16
	stosw

	mov esp, ebp
	pop ebp
	ret 8
