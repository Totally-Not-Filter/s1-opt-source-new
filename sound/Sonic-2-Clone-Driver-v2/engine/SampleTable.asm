
; ---------------------------------------------------------------
SampleTable:
	;			type			pointer		Hz
ptr_dac81:	dcSample	TYPE_DPCM, 		Kick, 		8000				; $81
ptr_dac82:	dcSample	TYPE_DPCM,		Snare,		16500				; $82
ptr_dac85:	dcSample	TYPE_DPCM, 		Timpani, 	7250				; $85
ptr_dac88:	dcSample	TYPE_DPCM, 		Timpani, 	9750				; $88
ptr_dac89:	dcSample	TYPE_DPCM, 		Timpani, 	8750				; $89
ptr_dac8A:	dcSample	TYPE_DPCM, 		Timpani, 	7150				; $8A
ptr_dac8B:	dcSample	TYPE_DPCM, 		Timpani, 	7000				; $8B
ptr_dacE0:	dcSample	TYPE_PCM, 		SegaPCM, 	24000				; $E0
	dc.w	-1	; end marker

; ---------------------------------------------------------------
	incdac	Kick, "sound/Sonic-2-Clone-Driver-v2/dac/dpcm/kick.bin"
	incdac	Snare, "sound/Sonic-2-Clone-Driver-v2/dac/dpcm/snare.bin"
	incdac	Timpani, "sound/Sonic-2-Clone-Driver-v2/dac/dpcm/timpani.bin"
	incdac	SegaPCM, "sound/Sonic-2-Clone-Driver-v2/dac/pcm/sega.raw"
	even
