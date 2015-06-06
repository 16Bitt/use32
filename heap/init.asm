	use32

;Start the heap
; -- => --
init_heap:
	mov eax, kernel_end
	mov [heap_loc], eax
	ret

heap_loc:	dd 0
