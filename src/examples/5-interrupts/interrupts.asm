#importonce 
#import "../../lib/screen.asm"
#import "../../lib/sprite.asm"
#import "../../lib/kernal.asm"
#import "../../lib/zeropage.asm"
#import "../../lib/interrupt.asm"

*=$1000 "Lookup Tables"
#import "../../tables/screenRows.asm"

scrollX: .byte $00
scrollY: .byte $00
counter: .byte $00

.label  screenControlRegister2 = $D016 //Bits 0-2 horizontal scroll.

BasicUpstart2(start)
*=$3000 "Program Start"

start:

    sei //Suspend all interrupts

    //Disable CIA interrupts
    lda #%01111111 
    sta INTERRUPT.REG

    //Enable sprite raster interrupts.
    lda INTERRUPT.RASTER_SPRITE_INT_REG
    ora #%00000001 //Enable the raster interrupt.
    sta INTERRUPT.RASTER_SPRITE_INT_REG

    //Set which line the raster interrupt is called.
    lda INTERRUPT.RASTER_LINE_MSB
    and #%01111111 //turn off the 7th bit.
    sta INTERRUPT.RASTER_LINE_MSB
    //Set the raster interrupt to be called at zero.
    lda #0
    sta INTERRUPT.RASTER_LINE

    //set the location of the interrupt code
    lda #<interruptCode
    sta INTERRUPT.EXECUTION_LOW
    lda #>interruptCode
    sta INTERRUPT.EXECUTION_HIGH
    cli
    
!loop:
    jmp !loop-

interruptCode:
    inc counter
    lda counter
    cmp #50
    bne acknowledgeInterrupt
    inc SCREEN.BORDER_COLOR
    lda #0
    sta counter

acknowledgeInterrupt:
    dec INTERRUPT.STATUS
    jmp INTERRUPT.SYS_IRQ_HANDLER