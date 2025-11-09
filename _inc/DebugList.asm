; ---------------------------------------------------------------------------
; Debug mode item lists
; ---------------------------------------------------------------------------
DebugList:
	dc.w .GHZ-DebugList
	dc.w .LZ-DebugList
	dc.w .MZ-DebugList
	dc.w .SLZ-DebugList
	dc.w .SYZ-DebugList
	dc.w .SBZ-DebugList
	zonewarning DebugList,2
	dc.w .Ending-DebugList

dbug:	macro map,object,subtype,frame,vram
	dc.l object+(frame<<24)
	dc.l map+(subtype<<24)
	dc.w vram
	endm

.GHZ:
	dc.w (.GHZend-.GHZ-2)/$A

;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	Rings,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug	Map_Monitor,	Monitor,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug	Map_Crab,	Crabmeat,	0,	0,	make_art_tile(ArtTile_Crabmeat,0,0)
	dbug	Map_Buzz,	BuzzBomber,	0,	0,	make_art_tile(ArtTile_Buzz_Bomber,0,0)
	dbug	Map_Chop,	Chopper,	0,	0,	make_art_tile(ArtTile_Chopper,0,0)
	dbug	Map_Spike,	Spikes,	0,	0,	make_art_tile(ArtTile_Spikes,0,0)
	dbug	Map_Plat_GHZ,	BasicPlatform, 0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug	Map_PRock,	PurpleRock,	0,	0,	make_art_tile(ArtTile_GHZ_Purple_Rock,3,0)
	dbug	Map_Moto,	MotoBug,	0,	0,	make_art_tile(ArtTile_Moto_Bug,0,0)
	dbug	Map_Spring,	Springs,	0,	0,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug	Map_Newt,	Newtron,	0,	0,	make_art_tile(ArtTile_Newtron,1,0)
	dbug	Map_Edge,	EdgeWalls,	0,	0,	make_art_tile(ArtTile_GHZ_Edge_Wall,2,0)
	dbug	Map_GBall,	Obj19,	0,	0,	make_art_tile(ArtTile_GHZ_Giant_Ball,2,0)
	dbug	Map_Lamp,	Lamppost,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
	dbug	Map_GRing,	GiantRing,	0,	0,	make_art_tile(ArtTile_Giant_Ring,1,0)
	dbug	Map_Bonus,	HiddenBonus,	1,	1,	make_art_tile(ArtTile_Hidden_Points,0,1)
.GHZend:

.LZ:
	dc.w (.LZend-.LZ-2)/$A

;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	Rings,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug	Map_Monitor,	Monitor,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug	Map_Spring,	Springs,	0,	0,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug	Map_Jaws,	Jaws,	8,	0,	make_art_tile(ArtTile_Jaws,1,0)
	dbug	Map_Burro,	Burrobot,	0,	2,	make_art_tile(ArtTile_Burrobot,0,1)
	dbug	Map_Harp,	Harpoon,	0,	0,	make_art_tile(ArtTile_LZ_Harpoon,0,0)
	dbug	Map_Harp,	Harpoon,	2,	3,	make_art_tile(ArtTile_LZ_Harpoon,0,0)
	dbug	Map_Push,	PushBlock,	0,	0,	make_art_tile(ArtTile_LZ_Push_Block,2,0)
	dbug	Map_But,	Button,	0,	0,	make_art_tile(ArtTile_Button+4,0,0)
	dbug	Map_Spike,	Spikes,	0,	0,	make_art_tile(ArtTile_Spikes,0,0)
	dbug	Map_MBlockLZ,	MovingBlock,	4,	0,	make_art_tile(ArtTile_LZ_Moving_Block,2,0)
	dbug	Map_LBlock,	LabyrinthBlock, 1,	0,	make_art_tile(ArtTile_LZ_Blocks,2,0)
	dbug	Map_LBlock,	LabyrinthBlock, $13,	1,	make_art_tile(ArtTile_LZ_Blocks,2,0)
	dbug	Map_LBlock,	LabyrinthBlock, 5,	0,	make_art_tile(ArtTile_LZ_Blocks,2,0)
    if FixBugs
	dbug	Map_Gar,	Gargoyle,	0,	0,	make_art_tile(ArtTile_LZ_Gargoyle,2,0)
    else
	dbug	Map_Gar,	Gargoyle,	0,	0,	make_art_tile(ArtTile_LZ_Sonic_Drowning-2,2,0) ; Incorrect VRAM address.
    endif
	dbug	Map_LBlock,	LabyrinthBlock, $27,	2,	make_art_tile(ArtTile_LZ_Blocks,2,0)
	dbug	Map_LBlock,	LabyrinthBlock, $30,	3,	make_art_tile(ArtTile_LZ_Blocks,2,0)
	dbug	Map_LConv,	LabyrinthConvey, $7F, 0,	make_art_tile(ArtTile_LZ_Conveyor_Belt,0,0)
	dbug	Map_Orb,	Orbinaut,	0,	0,	make_art_tile(ArtTile_LZ_Orbinaut,0,0)
	dbug	Map_Bub,	Bubble,	$84,	$13,	make_art_tile(ArtTile_LZ_Bubbles,0,1)
	dbug	Map_WFall,	Waterfall,	2,	2,	make_art_tile(ArtTile_LZ_Splash,2,1)
	dbug	Map_WFall,	Waterfall,	9,	9,	make_art_tile(ArtTile_LZ_Splash,2,1)
	dbug	Map_Pole,	Pole,	0,	0,	make_art_tile(ArtTile_LZ_Pole,2,0)
	dbug	Map_Flap,	FlapDoor,	2,	0,	make_art_tile(ArtTile_LZ_Flapping_Door,2,0)
	dbug	Map_Lamp,	Lamppost,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
