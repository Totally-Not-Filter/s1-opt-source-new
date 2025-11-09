; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 4 bytes per iteration
bytesToLcnt function n,n>>2-1

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 2 bytes per iteration
bytesToWcnt function n,n>>1-1

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at x bytes per iteration
bytesToXcnt function n,x,n/x-1

; ---------------------------------------------------------------------------
; Set a VRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is vdp_control_port)
; ---------------------------------------------------------------------------

locVRAM:	macro loc,controlport=vdp_control_port
		move.l	#($40000000+(((loc)&$3FFF)<<16)+(((loc)&$C000)>>14)),controlport
		endm

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the VRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeVRAM:	macro source,destination
		lea	vdp_control_port,a5
		move.l	#$94000000+((((source_end-source)>>1)&$FF00)<<8)+$9300+(((source_end-source)>>1)&$FF),(a5)
		move.l	#$96000000+(((source>>1)&$FF00)<<8)+$9500+((source>>1)&$FF),(a5)
		move.w	#$9700+((((source>>1)&$FF0000)>>16)&$7F),(a5)
		move.w	#$4000+((destination)&$3FFF),(a5)
		move.w	#$80+(((destination)&$C000)>>14),v_vdp_buffer2.w
		move.w	v_vdp_buffer2.w,(a5)
		endm

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the VRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeVRAMsrcdefined:	macro source,destination
		move.l	#$94000000+((((source_end-source)>>1)&$FF00)<<8)+$9300+(((source_end-source)>>1)&$FF),(a5)
		move.l	#$96000000+(((source>>1)&$FF00)<<8)+$9500+((source>>1)&$FF),(a5)
		move.w	#$9700+((((source>>1)&$FF0000)>>16)&$7F),(a5)
		move.w	#$4000+((destination)&$3FFF),(a5)
		move.w	#$80+(((destination)&$C000)>>14),v_vdp_buffer2.w
		move.w	v_vdp_buffer2.w,(a5)
		endm

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the CRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeCRAM:	macro source,destination
		lea	vdp_control_port,a5
		move.l	#$94000000+((((source_end-source)>>1)&$FF00)<<8)+$9300+(((source_end-source)>>1)&$FF),(a5)
		move.l	#$96000000+(((source>>1)&$FF00)<<8)+$9500+((source>>1)&$FF),(a5)
		move.w	#$9700+((((source>>1)&$FF0000)>>16)&$7F),(a5)
		move.w	#$C000+(destination&$3FFF),(a5)
		move.w	#$80+((destination&$C000)>>14),v_vdp_buffer2.w
		move.w	v_vdp_buffer2.w,(a5)
		endm

; ---------------------------------------------------------------------------
; DMA fill VRAM with a value
; input: value, length, destination
; ---------------------------------------------------------------------------

fillVRAM:	macro byte,start,end
		lea	vdp_control_port,a5
		move.w	#$8F01,(a5) ; Set increment to 1, since DMA fill writes bytes
		move.l	#$94000000+((((end)-(start)-1)&$FF00)<<8)+$9300+(((end)-(start)-1)&$FF),(a5)
		move.w	#$9780,(a5)
		move.l	#$40000080+(((start)&$3FFF)<<16)+(((start)&$C000)>>14),(a5)
		move.w	#(byte)|(byte)<<8,vdp_data_port
.wait:		move.w	(a5),d1
		btst	#1,d1
		bne.s	.wait
		move.w	#$8F02,(a5) ; Set increment back to 2, since the VDP usually operates on words
		endm

; ---------------------------------------------------------------------------
; Fill portion of RAM with 0
; input: start, end
; ---------------------------------------------------------------------------

clearRAM:	macro startAddress,endAddress
	if "endAddress"<>""
.length := (endAddress)-(startAddress)
	else
.length := startAddress_end-startAddress
	endif
		lea	startAddress.w,a1
		moveq	#0,d0
		move.w	#bytesToLcnt(.length),d1

.loop:
		move.l	d0,(a1)+
		dbf	d1,.loop

	if (endAddress-startAddress)&2
		move.w	d0,(a1)+
	endif

	if (endAddress-startAddress)&1
		move.b	d0,(a1)+
	endif
		endm

; ---------------------------------------------------------------------------
; Copy a tilemap from 68K (ROM/RAM) to the VRAM without using DMA
; input: source, destination, width [cells], height [cells]
; ---------------------------------------------------------------------------

copyTilemap:	macro source,destination,width,height
		lea	source.l,a1
		locVRAM	destination,d0
		moveq	#(width)-1,d1
		moveq	#(height)-1,d2
		bsr.w	TilemapToVRAM
		endm

; ---------------------------------------------------------------------------
; Copy a tilemap from 68K (ROM/RAM) to the VRAM without using DMA
; input: source, destination, width [cells], height [cells]
; ---------------------------------------------------------------------------

copyTilemap_End:	macro source,destination,width,height
		lea	source.l,a1
		locVRAM	destination,d0
		moveq	#(width)-1,d1
		moveq	#(height)-1,d2
		bra.w	TilemapToVRAM
		endm

