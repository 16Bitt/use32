	use32

;Make an empty page table
; -- => eax=table
mk_page_tab:
	push ebp
	mov ebp, esp
	
	push 1024 * 4
	call malloca
	push eax
	mov edi, eax
	mov eax, 0x2
	mov ecx, 1024
mk_page_tab_loop:
	stosd
	loop mk_page_tab_loop

	pop eax

	mov esp, ebp
	pop ebp
	ret