.LZend:

.MZ:
	dc.w (.MZend-.MZ-2)/$A

;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	Rings,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug	Map_Monitor,	Monitor,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug	Map_Buzz,	BuzzBomber,	0,	0,	make_art_tile(ArtTile_Buzz_Bomber,0,0)
	dbug	Map_Spike,	Spikes,	0,	0,	make_art_tile(ArtTile_Spikes,0,0)
	dbug	Map_Spring,	Springs,	0,	0,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug	Map_Fire,	LavaMaker,	0,	0,	make_art_tile(ArtTile_MZ_Fireball,0,0)
	dbug	Map_Brick,	MarbleBrick,	0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug	Map_Geyser,	GeyserMaker,	0,	0,	make_art_tile(ArtTile_MZ_Lava,3,0)
	dbug	Map_LWall,	LavaWall,	0,	0,	make_art_tile(ArtTile_MZ_Lava,3,0)
	dbug	Map_Push,	PushBlock,	0,	0,	make_art_tile(ArtTile_MZ_Block,2,0)
	dbug	Map_Yad,	Yadrin,	0,	0,	make_art_tile(ArtTile_Yadrin,1,0)
	dbug	Map_Smab,	SmashBlock,	0,	0,	make_art_tile(ArtTile_MZ_Block,2,0)
	if FixBugs
	dbug	Map_MBlock,	MovingBlock,	0,	0,	make_art_tile(ArtTile_MZ_Block,2,0)
	else
	dbug	Map_MBlock,	MovingBlock,	0,	0,	make_art_tile(ArtTile_MZ_Block,0,0) ; Incorrect palette line.
	endif
	if FixBugs
	dbug	Map_CFlo,	CollapseFloor, 0,	0,	make_art_tile(ArtTile_MZ_Block,2,0)
	else
	dbug	Map_CFlo,	CollapseFloor, 0,	0,	make_art_tile(ArtTile_MZ_Block,3,0) ; Incorrect palette line.
	endif
	dbug	Map_LTag,	LavaTag,	0,	0,	make_art_tile(ArtTile_Monitor,0,1)
	dbug	Map_Bas,	Basaran,	0,	0,	make_art_tile(ArtTile_Basaran,0,0)
	dbug	Map_Cat,	Caterkiller,	0,	0,	make_art_tile(ArtTile_MZ_SYZ_Caterkiller,1,0)
	dbug	Map_Lamp,	Lamppost,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
.MZend:

.SLZ:
	dc.w (.SLZend-.SLZ-2)/$A

