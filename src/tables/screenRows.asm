// Lookup table used for fast interaction with the screen.
 
.var screenMemory=$0400
.var columns=25

SCREEN_TABLE: {
    LOW:
    .for (var i=0;i<columns;i++){
        .byte <screenMemory + (i *40)
    }

    HIGH:
    .for (var i=0;i<columns;i++){
        .byte >screenMemory + (i *40)
    }
}
