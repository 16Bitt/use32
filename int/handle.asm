	use32

include "inc/isr_reg.h"

;This is the main ISR handler that all functionality is passed to
; regs* => --
isr_handler:
	push ebp
	mov ebp, esp
	
	outb 0x20, 0x20

	mov esi, ISR_NUM
	shl esi, 2
	add esi, dword [idt_handlers]
	lodsd

	or eax, eax
	je isr_no_handler
	jmp eax

isr_done:
	mov esp, ebp
	pop ebp
	ret

isr_no_handler:
	draw_text isr_err_text, 0x0000, 10, 10
	mov eax, ISR_NUM
	cli
	hlt

isr_err_text: db "No handler for interrupt, check EAX for details", 0