;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	Rings,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug	Map_Monitor,	Monitor,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug	Map_Elev,	Elevator,	0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug	Map_CFlo,	CollapseFloor, 0,	2,	make_art_tile(ArtTile_SLZ_Collapsing_Floor,2,0)
	dbug	Map_Plat_SLZ,	BasicPlatform, 0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug	Map_Circ,	CirclingPlatform, 0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug	Map_Stair,	Staircase,	0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug	Map_Fan,	Fan,		0,	0,	make_art_tile(ArtTile_SLZ_Fan,2,0)
	dbug	Map_Seesaw,	Seesaw,	0,	0,	make_art_tile(ArtTile_SLZ_Seesaw,0,0)
	dbug	Map_Spring,	Springs,	0,	0,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug	Map_Fire,	LavaMaker,	0,	0,	make_art_tile(ArtTile_SLZ_Fireball,0,0)
	dbug	Map_Scen,	Scenery,	0,	0,	make_art_tile(ArtTile_SLZ_Fireball_Launcher,2,0)
	dbug	Map_Bomb,	Bomb,	0,	0,	make_art_tile(ArtTile_Bomb,0,0)
	dbug	Map_Orb,	Orbinaut,	0,	0,	make_art_tile(ArtTile_SLZ_Orbinaut,1,0)
	dbug	Map_Lamp,	Lamppost,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
.SLZend:

.SYZ:
	dc.w (.SYZend-.SYZ-2)/$A

;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	Rings,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug	Map_Monitor,	Monitor,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug	Map_Spike,	Spikes,	0,	0,	make_art_tile(ArtTile_Spikes,0,0)
	dbug	Map_Spring,	Springs,	0,	0,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug	Map_Roll,	Roller,	0,	0,	make_art_tile(ArtTile_Roller,0,0)
	dbug	Map_Light,	SpinningLight, 0,	0,	make_art_tile(ArtTile_Level,0,0)
	dbug	Map_Bump,	Bumper,	0,	0,	make_art_tile(ArtTile_SYZ_Bumper,0,0)
	dbug	Map_Crab,	Crabmeat,	0,	0,	make_art_tile(ArtTile_Crabmeat,0,0)
	dbug	Map_Buzz,	BuzzBomber,	0,	0,	make_art_tile(ArtTile_Buzz_Bomber,0,0)
	dbug	Map_Yad,	Yadrin,	0,	0,	make_art_tile(ArtTile_Yadrin,1,0)
	dbug	Map_Plat_SYZ,	BasicPlatform, 0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug	Map_FBlock,	FloatingBlock, 0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug	Map_But,	Button,	0,	0,	make_art_tile(ArtTile_Button+4,0,0)
	dbug	Map_Cat,	Caterkiller,	0,	0,	make_art_tile(ArtTile_MZ_SYZ_Caterkiller,1,0)
	dbug	Map_Lamp,	Lamppost,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
.SYZend:

.SBZ:
	dc.w (.SBZend-.SBZ-2)/$A

