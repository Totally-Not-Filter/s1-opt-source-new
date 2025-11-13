; ---------------------------------------------------------------------------
; Object - sega palette sprite
; ---------------------------------------------------------------------------

SegaPaletteSprite:
; Routine 0
		move.l	#.move,(a0)
		move.l	#Map_Sonic,obMap(a0)
		move.w	#make_art_tile(ArtTile_Sonic,1,0),obGfx(a0)
		move.w	#0*$80,obPriority(a0)
		move.b	#4,obRender(a0)
		move.w	#32,obX(a0)
		move.w	#112,obScreenY(a0)
		move.b	#fr_Wait1,obFrame(a0)

.move:
		addq.w	#8,obX(a0)
		jmp	(DisplaySprite).w