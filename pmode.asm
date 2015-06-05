	use32

include "inc/args.h"
include "inc/rect.h"

p_entry:
	push dword 0xFFFF
	call cls

	rectangle 0, 0, 400, 300, 0xF00F
	rectangle 400, 300, 400, 300, 0x0FF0

	call init_idt
	
	mov edi, 0x69690420

	sti
	int 0x80

	cli
	hlt

include "gfx/cls.asm"
include "gfx/rect.asm"
include "int/init.asm"
include "int/handle.asm"
