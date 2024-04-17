#importonce 
#import "../../lib/screen.asm"

BasicUpstart2(helloWorld)
*=$3000 "Hello World"

helloWorld:

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
    inx
    stx SCREEN.BORDER_COLOR
    jmp !loop-

message:
    .text "hello world"
    .byte 0
