#importonce 
#import "../../lib/screen.asm"
#import "../../lib/sprite.asm"
#import "../../lib/kernal.asm"
#import "../../lib/zeropage.asm"

*=$1000 "Lookup Tables"
#import "../../tables/screenRows.asm"

BasicUpstart2(start)
*=$3000 "Program Start"

start:

    jsr KERNAL.CLEAR_SCREEN
    lda #$01
    sta SCREEN.SCREEN_MEMORY // Write A to the screen memory

    // Write B at the start of the 9th row
    ldx #$08
    lda SCREEN_TABLE.LOW, x // Load the low byte of the screen address.
    sta ZERO_PAGE.ADDRESS_LOW // Store the low byte of the screen address in the zero page.
    lda SCREEN_TABLE.HIGH, x // Load the high byte of the screen address.
    sta ZERO_PAGE.ADDRESS_HIGH // Store the high byte of the screen address in the zero page.
    ldy #$00
    lda #$01
    sta (ZERO_PAGE.ADDRESS_LOW), y // Store A at the screen address.


!loop:
    jmp !loop-
