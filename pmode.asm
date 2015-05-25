	use32

p_entry:
	mov ax, 0xFFFF
	call cls

	mov eax, 0
	mov ebx, 0
	mov ecx, 400
	mov edx, 300
	mov esi, 0xF00F
	call rect

	mov eax, 400
	mov ebx, 300
	mov esi, 0x0FF0
	call rect

	cli
	hlt

include "gfx/cls.asm"
include "gfx/rect.asm"
