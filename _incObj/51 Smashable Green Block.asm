; ---------------------------------------------------------------------------
; Object 51 - smashable green block (MZ)
; ---------------------------------------------------------------------------

SmashBlock:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Smab_Index(pc,d0.w),d1
		jmp	Smab_Index(pc,d1.w)
; ===========================================================================
Smab_Index:	dc.w Smab_Main-Smab_Index
		dc.w Smab_Solid-Smab_Index
		dc.w Smab_Points-Smab_Index
; ===========================================================================

Smab_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Smab,obMap(a0)
		move.w	#make_art_tile(ArtTile_MZ_Block,2,0),obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#$10,obActWid(a0)
		move.w	#4*$80,obPriority(a0)
		move.b	obSubtype(a0),obFrame(a0)

Smab_Solid:	; Routine 2

sonicAniFrame = objoff_32		; Sonic's current animation number
.count = objoff_34		; number of blocks hit + previous stuff

		move.w	(v_itembonus).w,objoff_34(a0)
		move.b	(v_player+obAnim).w,sonicAniFrame(a0) ; load Sonic's animation number
		moveq	#$1B,d1
		moveq	#$10,d2
		moveq	#$11,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
		btst	#3,obStatus(a0)	; has Sonic landed on the block?
		bne.s	.smash		; if yes, branch

.notspinning:
		out_of_range.s	.delete
		jmp	(DisplaySprite).w
.delete:
		jmp	(DeleteObject_Respawn).w
; ===========================================================================

.smash:
		cmpi.b	#id_Roll,sonicAniFrame(a0) ; is Sonic rolling/jumping?
		bne.s	.notspinning	; if not, branch
		move.w	.count(a0),(v_itembonus).w
		bset	#2,obStatus(a1)
		move.b	#$E,obHeight(a1)
		move.b	#7,obWidth(a1)
		move.b	#id_Roll,obAnim(a1) ; make Sonic roll
		move.w	#-$300,obVelY(a1) ; rebound Sonic
		bset	#1,obStatus(a1)
		bclr	#3,obStatus(a1)
		move.b	#2,obRoutine(a1)
		bclr	#3,obStatus(a0)
		clr.b	obSolid(a0)
		move.b	#1,obFrame(a0)
		lea	Smab_Speeds(pc),a4 ; load broken fragment speed data
		moveq	#3,d1		; set number of fragments to 4
		moveq	#$38,d2
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
		move.w	d6,(v_snddriver_ram.v_soundqueue1).w
		bsr.w	FindFreeObj
		bne.s	Smab_Points
		_move.l	#Points,obID(a1) ; load points object
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	(v_itembonus).w,d2
		addq.w	#2,(v_itembonus).w ; increment bonus counter
		cmpi.w	#6,d2		; have fewer than 3 blocks broken?
		blo.s	.bonus		; if yes, branch
		moveq	#6,d2		; set cap for points

.bonus:
		moveq	#0,d0
		move.w	Smab_Scores(pc,d2.w),d0
		cmpi.w	#$20,(v_itembonus).w ; have 16 blocks been smashed?
		blo.s	.givepoints	; if not, branch
		move.w	#1000,d0	; give higher points for 16th block
		moveq	#10,d2

.givepoints:
		jsr	(AddPoints).l
		lsr.w	#1,d2
		move.b	d2,obFrame(a1)

Smab_Points:	; Routine 4
		jsr	(ObjectFall).w
		tst.b	obRender(a0)
		bpl.s	.delete
		jmp	(DisplaySprite).w
.delete:
		jmp	(DeleteObject).w
; ===========================================================================
Smab_Speeds:	dc.w -$200, -$200	; x-speed, y-speed
		dc.w -$100, -$100
		dc.w $200, -$200
		dc.w $100, -$100

Smab_Scores:	dc.w 10, 20, 50, 100
