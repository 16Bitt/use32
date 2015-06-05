	use32

include "inc/isr_reg.h"

;This is the main ISR handler that all functionality is passed to
; regs* => --
isr_handler:
	push ebp
	mov ebp, esp

	mov esi, ARG0
	mov eax, ISR_NUM
	cli
	hlt

	mov esp, ebp
	pop ebp
	ret
