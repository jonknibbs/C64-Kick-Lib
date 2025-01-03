INTERRUPT: {
    .label EXECUTION_LOW = $0314
    .label EXECUTION_HIGH = $0315
    .label STATUS = $D019   
    .label SYS_IRQ_HANDLER = $EA31
    .label RASTER_SPRITE_INT_REG = $D01A
    .label RASTER_LINE_MSB = $D011
    .label RASTER_LINE = $D012
    .label REG = $DC0D
}


.var SCREEN_MULTICOLOUR = $D016
.label JPORT_2 = $DC00
.label RANDOM = $D41B