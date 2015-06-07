	use32

;Map physical address to virtual address in dir
; dir physical virtual => --
page_map:
	push ebp
	mov ebp, esp
	
	mov eax, ARG0
	shr eax, 22
	mov ARG0, eax

	call mk_page_tab
	mov edi, ARG0
	shl edi, 2
	add edi, ARG2
	or eax, 3
	stosd
	
	and eax, 0xFFFFF000
	mov edi, eax
	mov ecx, 1024
	mov eax, ARG1
	or eax, 3
page_map_loop:
	stosd
	add eax, 4096
	loop page_map_loop

	mov esp, ebp
	pop ebp
	ret 12
