	use32

;Draw str at X, Y
; string color x y => --
text:
	push ebp
	mov ebp, esp
	
	mov eax, ARG1
	mov [first_text], eax

	;Start function
	mov esi, ARG3
	xor eax, eax
text_loop:
	lodsb
	or al, al
	jz text_loop_done
	cmp al, 13
	je text_was_nl

	pusha
	push dword ARG2
	push dword ARG1
	push dword ARG0
	push eax
	call drawchar
	popa
	add dword ARG1, 8
	jmp text_loop

text_loop_done:
	mov esp, ebp
	pop ebp
	ret 16

text_was_nl:
	mov eax, [first_text]
	mov ARG1, eax
	add dword ARG0, 9
	xor eax, eax
	jmp text_loop

first_text: dd 0
