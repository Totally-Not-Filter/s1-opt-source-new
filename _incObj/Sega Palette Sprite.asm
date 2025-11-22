; ---------------------------------------------------------------------------
; Object - sega palette sprite
; ---------------------------------------------------------------------------

SegaPaletteSprite:
; Routine 0
		move.l	#.move,(a0)
		move.l	#SegaPaletteMap,obMap(a0)
		move.w	#make_art_tile(ArtTile_Sega_Tiles,1,0),obGfx(a0)
		lea	obX(a0),a2
		move.w	#160,(a2)
		move.w	#240,obScreenY(a0)

.move:
		addq.w	#4,(a2)
		cmpi.w	#400,(a2)
		bge.s	.delete
		jmp	(DisplaySprite).w

.delete:
		jmp	(DeleteObject).w