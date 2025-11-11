; ---------------------------------------------------------------------------
; Object 10 - debug sonic animation test object
; ---------------------------------------------------------------------------

Obj10:
	if debugbuild
Obj10_Init:
		move.l	#Obj10_Main,(a0)
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)
		move.l	#Map_Sonic,obMap(a0)
		move.w	#make_art_tile(ArtTile_Sonic,0,0),obGfx(a0)
		move.w	#2*$80,obPriority(a0)
		move.b	#$18,obActWid(a0)
		move.b	#4,obRender(a0)
		move.b	#id_Wait,obAnim(a0)

Obj10_Main:
		moveq	#0,d4
		move.b	(v_jpadhold1).w,d4
		btst	#bitUp,d4	; is up pressed?
		beq.s	.notup	; if not, branch
		subq.w	#1,obY(a0)

.notup:
		btst	#bitDn,d4	; is down pressed?
		beq.s	.notdown	; if not, branch
		addq.w	#1,obY(a0)

.notdown:
		btst	#bitL,d4	; is left pressed?
		beq.s	.notleft	; if not, branch
		subq.w	#1,obX(a0)

.notleft:
		btst	#bitR,d4	; is right pressed?
		beq.s	.notright	; if not, branch
		addq.w	#1,obX(a0)

.notright:
		btst	#bitA,(v_jpadpress1).w	; is A pressed?
		bne.s	.chgtoplay00	; if yes, branch
		btst	#bitB,(v_jpadpress1).w	; is B pressed?
		beq.s	.notflip	; if not, branch
		move.b	obRender(a0),d0
		move.b	d0,d1
		addq.b	#1,d0
		andi.b	#3,d0
		andi.b	#$FC,d1
		or.b	d1,d0
		move.b	d0,obRender(a0)

.notflip:
		btst	#bitC,(v_jpadpress1).w	; is C pressed?
		beq.s	.notreset	; if not, branch
		addq.b	#1,obAnim(a0)	; increment animation ID
		cmpi.b	#id_Float4,obAnim(a0)	; is animation ID the last one?
		ble.s	.notreset	; if lower than or equal, do not reset to the first animation ID
		move.b	#id_Walk,obAnim(a0)	; set back to the first animation ID

.notreset:
		jsr	(DisplaySprite).w
		jsr	(Sonic_Animate).l
		jmp	(Sonic_LoadGfx).l

.chgtoplay00:
		move.l	#SonicPlayer,(a0)
		clr.b	obRoutine(a0)
		jsr	(DisplaySprite).w
		jsr	(Sonic_Animate).l
		jmp	(Sonic_LoadGfx).l
	else
		rts
	endif