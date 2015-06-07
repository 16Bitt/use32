	use32

;Make an empty page dir
; -- => eax=dir_address
mk_page_dir:
	push ebp
	mov ebp, esp

	push 1024 * 4
	call malloca
	push eax
	mov edi, eax
	mov eax, 2	;No table
	mov ecx, 1024
mk_page_dir_loop:
	stosd
	loop mk_page_dir_loop
	
	pop eax

	mov esp, ebp
	pop ebp
	ret
