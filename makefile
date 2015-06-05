SOURCES	= boot.bin payload.bin

all: clean bootsector

floppy.img:
	/sbin/mkdosfs -F 12 -s 2 -C floppy.img 1440

bootsector: floppy.img $(SOURCES)
	dd conv=notrunc if=boot.bin of=floppy.img bs=1 seek=64 count=448
	mcopy -o -i floppy.img boot.asm ::/
	mcopy -o -i floppy.img payload.bin ::/PAYLOAD.SYS
	#mcopy -o -i floppy.img user/* ::/

clean:
	-rm *.bin
	-rm *.img

%.bin : %.asm
	fasm $<

run: all
	qemu-system-x86_64 -monitor stdio -vga std -fda floppy.img -net none 

bochs: all
	bochs -q