;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	Rings,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug	Map_Monitor,	Monitor,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug	Map_Bomb,	Bomb,	0,	0,	make_art_tile(ArtTile_Bomb,0,0)
	dbug	Map_Orb,	Orbinaut,	0,	0,	make_art_tile(ArtTile_SBZ_Orbinaut,0,0)
	dbug	Map_Cat,	Caterkiller,	0,	0,	make_art_tile(ArtTile_SBZ_Caterkiller,1,0)
	dbug	Map_BBall,	SwingingPlatform, 7,	2,	make_art_tile(ArtTile_SBZ_Swing,2,0)
	dbug	Map_Disc,	RunningDisc,	$E0,	0,	make_art_tile(ArtTile_SBZ_Disc,2,1)
	dbug	Map_MBlock,	MovingBlock,	$28,	2,	make_art_tile(ArtTile_SBZ_Moving_Block_Short,1,0)
	dbug	Map_But,	Button,	0,	0,	make_art_tile(ArtTile_Button+4,0,0)
	dbug	Map_Trap,	SpinPlatform, 3,	0,	make_art_tile(ArtTile_SBZ_Trap_Door,2,0)
	dbug	Map_Spin,	SpinPlatform, $83,	0,	make_art_tile(ArtTile_SBZ_Spinning_Platform,0,0)
	dbug	Map_Saw,	Saws,	2,	0,	make_art_tile(ArtTile_SBZ_Saw,2,0)
	dbug	Map_CFlo,	CollapseFloor, 0,	0,	make_art_tile(ArtTile_SBZ_Collapsing_Floor,2,0)
	dbug	Map_MBlock,	MovingBlock,	$39,	3,	make_art_tile(ArtTile_SBZ_Moving_Block_Long,2,0)
	dbug	Map_Stomp,	ScrapStomp,	0,	0,	make_art_tile(ArtTile_SBZ_Moving_Block_Short,1,0)
	dbug	Map_ADoor,	AutoDoor,	0,	0,	make_art_tile(ArtTile_SBZ_Door,2,0)
	dbug	Map_Stomp,	ScrapStomp,	$13,	1,	make_art_tile(ArtTile_SBZ_Moving_Block_Short,1,0)
	dbug	Map_Saw,	Saws,	1,	0,	make_art_tile(ArtTile_SBZ_Saw,2,0)
	dbug	Map_Stomp,	ScrapStomp,	$24,	1,	make_art_tile(ArtTile_SBZ_Moving_Block_Short,1,0)
	dbug	Map_Saw,	Saws,	4,	2,	make_art_tile(ArtTile_SBZ_Saw,2,0)
	dbug	Map_Stomp,	ScrapStomp,	$34,	1,	make_art_tile(ArtTile_SBZ_Moving_Block_Short,1,0)
	dbug	Map_VanP,	VanishPlatform, 0,	0,	make_art_tile(ArtTile_SBZ_Vanishing_Block,2,0)
	dbug	Map_Flame,	Flamethrower, $64,	0,	make_art_tile(ArtTile_SBZ_Flamethrower,0,1)
	dbug	Map_Flame,	Flamethrower, $64,	$B,	make_art_tile(ArtTile_SBZ_Flamethrower,0,1)
	dbug	Map_Elec,	Electro,	4,	0,	make_art_tile(ArtTile_SBZ_Electric_Orb,0,0)
	dbug	Map_Gird,	Girder,	0,	0,	make_art_tile(ArtTile_SBZ_Girder,2,0)
	dbug	Map_Invis,	Invisibarrier, $11,	0,	make_art_tile(ArtTile_Monitor,0,1)
	dbug	Map_Hog,	BallHog,	4,	0,	make_art_tile(ArtTile_Ball_Hog,1,0)
	dbug	Map_Lamp,	Lamppost,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
.SBZend:

.Ending:
	dc.w (.Endingend-.Ending-2)/$A

;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	Rings,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
    if Revision=0
	dbug	Map_Bump,	Bumper,	0,	0,	make_art_tile(ArtTile_SYZ_Bumper,0,0)
    if FixBugs
	dbug	Map_Animal2,	Animals,	$A,	0,	make_art_tile(ArtTile_Ending_Flicky,0,0)
	dbug	Map_Animal2,	Animals,	$B,	0,	make_art_tile(ArtTile_Ending_Flicky,0,0)
	dbug	Map_Animal2,	Animals,	$C,	0,	make_art_tile(ArtTile_Ending_Flicky,0,0)
    else
	dbug	Map_Animal2,	Animals,	$A,	0,	make_art_tile(ArtTile_Ending_Flicky-5,0,0)
	dbug	Map_Animal2,	Animals,	$B,	0,	make_art_tile(ArtTile_Ending_Flicky-5,0,0)
	dbug	Map_Animal2,	Animals,	$C,	0,	make_art_tile(ArtTile_Ending_Flicky-5,0,0)
    endif
	dbug	Map_Animal1,	Animals,	$D,	0,	make_art_tile(ArtTile_Ending_Rabbit,0,0)
	dbug	Map_Animal1,	Animals,	$E,	0,	make_art_tile(ArtTile_Ending_Rabbit,0,0)
	dbug	Map_Animal1,	Animals,	$F,	0,	make_art_tile(ArtTile_Ending_Penguin,0,0)
	dbug	Map_Animal1,	Animals,	$10,	0,	make_art_tile(ArtTile_Ending_Penguin,0,0)
	dbug	Map_Animal2,	Animals,	$11,	0,	make_art_tile(ArtTile_Ending_Seal,0,0)
	dbug	Map_Animal3,	Animals,	$12,	0,	make_art_tile(ArtTile_Ending_Pig,0,0)
	dbug	Map_Animal2,	Animals,	$13,	0,	make_art_tile(ArtTile_Ending_Chicken,0,0)
	dbug	Map_Animal3,	Animals,	$14,	0,	make_art_tile(ArtTile_Ending_Squirrel,0,0)
    else
	dbug 	Map_Ring,	Rings,	0,	8,	make_art_tile(ArtTile_Ring,1,0)
    endif
.Endingend:

	even
