#importonce 
#import "../../lib/screen.asm"
#import "../../lib/kernal.asm"

BasicUpstart2(helloWorld)
*=$3000 "Hello World"

helloWorld:
    jsr KERNAL.CLEAR_SCREEN

    lda #BLACK
    sta SCREEN.SCREEN_COLOR

    lda message
    ldx #0

    lda message, x
!loop:
    sta SCREEN.SCREEN_MEMORY, x
    lda #WHITE
    sta SCREEN.SCREEN_CHARACTER_COLOR, x
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
