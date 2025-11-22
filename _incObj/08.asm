; ===========================================================================
; ----------------------------------------------------------------------------
; Object 08 - Water splash in Aquatic Ruin Zone, Spindash dust
; ----------------------------------------------------------------------------

obj08_previous_frame = objoff_30
obj08_dust_timer = objoff_32

; Sprite_1DD20:
Splash:
	moveq	#0,d0
	move.b	routine(a0),d0
	move.w	Obj08_Index(pc,d0.w),d1
	jmp	Obj08_Index(pc,d1.w)
; ===========================================================================
; off_1DD2E:
Obj08_Index:
	dc.w Obj08_Init-Obj08_Index			; 0
	dc.w Obj08_Main-Obj08_Index			; 2
	dc.w BranchTo16_DeleteObject-Obj08_Index	; 4
	dc.w Obj08_CheckSkid-Obj08_Index		; 6
; ===========================================================================
; loc_1DD36:
Obj08_Init:
	addq.b	#2,routine(a0)
	move.l	#Map_Splash,mappings(a0)
	ori.b	#4,render_flags(a0)
	move.w	#1*$80,priority(a0)
	move.b	#$10,width_pixels(a0)
	move.w	#make_art_tile(ArtTile_ArtNem_SonicDust,0,0),art_tile(a0)
	move.w	#v_player,parent(a0)

; loc_1DD90:
Obj08_Main:
	movea.w	parent(a0),a2 ; a2=character
	moveq	#0,d0
	move.b	anim(a0),d0	; use current animation as a secondary routine counter
	add.w	d0,d0
	move.w	Obj08_DisplayModes(pc,d0.w),d1
	jmp	Obj08_DisplayModes(pc,d1.w)
; ===========================================================================
; off_1DDA4:
Obj08_DisplayModes:
	dc.w Obj08_Display-Obj08_DisplayModes	; 0
	dc.w Obj08_MdSplash-Obj08_DisplayModes	; 2
	dc.w Obj08_MdSpindashDust-Obj08_DisplayModes	; 4
	dc.w Obj08_MdSkidDust-Obj08_DisplayModes	; 6
; ===========================================================================
; loc_1DDAC:
Obj08_MdSplash:
	move.w	(v_waterpos1).w,y_pos(a0)
	tst.b	prev_anim(a0)
	bne.s	Obj08_Display
	move.w	x_pos(a2),x_pos(a0)
	clr.b	status(a0)
	andi.w	#drawing_mask,art_tile(a0)
	bra.s	Obj08_Display
; ===========================================================================
; loc_1DDCC:
Obj08_MdSpindashDust:
	cmpi.w	#12,(v_air).w
	blo.s	Obj08_ResetDisplayMode
	cmpi.b	#4,routine(a2)
	bhs.s	Obj08_ResetDisplayMode
	tst.b	spindash_flag(a2)
	beq.s	Obj08_ResetDisplayMode
	move.w	x_pos(a2),x_pos(a0)
	move.w	y_pos(a2),y_pos(a0)
	move.b	status(a2),status(a0)
	andi.b	#1,status(a0)
	tst.b	prev_anim(a0)
	bne.s	Obj08_Display
	andi.w	#drawing_mask,art_tile(a0)
	tst.w	art_tile(a2)
	bpl.s	Obj08_Display
	ori.w	#high_priority,art_tile(a0)
	bra.s	Obj08_Display
; ===========================================================================
; loc_1DE20:
Obj08_MdSkidDust:
	cmpi.w	#12,(v_air).w
	blo.s	Obj08_ResetDisplayMode

; loc_1DE28:
Obj08_Display:
	lea	Ani_obj08(pc),a1
	jsr	(AnimateSprite).w
	bsr.w	Obj08_LoadDustOrSplashArt
	jmp	(DisplaySprite).w
; ===========================================================================
; loc_1DE3E:
Obj08_ResetDisplayMode:
	clr.b	anim(a0)
	rts
; ===========================================================================

BranchTo16_DeleteObject ; BranchTo
	jmp	(DeleteObject).w
; ===========================================================================
; loc_1DE4A:
Obj08_CheckSkid:
	movea.w	parent(a0),a2 ; a2=character
	cmpi.b	#id_Stop,anim(a2)	; SonAni_Stop
	beq.s	Obj08_SkidDust
	move.b	#2,routine(a0)
	clr.b	obj08_dust_timer(a0)
	rts
; ===========================================================================
; loc_1DE64:
Obj08_SkidDust:
	subq.b	#1,obj08_dust_timer(a0)
	bpl.s	loc_1DEE0
	move.b	#3,obj08_dust_timer(a0)
	jsr	(FindFreeObj).w
	bne.s	loc_1DEE0
	_move.l	id(a0),id(a1) ; load obj08
	move.w	x_pos(a2),x_pos(a1)
	move.w	y_pos(a2),y_pos(a1)
	addi.w	#$10,y_pos(a1)
	clr.b	status(a1)
	move.b	#3,anim(a1)
	addq.b	#2,routine(a1)
	move.l	#Map_Splash,mappings(a1)
	move.b	render_flags(a0),render_flags(a1)
	move.w	#1*$80,priority(a1)
	move.b	#4,width_pixels(a1)
	move.w	#make_art_tile(ArtTile_ArtNem_SonicDust,0,0),art_tile(a1)
	move.w	parent(a0),parent(a1)
	andi.w	#drawing_mask,art_tile(a1)
	tst.w	art_tile(a2)
	bpl.s	loc_1DEE0
	ori.w	#high_priority,art_tile(a1)

loc_1DEE0:
; ===========================================================================
; loc_1DEE4:
Obj08_LoadDustOrSplashArt:
	moveq	#0,d0
	move.b	mapping_frame(a0),d0
	cmp.b	obj08_previous_frame(a0),d0
	beq.s	return_1DF36
	move.b	d0,obj08_previous_frame(a0)
	lea	Obj08_MapRUnc_1E074(pc),a2
	add.w	d0,d0
	adda.w	(a2,d0.w),a2
	move.w	(a2)+,d5
	bmi.s	return_1DF36
	move.w	#(ArtTile_ArtNem_SonicDust)*tile_size,d4
	move.l	#dmaSource(ArtUnc_SplashAndDust),d6

-	move.w	(a2)+,d3
	move.l	(a2)+,d1
	add.l	d6,d1
	move.w	d4,d2
	add.w	d3,d4
	add.w	d3,d4
	jsr	(QueueDMATransfer).w
	dbf	d5,-

return_1DF36:
	rts