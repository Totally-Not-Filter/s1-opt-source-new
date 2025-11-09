; ---------------------------------------------------------------------------
; Subroutine to remember whether an object is destroyed/collected
; ---------------------------------------------------------------------------

RememberState:
		out_of_range.s	DeleteObject_Respawn
		bsr.s	Add_SpriteToCollisionResponseList
		bra.s	DisplaySprite

DeleteObject_Respawn:
		move.w	obRespawnNo(a0),d0
		beq.s	DeleteObject
		movea.w	d0,a2
		bclr	#7,(a2)