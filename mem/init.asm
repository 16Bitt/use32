	use32

;Initialize the paging (identity mapped)
init_paging:
	push ebp
	mov ebp, esp

	call mk_page_dir
	mov [base_cr3], eax

	mov eax, 0
	mov ecx, 1023
init_paging_loop:
	pusha
	push dword [base_cr3]
	push eax
	push eax
	call page_map
	popa
	add eax, 0x400000
	loop init_paging_loop

	mov eax, [base_cr3]
	mov cr3, eax
	mov eax, cr0
	or eax, 0x80000000
	mov cr0, eax

	mov esp, ebp
	pop ebp
	ret

base_cr3:
	dd 0
