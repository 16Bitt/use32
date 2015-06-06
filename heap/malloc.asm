	use32

;Return a pointer to an adequetly sized buffer
; size => eax=ptr
malloc:
	push ebp
	mov ebp, esp
	
	;Start the function
	mov eax, [heap_loc]
	mov ebx, eax
	add eax, ARG0
	mov [heap_loc], eax
	mov eax, ebx
	
	mov esp, ebp
	pop ebp
	ret 4
