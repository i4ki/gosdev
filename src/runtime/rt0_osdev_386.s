#include "textflag.h"

TEXT _rt0_386_osdev(SB), 7, $0
	// Disable interrupts.
	CLI

	// Establish stack.
	MOVL $0x10000, AX
	MOVL AX, SP

	// Set up memory hardware.
	CALL runtime·msetup(SB)

	// _rt0_386 expects to find argc, argv, envv on stack.
	// Set up argv=["kernel"] and envv=[].
	SUBL $64, SP
	MOVL $1, 0(SP)
	MOVL $runtime·kernel(SB), 4(SP)
	MOVL $0, 8(SP)
	MOVL $0, 12(SP)

	MOVQ $runtime·rt0_go(SB), AX
	MOVQ $0, DI
	MOVQ $0, SI
	JMP  AX

DATA runtime·kernel(SB)/7, $"kernel\z"
GLOBL runtime·kernel(SB), $7
