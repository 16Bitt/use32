	use32

key_handler:
	in al, 0x60
	call add_to_key_buffer
	pusha
	rectangle 6, 6, 12, 12, 0
	popa
	and eax, 0xFF
	push 0x101F
	push 8
	push 8
	push eax
	call drawchar
	jmp isr_done

add_to_key_buffer:
	pusha
	mov edi, [buffer_index]
	add edi, key_buffer
	stosb
	sub edi, key_buffer
	cmp edi, 31
	jl add_to_kb_done
	xor edi, edi
add_to_kb_done:
	mov [buffer_index], edi
	popa
	ret

buffer_index:
	dd 0

key_buffer:
	times 32 db 0
