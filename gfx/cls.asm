	use32

;Clear the screen with the color in ax
; color16 => --
cls:
	push ebp
	mov ebp, esp
	;Initialize registers
	mov edi, dword [vbe_addr]
	mov ebx, dword [width]
	mov ecx, dword [height]
	;Get the number of pixels
	imul ebx, ecx
	;Divide by two because we'll be using dwords
	shr ebx, 1
	;Mov ebx into ecx because ecx is the counter
	mov ecx, ebx
	;Transform 0x0000XXXX to 0xXXXXXXXX
	mov eax, ARG0
	mov ebx, eax
	shl eax, 16
	or eax, ebx
	;Loop over the entire screen
cls_loop:
	stosd
	loop cls_loop
	;...And done!
	pop ebp
	ret 4
