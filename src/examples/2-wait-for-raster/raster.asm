#importonce 
#import "../../lib/screen.asm"
#import "../../lib/kernal.asm"

BasicUpstart2(start)
*=$3000 "Program Start"

start:

    lda #BLACK
    sta SCREEN.SCREEN_COLOR
    jsr KERNAL.CLEAR_SCREEN

    lda message
    ldx #0

    lda message, x
!loop:
    sta $0400, x
    inx
    lda message, x
    cmp #0
    bne !loop-

!loop:
    lda SCREEN.RASTER_LINE
    cmp #$64
    bne !loop-
    inc SCREEN.BORDER_COLOR
    jmp !loop-

message:
    .text "hello world"
    .byte 0
