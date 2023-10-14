bits 32

.extern rust_kernel_main
.global start
;give access to start for the linker
.set MB_MAGIC, 0x1BADB002
;set the magic number to give kernel location to the bootloader (GRUB)
.set MB_FLAGS, (1 << 0) | (1 << 1)
;set flags to load modules as page boundaries and provide memory map
.set MB_CHECKSUM, (0 - (MB_MAGIC + MB_FLAGS))
;set the checksum of the header

.section .multiboot
;the multiboot header
	.align 4 // Make sure the following data is aligned on a multiple of 4 bytes
	// Use the previously calculated constants in executable code
	.long MB_MAGIC
	.long MB_FLAGS
	.long MB_CHECKSUM

.section .bss
	; alloc stack for our code
	.align 16
	.stack_bottom:
		.skip 4096
	.stack_top:

.section .text
	; the code that we will run
	start:
		mov $stack_top, %esp
		call rust_kernel_main
