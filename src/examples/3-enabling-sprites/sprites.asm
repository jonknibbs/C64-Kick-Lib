#importonce 
#import "../../lib/screen.asm"
#import "../../lib/sprite.asm"
#import "../../lib/kernal.asm"

BasicUpstart2(start)
*=$3000 "Program Start"

start:

    lda #BLACK
    sta SCREEN.SCREEN_COLOR
    jsr KERNAL.CLEAR_SCREEN

    MacroEnableSprite(0)
    lda #100
    sta SPRITE_0.X
    lda #100
    sta SPRITE_0.Y
    lda #$C8
    sta SPRITE_0.POINTER
    
    

!loop:
    lda SCREEN.RASTER_LINE
    cmp #$64
    bne !loop-
    inc SPRITE_0.Y
    jmp !loop-


*=$3200 "Sprite Data"
testSprite:
.byte $00,$3c,$00,$03,$c3,$c0,$06,$00
.byte $60,$0c,$00,$30,$08,$00,$10,$10
.byte $42,$10,$10,$42,$10,$10,$00,$08
.byte $20,$00,$08,$20,$00,$08,$11,$00
.byte $08,$11,$01,$10,$11,$83,$10,$18
.byte $c2,$10,$08,$6e,$10,$04,$38,$10
.byte $04,$00,$20,$04,$00,$20,$04,$00
.byte $60,$03,$ff,$c0,$00,$00,$00,$03