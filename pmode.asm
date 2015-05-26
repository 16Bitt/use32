	use32

include "inc/args.h"

p_entry:
	push dword 0xFFFF
	call cls

	push dword 0
	push dword 0
	push dword 400
	push dword 300
	push dword 0x0FF0
	call rect

	push dword 400
	push dword 300
	push dword 400
	push dword 300
	push dword 0xF00F
	call rect

	cli
	hlt

include "gfx/cls.asm"
include "gfx/rect.asm"
