	use32

include "inc/args.h"
include "inc/rect.h"

p_entry:
	push dword 0xFFFF
	call cls

	rectangle 0, 0, 400, 300, 0xF00F
	rectangle 400, 300, 400, 300, 0x0FF0

	call init_idt
	call init_heap
	
	push string
	push 0x0FF0
	push 20
	push 20
	call text

	cli
	hlt

string: db "Hello, World!", 13, "Newline!", 0

include "gfx/cls.asm"
include "gfx/rect.asm"
include "gfx/font.asm"
include "gfx/drawchar.asm"
include "gfx/text.asm"
include "int/init.asm"
include "int/handle.asm"
include "heap/init.asm"
include "heap/malloc.asm"
;include "heap/amalloc.asm"

kernel_end:
