; ---------------------------------------------------------------------------
; Object 49 - waterfall sound effect (GHZ)
; ---------------------------------------------------------------------------

WaterSound:
;		moveq	#0,d0
;		move.b	obRoutine(a0),d0
;		move.w	WSnd_Index(pc,d0.w),d1
;		jmp	WSnd_Index(pc,d1.w)
; ===========================================================================
;WSnd_Index:	dc.w WSnd_Main-WSnd_Index
;		dc.w WSnd_PlaySnd-WSnd_Index
; ===========================================================================

WSnd_Main:	; Routine 0
		move.l	#WSnd_PlaySnd,(a0)
		move.b	#4,obRender(a0)

WSnd_PlaySnd:	; Routine 2
		moveq	#$3F,d0
		and.b	(v_vbla_byte).w,d0 ; get low byte of VBlank counter
		bne.s	WSnd_ChkDel
		move.w	#sfx_Waterfall,(v_snddriver_ram.v_soundqueue2).w

WSnd_ChkDel:
		out_of_range.s	.delete
		rts

.delete:
		jmp	(DeleteObject_Respawn).w