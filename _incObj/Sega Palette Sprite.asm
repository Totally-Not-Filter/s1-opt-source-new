; ---------------------------------------------------------------------------
; Object - sega palette sprite
; ---------------------------------------------------------------------------

SegaPaletteSprite:
; Routine 0
		move.l	#.move,(a0)
		move.l	#SegaPaletteMap,obMap(a0)
		move.w	#make_art_tile(ArtTile_Sega_Tiles,0,0),obGfx(a0)
		move.w	#0*$80,obPriority(a0)
		move.b	#4,obRender(a0)
		lea	obX(a0),a2
		move.w	#32,(a2)
		move.w	#112,obY(a0)

.move:
		addq.w	#4,(a2)
		cmpi.w	#320-40,(a2)
		bge.s	.delete
		jmp	(DisplaySprite).w

.delete:
		jmp	(DeleteObject).w