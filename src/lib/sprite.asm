

spriteNumberMask:  .byte %00000001, %00000010, %00000100, %00001000, %00010000, %00100000, %01000000, %10000000

.label	SPRITE_ENABLE = $D015

//high res or multicolor
.label	SPRITE_HIRES = $D01C

//sprite size expanders
.label	SPRITE_DOUBLE_X = $D01D
.label	SPRITE_DOUBLE_Y = $D017

SPRITE_0: {
    .label POINTER = $07F8
    .label X = $D000
	.label Y = $D001
    .label MSB_X = $D010 // %00000001
}

SPRITE_1: {
    .label POINTER = $07F9
    .label X = $D002
	.label Y = $D003
    .label MSB_X = $D010 // %000000010
}

SPRITE_2: {
    .label POINTER = $07FA
    .label X = $D004
	.label Y = $D005
    .label MSB_X = $D010 // %000000100
}

SPRITE_3: {
    .label POINTER = $07FB
    .label X = $D006
	.label Y = $D007
    .label MSB_X = $D010 // %000001000
}

SPRITE_4: {
    .label POINTER = $07FC
    .label X = $D008
	.label Y = $D009
    .label MSB_X = $D010 // %000010000
}

SPRITE_5: {
    .label POINTER = $07FD
    .label X = $D00A
	.label Y = $D00B
    .label MSB_X = $D010 // %000100000
}

SPRITE_6: {
    .label POINTER = $07FE
    .label X = $D00C
	.label Y = $D00D
    .label MSB_X = $D010 // %001000000
}

SPRITE_7: {
    .label POINTER = $07FF
    .label X = $D00E
	.label Y = $D00F
    .label MSB_X = $D010 // %010000000
}

////////////////////////////////////////////
// Sprite Related Macros 
////////////////////////////////////////////

// Enable a given sprite number
.macro MacroEnableSprite(sprite){
    ldx #sprite
    lda spriteNumberMask, x 
    ora SPRITE_ENABLE
    sta SPRITE_ENABLE
}

// Disable a given sprite number
.macro MacroDisableSprite(sprite){
    lda spriteNumberMask, sprite
    eor #%11111111
    and SPRITE_ENABLE
    sta SPRITE_ENABLE
}

