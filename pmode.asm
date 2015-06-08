	use32

include "inc/args.h"
include "inc/rect.h"
include "inc/text.h"
include "inc/color.h"

p_entry:
	call init_heap
	call init_paging
	call init_idt

	to565 27, 27, 27
	push eax
	call cls
	
	;The default keyboard handler
	push 0x21
	push key_handler
	call int_map
	;The PIT handler
	push 0x20
	push pit_handler
	call int_map
	;Update the PIT parameters
	push 10
	call change_pit_freq
	sti

	push string
	push 0x0FF0
	push 20
	push 20
	call text
	
	mov eax, [heap_loc]

loop_main:
	hlt
	jmp loop_main

string: db "Hello, World!", 13, "Newline!", 0

;Graphics functions
include "gfx/cls.asm"
include "gfx/rect.asm"
include "gfx/font.asm"
include "gfx/drawchar.asm"
include "gfx/text.asm"

;Interrupt functions
include "int/init.asm"
include "int/handle.asm"
include "int/common.asm"
include "int/map.asm"

;Heap functions
include "heap/init.asm"
include "heap/malloc.asm"
include "heap/malloca.asm"

;Paging
include "mem/init.asm"
include "mem/map.asm"
include "mem/mk_dir.asm"
include "mem/mk_tab.asm"

;Common functions
include "util/memset.asm"

;Hardware
include "dev/keyboard.asm"
include "dev/pit.asm"

kernel_end:
