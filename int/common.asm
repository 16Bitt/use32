	use32

;This file contains common interrupt handlers
err_div_by_zero:
	draw_text div_by_zero_str, 0x0000, 1, 1
	jmp isr_done

div_by_zero_str: db "Divided by zero!", 0

err_debug:
	draw_text err_debug_str, 0, 1, 1
	jmp isr_done

err_debug_str: db "Debug!", 0

err_gpf:
	draw_text err_gpf_str, 0, 1, 1
	jmp isr_done

err_gpf_str: db "General protection fault!", 0

err_instruction:
	draw_text err_instruction_str, 0, 1, 1
	jmp isr_done

err_instruction_str: db "Bad instruction!", 0

err_ghost:
	jmp isr_done
