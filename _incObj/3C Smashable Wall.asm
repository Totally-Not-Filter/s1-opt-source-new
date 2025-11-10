; ---------------------------------------------------------------------------
; Object 3C - smashable wall (GHZ, SLZ)
; ---------------------------------------------------------------------------

SmashWall:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Smash_Index(pc,d0.w),d1
		jmp	Smash_Index(pc,d1.w)
; ===========================================================================
Smash_Index:	dc.w Smash_Main-Smash_Index
		dc.w Smash_Solid-Smash_Index
		dc.w Smash_FragMove-Smash_Index

smash_speed = objoff_30		; Sonic's horizontal speed
; ===========================================================================

Smash_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Smash,obMap(a0)
		move.w	#make_art_tile(ArtTile_GHZ_SLZ_Smashable_Wall,2,0),obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#$10,obActWid(a0)
		move.w	#4*$80,obPriority(a0)
		move.b	obSubtype(a0),obFrame(a0)

Smash_Solid:	; Routine 2
		move.w	(v_player+obVelX).w,smash_speed(a0) ; load Sonic's horizontal speed
		moveq	#$1B,d1
		moveq	#$20,d2
		moveq	#$20,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
		btst	#5,obStatus(a0)	; is Sonic pushing against the wall?
		bne.s	.chkroll	; if yes, branch

.donothing:
		out_of_range.s	.delete
		jmp	(DisplaySprite).w
.delete:
		jmp	(DeleteObject_Respawn).w
; ===========================================================================

.chkroll:
		cmpi.b	#id_Roll,obAnim(a1) ; is Sonic rolling?
		bne.s	.donothing	; if not, branch
		move.w	smash_speed(a0),d0
		bpl.s	.chkspeed
		neg.w	d0

.chkspeed:
		cmpi.w	#$480,d0	; is Sonic's speed $480 or higher?
		blo.s	.donothing	; if not, branch
		move.w	smash_speed(a0),obVelX(a1)
		addq.w	#4,obX(a1)
		lea	Smash_FragSpd1(pc),a4 ; use fragments that move right
		move.w	obX(a0),d0
		cmp.w	obX(a1),d0	; is Sonic to the right of the block?
		blo.s	.smash		; if yes, branch
		subq.w	#8,obX(a1)
		lea	Smash_FragSpd2(pc),a4 ; use fragments that move left

.smash:
		move.w	obVelX(a1),obInertia(a1)
		bclr	#5,obStatus(a0)
		bclr	#5,obStatus(a1)
		moveq	#7,d1		; load 8 fragments
		moveq	#$70,d2
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
		jsr	(SpeedToPos).w
		add.w	d2,obVelY(a0)
		movea.l	(sp)+,a0
		jsr	(DisplaySprite1).w

.loc_D268:
		dbf	d1,.loop

.playsnd:
		move.b	d6,(v_snddriver_ram.v_soundqueue1).w

Smash_FragMove:	; Routine 4
		jsr	(SpeedToPos).w
		addi.w	#$70,obVelY(a0)	; make fragment fall faster
		tst.b	obRender(a0)
		bpl.s	.delete
		jmp	(DisplaySprite).w
.delete:
		jmp	(DeleteObject).w