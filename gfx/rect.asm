	use32

;Please note: this code was written before the change to cdecl
;	so it's a bit messy

;Draw a rectangle on the screen, clip if it's too big
; eax=x, ebx=y, ecx=width, edx=height, esi=color => --
rect:
	push ebp
	mov ebp, esp
	mov eax, ARG4
	add eax, ARG2
	cmp eax, dword [width]
	jle rect_clip_side_done
	mov eax, dword [width]
	sub eax, ARG4
	mov ARG2, eax
rect_clip_side_done:
	mov eax, ARG3
	add eax, ARG1
	cmp eax, dword [height]
	jle rect_clip_bottom_done
	mov eax, dword [height]
	sub eax, ARG3
	mov ARG1, eax
rect_clip_bottom_done:
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

;if(x + width > screen_width){
;	width = screen_width - x;
;}

