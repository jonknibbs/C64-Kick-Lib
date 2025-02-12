# C64-Kick-Lib

Structure of a Opcode

Byte 1  | Byte 2           | Byte 3
Opcode  | Operand Low Byte | Operand High Byte 

Assembler will make it easier to for the developer allowing them to use a mnemonic for the opcode and have address written in big endian format.
The same mnemonic could be used to reprent multiple opcodes and the assembler will determine the opcode from the rest of the command.
E.G.
`lda $10`
`lda $1040`

## Addressing Modes

### Immediate

`lda #$45`

### Zero Page

`lda $09` // Load from address $09 in zero page.

### Zero Page Indexed

`stx $01` // Store 1 in the x register.
`lda $09, x` // Load value from address $09 + $01 in zero page.

### Absolute

`lda $4009` // Load value from the address $4009.

### Absolute Indexed

`stx $01` // Store 1 in the x register.
`lda $4009, x` // Load value from address $4009 + $01 in memory.

### Indexed Indirect

`lda #$00`
`sta $11`
`lda #$40`
`sta $12` // Store address in zero page $11 and $12 (low byte first).
`stx $01` 
`lda ($10, x)` //Combines $10 and x ($01) to get the address $11, the value from $11 and $12 is returned ($00 & $40) and the value is loaded from that address.

### Indirect Indexed

`lda #$00`
`sta $11`
`lda #$40`
`sta $12` // Store address in zero page $11 and $12 (low byte first).
`sty $01`
`lda ($11), y` // Works similar to Indexed Indirect but the index is used on the address loaded from zero page rather than the zero page address.
               // Loads the value from $11 & $12 ($4000) then it's combined with the index to give a result for $4001 from which the value is loaded.


### Indirect

`jmp ($4000)` // Jump to the address stored at $4000 (low byte) and $4001 (high byte).


### Implied

`inx` // No operand required.



