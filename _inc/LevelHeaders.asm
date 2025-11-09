; ---------------------------------------------------------------------------
; Level Headers
; ---------------------------------------------------------------------------

LevelHeaders:

lhead:	macro plc1,lvlgfx,plc2,sixteen,onetwoeight,pal
	dc.l (plc1<<24)+lvlgfx
	dc.l (plc2<<24)+sixteen
	dc.l onetwoeight
	dc.b pal, 0, 0, 0
	endm

; 1st PLC, level gfx (unused), 2nd PLC, 16x16 data, 128x128 data, palette

;		1st PLC				2nd PLC				128x128 data
;				level gfx*			16x16 data					palette

	lhead	plcid_GHZ,	KosPM_GHZ_2nd,	plcid_GHZ2,	Blk16_GHZ,	Blk128_GHZ,	palid_GHZ	; Green Hill Act 1
	lhead	plcid_GHZ,	KosPM_GHZ_2nd,	plcid_GHZ2,	Blk16_GHZ,	Blk128_GHZ,	palid_GHZ	; Green Hill Act 2
	lhead	plcid_GHZ,	KosPM_GHZ_2nd,	plcid_GHZ2,	Blk16_GHZ,	Blk128_GHZ,	palid_GHZ	; Green Hill Act 3
	lhead	plcid_GHZ,	KosPM_GHZ_2nd,	plcid_GHZ2,	Blk16_GHZ,	Blk128_GHZ,	palid_GHZ	; Green Hill Act 4
	lhead	plcid_LZ,	KosPM_LZ,		plcid_LZ2,	Blk16_LZ,	Blk128_LZ,	palid_LZ	; Labyrinth Act 1
	lhead	plcid_LZ,	KosPM_LZ,		plcid_LZ2,	Blk16_LZ,	Blk128_LZ,	palid_LZ	; Labyrinth Act 2
	lhead	plcid_LZ,	KosPM_LZ,		plcid_LZ2,	Blk16_LZ,	Blk128_LZ,	palid_LZ	; Labyrinth Act 3
	lhead	plcid_LZ,	KosPM_LZ,		plcid_LZ2,	Blk16_LZ,	Blk128_LZ,	palid_SBZ3	; Labyrinth Act 4
	lhead	plcid_MZ,	KosPM_MZ,		plcid_MZ2,	Blk16_MZ,	Blk128_MZ,	palid_MZ	; Marble Act 1
	lhead	plcid_MZ,	KosPM_MZ,		plcid_MZ2,	Blk16_MZ,	Blk128_MZ,	palid_MZ	; Marble Act 2
	lhead	plcid_MZ,	KosPM_MZ,		plcid_MZ2,	Blk16_MZ,	Blk128_MZ,	palid_MZ	; Marble Act 3
	lhead	plcid_MZ,	KosPM_MZ,		plcid_MZ2,	Blk16_MZ,	Blk128_MZ,	palid_MZ	; Marble Act 4
	lhead	plcid_SLZ,	KosPM_SLZ,	plcid_SLZ2,	Blk16_SLZ,	Blk128_SLZ,	palid_SLZ	; Star Light Act 1
	lhead	plcid_SLZ,	KosPM_SLZ,	plcid_SLZ2,	Blk16_SLZ,	Blk128_SLZ,	palid_SLZ	; Star Light Act 2
	lhead	plcid_SLZ,	KosPM_SLZ,	plcid_SLZ2,	Blk16_SLZ,	Blk128_SLZ,	palid_SLZ	; Star Light Act 3
	lhead	plcid_SLZ,	KosPM_SLZ,	plcid_SLZ2,	Blk16_SLZ,	Blk128_SLZ,	palid_SLZ	; Star Light Act 4
	lhead	plcid_SYZ,	KosPM_SYZ,	plcid_SYZ2,	Blk16_SYZ,	Blk128_SYZ,	palid_SYZ	; Spring Yard Act 1
	lhead	plcid_SYZ,	KosPM_SYZ,	plcid_SYZ2,	Blk16_SYZ,	Blk128_SYZ,	palid_SYZ	; Spring Yard Act 2
	lhead	plcid_SYZ,	KosPM_SYZ,	plcid_SYZ2,	Blk16_SYZ,	Blk128_SYZ,	palid_SYZ	; Spring Yard Act 3
	lhead	plcid_SYZ,	KosPM_SYZ,	plcid_SYZ2,	Blk16_SYZ,	Blk128_SYZ,	palid_SYZ	; Spring Yard Act 4
	lhead	plcid_SBZ,	KosPM_SBZ,	plcid_SBZ2,	Blk16_SBZ,	Blk128_SBZ,	palid_SBZ1	; Scrap Brain Act 1
	lhead	plcid_SBZ,	KosPM_SBZ,	plcid_SBZ2,	Blk16_SBZ,	Blk128_SBZ,	palid_SBZ2	; Scrap Brain Act 2
	lhead	plcid_SBZ,	KosPM_SBZ,	plcid_SBZ2,	Blk16_SBZ,	Blk128_SBZ,	palid_SBZ2	; Scrap Brain Act 3
	lhead	plcid_SBZ,	KosPM_SBZ,	plcid_SBZ2,	Blk16_SBZ,	Blk128_SBZ,	palid_SBZ1	; Scrap Brain Act 4
	zonewarning LevelHeaders,$40
	lhead	0,		KosPM_GHZ_2nd,	0,		Blk16_GHZ,	Blk128_GHZ,	palid_Ending	; Ending Act 1
	lhead	0,		KosPM_GHZ_2nd,	0,		Blk16_GHZ,	Blk128_GHZ,	palid_Ending	; Ending Act 2
	lhead	0,		KosPM_GHZ_2nd,	0,		Blk16_GHZ,	Blk128_GHZ,	palid_Ending	; Ending Act 3
	lhead	0,		KosPM_GHZ_2nd,	0,		Blk16_GHZ,	Blk128_GHZ,	palid_Ending	; Ending Act 4
	even

;	* level gfx are actually set elsewhere, so these values are useless (for now)
