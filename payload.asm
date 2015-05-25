	use16
	org 0x8800

entrypoint:
	mov si, output
	call puts
	call enable_a20
	call query_gfx

	;ENTER PMODE
	lgdt [new_gdt]
	mov eax, cr0
	or al, 1
	cli
	mov cr0, eax
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	jmp 0x08:p_entry

;Print a null terminated string
; si=str => --
puts:
	pusha
	mov ah, 0x0E
putsloop:
	lodsb
	or al, al
	jz putsdone
	int 0x10
	jmp putsloop
putsdone:
	popa
	ret

;Prompt the user for a graphics mode
; -- => --
query_gfx:
	pusha
try_query:
	mov si, gfx_choices
	call puts
	mov ah, 0
	int 16h
	push ax
	mov ah, 0x0E
	int 0x10
	pop ax
	cmp al, '1'
	je use800x600
	cmp al, '2'
	je use1024x768
	cmp al, '3'
	je use1280x1024
	jmp try_query
use800x600:
	mov word [height], 600
	mov word [width], 800
	mov ax, 0x114
	jmp query_done
use1024x768:
	mov word [height], 1024
	mov word [width], 768
	mov ax, 0x117
	jmp query_done
use1280x1024:
	mov word [height], 1280
	mov word [width], 1024
	mov ax, 0x11A
	jmp query_done
query_done:
	call start_gfx
	popa
	ret

;Open the A20 line using the BIOS
; -- => --
enable_a20:
	pusha
	mov ax, 0x2401
	int 0x15
	jc a20_error
	cmp ah, 0x86
	je a20_error
	popa
	ret
a20_error:
	mov si, str_no_a20
	call puts
	popa
	ret

;Attempt to run a video mode using the VBE
; ax=mode => --
start_gfx:
	pusha
	push ax
	mov cx, ax
	mov di, vbe_struct
	mov ax, 0x4F01
	int 0x10
	pop bx
	mov ax, 0x4F02
	int 0x10
	popa
	ret

output: db "Payload loaded.", 13, 10, 0
str_no_a20:	db "A20 not supported by bios", 13, 10, 0
gfx_choices:	db 13, 10, "1. 800x600", 13, 10, "2. 1024x768", 13, 10, "3. 1280x1024", 13, 10, "Enter a choice: ", 0

width:	dd ?
height:	dd ?

new_gdt:
	;Null entry
	dw gdt_end - new_gdt - 1
	dw new_gdt
	db 0
	db 0, 0
	db 0
	;Entry 1 -- Ring 0 execution
	dw 0xFFFF
	db 0, 0, 0
	db 0x9A
	db 0xCF
	db 0
	;Entry 2 -- Ring 0 data
	dw 0xFFFF
	db 0, 0, 0
	db 0x92
	db 0xCF
	db 0
	;Entry 3 -- User execution
	dw 0xFFFF
	db 0, 0, 0
	db 0xFA
	db 0xCF
	db 0
	;Entry 4 -- User data
	dw 0xFFFF
	db 0, 0, 0
	db 0xFA
	db 0xCF
	db 0
gdt_end:

;This is where the bios dumps all of our video mode info
vbe_struct:
vbe_attrib:	dw ?
vbe_wins:	db ?, ?
vbe_gran:	dw ?
vbe_winsize:	dw ?
vbe_segs:	dw ?, ?
vbe_biosaddr:	dd ?
vbe_pitch:	dw ?
vbe_res:	dw ?, ?
vbe_banks:	db ?, ?, ?, ?, ?
vbe_model:	db ?, ?, ?
vbe_reserve0:	db ?
vbe_red:	db ?, ?
vbe_green:	db ?, ?
vbe_blue:	db ?, ?
vbe_maskres:	db ?, ?
vbe_dcatrrib:	db ?
vbe_addr:	dd ?
vbe_offscreen:	dd ?
vbe_offsize:	dw ?
vbe_lres:	times 206 db ?

include "pmode.asm"
