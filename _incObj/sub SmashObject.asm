; ---------------------------------------------------------------------------
; Subroutine to smash a block (GHZ walls and MZ blocks)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


SmashObject:
		moveq	#0,d0
		move.b	obFrame(a0),d0
		add.w	d0,d0
		movea.l	obMap(a0),a3
		adda.w	(a3,d0.w),a3
		addq.w	#2,a3
		bset	#5,obRender(a0)
		_move.l	obID(a0),d4
		move.b	obRender(a0),d5
		movea.l	a0,a1
		moveq	#sfx_WallSmash,d6
		bra.s	.loadfrag
; ===========================================================================

.loop:
		lea	(v_lvlobjspace).w,a1 ; start address for object RAM
		moveq	#(v_lvlobjend-v_lvlobjspace)/object_size-1,d0

.ffree_loop:
		lea	object_size(a1),a1	; goto next object RAM slot
		tst.l	obID(a1)		; is object RAM slot empty?
		dbeq	d0,.ffree_loop	; repeat $5F times
		addq.w	#6,a3

.loadfrag:
		move.b	#4,obRoutine(a1)
		_move.l	d4,obID(a1)
		move.l	a3,obMap(a1)
		move.b	d5,obRender(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	obGfx(a0),obGfx(a1)
		move.w	obPriority(a0),obPriority(a1)
		move.b	obActWid(a0),obActWid(a1)
		move.l	(a4)+,obVelX(a1)
		cmpa.l	a0,a1
		bhs.s	.loc_D268
		move.l	a0,-(sp)
		movea.l	a1,a0
		jsr	(SpeedToPos).l
		add.w	d2,obVelY(a0)
		movea.l	(sp)+,a0
		jsr	(DisplaySprite1).l

.loc_D268:
		dbf	d1,.loop

.playsnd:
		move.b	d6,(v_snddriver_ram.v_soundqueue1).w
		rts

; End of function SmashObject
