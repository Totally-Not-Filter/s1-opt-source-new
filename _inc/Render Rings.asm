; ---------------------------------------------------------------------------
; Subroutine to draw on-screen rings
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_17178:
BuildRings:
		movea.l	(Ring_start_addr_ROM).w,a0
		move.l	(Ring_end_addr_ROM).w,d2
		sub.l	a0,d2		; are there any rings on-screen?
		beq.s	++		; if there aren't, branch
		movea.w	(Ring_start_addr_RAM).w,a4	; load start address
		move.w	4(a3),d4
		move.w	#$F0,d5
		move.w	#$7FF,d3

BuildRings_Loop:
		tst.w	(a4)+		; has this ring been consumed?
		bmi.s	BuildRings_NextRing	; if it has, branch
		move.w	2(a0),d1		; get ring X pos
		sub.w	d4,d1		; subtract camera X pos
		addq.w	#8,d1
		and.w	d3,d1
		cmp.w	d5,d1
		bhs.s	BuildRings_NextRing	; if the ring is not on-screen, branch
		addi.w	#128-8,d1
		move.w	(a0),d0
		sub.w	(a3),d0
		addi.w	#128,d0
		move.b	-1(a4),d6	; get ring frame
		bne.s	+		; if this ring is using a specific frame, branch
		move.b	(v_ani1_frame).w,d6	; use global frame
+
		lsl.w	#3,d6
		lea	MapUnc_Rings(pc,d6.w),a2	; get frame data address
		add.w	(a2)+,d1	; get Y offset
		move.w	d1,(a6)+
		move.w	(a2)+,d6
		move.b	d6,(a6)
		addq.w	#2,a6
		move.w	(a2)+,(a6)+
		add.w	(a2)+,d0
		move.w	d0,(a6)+
		subq.w	#1,d7
; loc_171EC:
BuildRings_NextRing:
		addq.w	#4,a0
		subq.w	#4,d2
		bne.s	BuildRings_Loop
+
		rts

; -------------------------------------------------------------------------------
; sprite mappings
; -------------------------------------------------------------------------------

; off_1736A:
MapUnc_Rings:;frame1:
		dc.w -8
		dc.w 5
		dc.w 0+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame2:
		dc.w -8
		dc.w 5
		dc.w 4+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame3:
		dc.w -8
		dc.w 1
		dc.w 8+make_art_tile(ArtTile_Ring,1,0)
		dc.w -4

;frame4:
		dc.w -8
		dc.w 5
		dc.w $804+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame5:
		dc.w -8
		dc.w 5
		dc.w $A+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame6:
		dc.w -8
		dc.w 5
		dc.w $180A+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame7:
		dc.w -8
		dc.w 5
		dc.w $80A+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame8:
		dc.w -8
		dc.w 5
		dc.w $100A+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8