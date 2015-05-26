	use32

;Draw a rectangle on the screen
; eax=x, ebx=y, ecx=width, edx=height, esi=color => --
rect:
	push ebp
	mov ebp, esp
	mov esi, ARG0
	mov edx, ARG1
	mov ecx, ARG2
	mov ebx, ARG3
	mov eax, ARG4
	imul ebx, dword [width]
	add eax, ebx
	shl eax, 1
	add eax, dword [vbe_addr]
	mov edi, eax
	mov eax, esi
rect_loop:
	push ecx
rect_loopx:
	stosw
	loop rect_loopx
	pop ecx
	shl ecx, 1
	sub edi, ecx
	add edi, dword [width]
	add edi, dword [width]
	dec edx
	shr ecx, 1
	or edx, edx
	jnz rect_loop
	pop ebp
	ret 4 * 5
