SCREEN: {
    .label BORDER_COLOR = $D020
	.label SCREEN_COLOR = $D021

    .label SCREEN_MEMORY = $0400          // Default area of screen memory $0400-$07E7
    .label SCREEN_CHARACTER_COLOR = $D800 // Color RAM $D800-$DBE7

    .label RASTER_LINE = $D012            // Current raser line bits 0-7
	.label RASTER_LINE_MSB = $D011        // bit 7 is MSB for the current raser line
}