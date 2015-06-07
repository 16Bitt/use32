	use32

;Set a region of memory to a given value
; address value size => --
memset:
	push ebp
	mov ebp, esp
	pusha
	
	;Start function
	mov edi, ARG2
	mov ecx, ARG0
	mov eax, ARG1
memset_loop:
	stosb
	loop memset_loop

	popa
	mov esp, ebp
	pop ebp
	ret 12
