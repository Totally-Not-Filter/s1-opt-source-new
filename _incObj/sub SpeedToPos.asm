; ---------------------------------------------------------------------------
; Subroutine translating object speed to update object position
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


SpeedToPos:
		movem.w	obVelX(a0),d0/d2	; load horizontal/vertical speed
		lsl.l	#8,d0		; multiply speed by $100
		add.l	d0,obX(a0)	; add to x-axis position
		lsl.l	#8,d2		; multiply by $100
		add.l	d2,obY(a0)	; add to y-axis position
		rts

; End of function SpeedToPos

SpeedToPosX:
		move.l	obVelX(a0),d0	; load horizontal speed
		add.l	d0,obX(a0)	; add to x-axis position
		rts

SpeedToPosY:
		move.w	obVelY(a0),d0	; load vertical speed
		ext.l	d0
		lsl.l	#8,d0		; multiply by $100
		add.l	d0,obY(a0)	; add to y-axis position
		rts