; ---------------------------------------------------------------------------
; stop the Z80
; ---------------------------------------------------------------------------

stopZ80:	macro
		move.w	#$100,z80_bus_request
		endm

; ---------------------------------------------------------------------------
; wait for Z80 to stop
; ---------------------------------------------------------------------------

waitZ80:	macro
.wait:	btst	#0,z80_bus_request
		bne.s	.wait
		endm

; ---------------------------------------------------------------------------
; reset the Z80
; ---------------------------------------------------------------------------

deassertZ80Reset:	macro
		move.w	#$100,z80_reset
		endm

assertZ80Reset:	macro
		move.w	#0,z80_reset
		endm

; ---------------------------------------------------------------------------
; start the Z80
; ---------------------------------------------------------------------------

startZ80:	macro
		move.w	#0,z80_bus_request
		endm

; ---------------------------------------------------------------------------
; disable interrupts
; ---------------------------------------------------------------------------

disable_ints:	macro
		move	#$2700,sr
		endm

; ---------------------------------------------------------------------------
; enable interrupts
; ---------------------------------------------------------------------------

enable_ints:	macro
		move	#$2300,sr
		endm

; ---------------------------------------------------------------------------
; check if object moves out of range
; input: location to jump to if out of range, x-axis pos (obX(a0) by default)
; ---------------------------------------------------------------------------

out_of_range:	macro exit,specpos
		moveq	#-$80,d0	; round down to nearest $80
		if ("specpos"<>"")
		and.w	specpos,d0	; get object position (if specified as not obX)
		else
		and.w	obX(a0),d0	; get object position
		endif
		sub.w	Camera_X_pos_coarse_back.w,d0	; approx distance between object and screen
		cmpi.w	#128+320+192,d0
		bhi.ATTRIBUTE	exit
		endm

; ---------------------------------------------------------------------------
; bankswitch between SRAM and ROM
; (remember to enable SRAM in the header first!)
; ---------------------------------------------------------------------------

gotoSRAM:	macro
		move.b	#1,sram_port
		endm

gotoROM:	macro
		move.b	#0,sram_port
		endm

; ---------------------------------------------------------------------------
; compare the size of an index with ZoneCount constant
; (should be used immediately after the index)
; input: index address, element size
; ---------------------------------------------------------------------------

zonewarning:	macro loc,elementsize
._end:
		if (._end-loc)-(ZoneCount*elementsize)<>0
		warning "Size of loc (\{(._end-loc)/elementsize}) does not match ZoneCount (\{ZoneCount})."
		endif
		endm

; ---------------------------------------------------------------------------
ResetDMAQueue macro
	move.w	#VDP_Command_Buffer,VDP_Command_Buffer_Slot.w
	endm

; ---------------------------------------------------------------------------
	ifndef intMacros_defined
intMacros_defined = 1
enableInts macro
	move	#$2300,sr
	endm

disableInts macro
	move	#$2700,sr
	endm
	endif
; ---------------------------------------------------------------------------
	ifndef DMAEntry_defined
DMAEntry_defined = 1
DMAEntry STRUCT DOTS
Reg94:		ds.b	1
Size:
SizeH:		ds.b	1
Reg93:		ds.b	1
Source:
SizeL:		ds.b	1
Reg97:		ds.b	1
SrcH:		ds.b	1
Reg96:		ds.b	1
SrcM:		ds.b	1
Reg95:		ds.b	1
SrcL:		ds.b	1
Command:	ds.l	1
DMAEntry	ENDSTRUCT
	endif
; ---------------------------------------------------------------------------
	ifndef DMAfunctions_defined
		equ	DMAfunctions_defined,1
dmaSource function addr,((addr>>1)&$7FFFFF)
dmaLength function len,((len>>1)&$7FFF)
	endif

; ---------------------------------------------------------------------------
QueueSlotCount = (VDP_Command_Buffer_Slot-VDP_Command_Buffer)/DMAEntry.len

InitDMAQueue macro
	lea	VDP_Command_Buffer.w,a0
	moveq	#-$6C,d0				; fast-store $94 (sign-extended) in d0
	move.l	#$93979695,d1
	set	.c,0
	rept QueueSlotCount
		move.b	d0,.c + DMAEntry.Reg94(a0)
		movep.l	d1,.c + DMAEntry.Reg93(a0)
		set	.c,.c + DMAEntry.len
	endm
	ResetDMAQueue
	endm

; ---------------------------------------------------------------------------
; produce a packed art-tile
; ---------------------------------------------------------------------------

make_art_tile function addr,pal,pri,((pri&1)<<15)|((pal&3)<<13)|addr
tiles_to_bytes function addr,((addr&$7FF)<<5)

; ---------------------------------------------------------------------------
; sprite mappings and DPLCs macros
; ---------------------------------------------------------------------------

SonicMappingsVer = 3
		include	"_maps/MapMacros.asm"
