#importonce 
#import "../../lib/screen.asm"

BasicUpstart2(start)
*=$3000 "Program Start"

start:

    lda #BLACK
    sta SCREEN.SCREEN_COLOR

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
