	use32

;Initially, just add to the number of ticks
pit_handler:
	inc dword [num_ticks]
	rectangle 6, 18, 12, 12, [num_ticks]
	jmp isr_done

;Change the frequency of the PIT
; frequency => --
change_pit_freq:
	push ebp
	mov ebp, esp
	
	mov al, 0x36
	out 0x43, al

	xor edx, edx
	mov eax, ARG0
	mov ebx, 1193180
	div ebx
	out 0x40, al
	shr eax, 4
	and eax, 0xFF
	out 0x40, al

	mov esp, ebp
	pop ebp
	ret 4

num_ticks:
	dd 0
