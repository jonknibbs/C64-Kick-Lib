
BasicUpstart2(helloWorld)
*=$3000 "Hello World"

helloWorld:
    lda message
    ldx #0

    lda message, x
loop:
    sta $0400, x
    inx
    lda message, x
    cmp #0
    bne loop


message:
    .text "hello world"
    .byte 0
