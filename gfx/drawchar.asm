	use32

;Draw a character on to the screen
; color x y char => --
drawchar:
	push ebp
	mov ebp, esp
	
	;Make sure the text will be in bounds
	mov eax, ARG1
	add eax, 8
	cmp eax, [height]
	jge drawchar_done
	mov eax, ARG2
	add eax, 8
	cmp eax, [width]
	jge drawchar_done

	;Start function
	mov esi, ARG0
	imul esi, 8
	add esi, pc_font
	mov ecx, 8

drawchar_row:
	push ecx
	lodsb
	mov bl, al
	mov eax, ARG3
	mov edi, ARG1
	imul edi, [width]
	add edi, ARG2
	shl edi, 1
	add edi, [vbe_addr]
	mov ecx, 8
drawchar_loop:
	test bl, 0x80
	jz drawchar_loop_nowrite
	stosw
	jmp drawchar_loop_done
drawchar_loop_nowrite:
	inc edi
	inc edi
drawchar_loop_done:
	shl bl, 1
	loop drawchar_loop
	pop ecx
	inc dword ARG1
	loop drawchar_row

drawchar_done:
	mov esp, ebp
	pop ebp
	ret 16
