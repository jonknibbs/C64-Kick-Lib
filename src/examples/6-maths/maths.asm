#importonce 
#import "../../lib/screen.asm"
#import "../../lib/sprite.asm"
#import "../../lib/kernal.asm"
#import "../../lib/zeropage.asm"
#import "../../lib/interrupt.asm"

*=$1000 "Lookup Tables"
#import "../../tables/screenRows.asm"

counter: .byte $00

BasicUpstart2(start)
*=$3000 "Program Start"

start:
    ///////////////////////
    // Addition
    ///////////////////////

    // Add 2 8 bit numbers together.
    clc // Clear the carry flag, this will be used to store the overflow of the addition.
    lda #$05
    adc #$04 // Add 5 + 4 = 9
    sta ZERO_PAGE.TEMP // Store in $02.

    // Add an 8 bit number to a 16 bit number.
    // This example uses the carry flag and increments the highest byte.
    lda #$FF // 255 in decimal.
    sta ZERO_PAGE.PARAM_1 // Store the lowest byte first of the 16 bit number
    lda #$01
    sta ZERO_PAGE.PARAM_2 // Store the highest byte of the 16 bit number directly after the first.
    // The total number is $01FF or 511 in decimal.
    lda #$09
    jsr add8BitTo16Bit // Add 9 to the 16 bit number.

    // This example doesn't use the carry flag.
    lda #$F0 // 240 in decimal.
    sta ZERO_PAGE.PARAM_1 // Store the lowest byte first of the 16 bit number
    lda #$01
    sta ZERO_PAGE.PARAM_2 // Store the highest byte of the 16 bit number directly after the first.
    // The total number is $01F0 or 496 in decimal.
    lda #$09
    jsr add8BitTo16Bit // Add 9 to the 16 bit number.

    // Add 2 16 bit numbers together.
    lda #$F0 // 240 in decimal.
    sta ZERO_PAGE.PARAM_1 // Store the lowest byte first of the 16 bit number
    lda #$01
    sta ZERO_PAGE.PARAM_2 // Store the highest byte of the 16 bit number directly after the first.
    // The total number is $01F0 or 496 in decimal.
    lda #$09
    ldx #$01
    jsr add16BitTo16Bit // Add 265 $0109 to the 16 bit number.

    ///////////////////////
    // Subtraction
    ///////////////////////

    // Subtract an 8 bit number from a 16 bit number.
    lda #$F0 // 240 in decimal.
    sta ZERO_PAGE.PARAM_1 // Store the lowest byte first of the 16 bit number
    lda #$01
    sta ZERO_PAGE.PARAM_2 // Store the highest byte of the 16 bit number directly after the first.
    // The total number is $01F0 or 496 in decimal.
    lda #$09
    sta ZERO_PAGE.TEMP // Store the number to subtract.
    jsr subtract8BitFrom16Bit // subtract $09 from the 16 bit number.

    // Example where an overflow unsets the carry flag.
    lda #$0F // 15 in decimal.
    sta ZERO_PAGE.PARAM_1 // Store the lowest byte first of the 16 bit number
    lda #$01
    sta ZERO_PAGE.PARAM_2 // Store the highest byte of the 16 bit number directly after the first.
    // The total number is $010F or 271 in decimal.
    lda #$10 // 16 in decimal.
    sta ZERO_PAGE.TEMP // Store the number to subtract.
    jsr subtract8BitFrom16Bit // subtract $10 from the 16 bit number.
    nop

    ///////////////////////
    // Multiplication
    ///////////////////////

    // Multiply a number by using rol.

    lda #$09 // Store the number to multiply. %00001001
    rol // Multiply by 2.
    rol // Multiply by 4.
    rol // Multiply by 8.

    lda #$09
    sta ZERO_PAGE.TEMP
    rol // Multiply by 2.
    clc
    adc ZERO_PAGE.TEMP // Multiply by 3 by multiplying by 2 and adding the original number.

    lda #$09
    rol
    rol //Multiply by 4.
    sta ZERO_PAGE.TEMP
    rol // Multiply by 8.
    adc ZERO_PAGE.TEMP // Multiply by 12 by multiplying by 8 and adding the original number.

    lda #$00
    sta ZERO_PAGE.PARAM_1
    sta ZERO_PAGE.PARAM_2

    lda #$09 // Store the number to multiply. %00001001
    sta ZERO_PAGE.PARAM_3
    lda #$03 // Store the number to multiply by. %00000011
    sta ZERO_PAGE.TEMP
    jsr multiply8BitBy8Bit // Multiply 9 by 3.
    
    lda #$00
    sta ZERO_PAGE.PARAM_1
    sta ZERO_PAGE.PARAM_2

    lda #$09 // Store the number to multiply. %00001001
    sta ZERO_PAGE.PARAM_3
    lda #$1E // Store the number to multiply by. %00011110
    sta ZERO_PAGE.TEMP
    jsr multiply8BitBy8Bit // Multiply 9 by 20 = 270 $010E.

.break
    nop
    
!loop:
    jmp !loop-

add8BitTo16Bit:
    clc // Clear the carry flag, this will be used to store the overflow of the addition.
    adc ZERO_PAGE.PARAM_1 // Add the lowest byte of the 16 bit number to what is in the accumulator.
    sta ZERO_PAGE.PARAM_1 // Store the result back in the lowest byte.
    bcc !carryNotSet+ // If the carry flag is not set, then the addition did not overflow so addition is complete.
    inc ZERO_PAGE.PARAM_1 + 1 // If the carry flag is set, then the addition overflowed and we need to increment the highest byte.
!carryNotSet:
    rts

// High btye should be stored in the X register, low byte should be stored in the accumulator.
add16BitTo16Bit:
    jsr add8BitTo16Bit
    clc
    txa
    adc ZERO_PAGE.PARAM_2 // Add the highest byte of the first 16 bit number to the accumulator.
    sta ZERO_PAGE.PARAM_2 // Store the result back in the highest byte.
    rts

subtract8BitFrom16Bit:
    sec // Set the carry flag, this will be used to store the overflow of the subtraction.
    lda ZERO_PAGE.PARAM_1
    sbc ZERO_PAGE.TEMP // Subtract the lowest byte of the 16 bit number from what is in the accumulator.
    sta ZERO_PAGE.PARAM_1 // Store the result back in the lowest byte.
    bcs !carrySet+ // If the carry flag is set, then the subtraction did not overflow so subtraction is complete.
    dec ZERO_PAGE.PARAM_1 + 1 // If the carry flag is set, then the subtraction overflowed and we need to decrement the highest byte.
!carrySet:
    rts

multiply8BitBy8Bit:
    lda ZERO_PAGE.PARAM_3
    jsr add8BitTo16Bit
    dec ZERO_PAGE.TEMP
    beq !done+
    jmp multiply8BitBy8Bit

!done:
    rts