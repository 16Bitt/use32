	use32

;Start the heap
; -- => --
init_heap:
	mov eax, 0x800000
	mov [heap_loc], eax
	ret

heap_loc:	dd 0
