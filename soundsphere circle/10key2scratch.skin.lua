local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg:new({
	path = ...,
	name = "circle",
	inputMode = "10key2scratch",
	range = {-1, 1},
	unit = 480,
	hitposition = 450,
})

noteskin:setInput({
	"scratch1",
	"key1",
	"key2",
	"key3",
	"key4",
	"key5",
	"key6",
	"key7",
	"key8",
	"key9",
	"key10",
	"scratch2",
})

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48},
	space = {24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24},
})

noteskin:setTextures({
	{pixel = "pixel.png"},
	{nwhite = "note/white.png"},
	{ngreen = "note/green.png"},
	{norange = "note/orange.png"},
	{hwhite = "headtail/white.png"},
	{hgreen = "headtail/green.png"},
	{horange = "headtail/orange.png"},
	{bwhite = "body/white.png"},
	{bgreen = "body/green.png"},
	{borange = "body/orange.png"},
})

noteskin:setImages({
	pixel = {"pixel"},
	nwhite = {"nwhite"},
	ngreen = {"ngreen"},
	norange = {"norange"},
	hwhite = {"hwhite"},
	hgreen = {"hgreen"},
	horange = {"horange"},
	bwhite = {"bwhite"},
	bgreen = {"bgreen"},
	borange = {"borange"},
})

noteskin:setShortNote({
	image = {
		"norange",
		"nwhite",
		"ngreen",
		"nwhite",
		"ngreen",
		"nwhite",
		"nwhite",
		"ngreen",
		"nwhite",
		"ngreen",
		"nwhite",
		"norange",
	},
	h = 48,
})

noteskin:setLongNote({
	head = {
		"horange",
		"hwhite",
		"hgreen",
		"hwhite",
		"hgreen",
		"hwhite",
		"hwhite",
		"hgreen",
		"hwhite",
		"hgreen",
		"hwhite",
		"horange",
	},
	body = {
		"borange",
		"bwhite",
		"bgreen",
		"bwhite",
		"bgreen",
		"bwhite",
		"bwhite",
		"bgreen",
		"bwhite",
		"bgreen",
		"bwhite",
		"borange",
	},
	tail = {
		"horange",
		"hwhite",
		"hgreen",
		"hwhite",
		"hgreen",
		"hwhite",
		"hwhite",
		"hgreen",
		"hwhite",
		"hgreen",
		"hwhite",
		"horange",
	},
	h = 48,
})

noteskin:addMeasureLine({
	h = 2,
	color = {1, 1, 1, 0.5},
	image = "pixel"
})

local playfield = BasePlayfield:new({
	noteskin = noteskin
})

playfield:enableCamera()
playfield:addNotes()
playfield:addKeyImages({
	h = 480,
	padding = 0,
	pressed = {
		"key/key-1.png",
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
		"key/key-1.png",
	},
	released = {
		"key/key-0.png",
		"key/key-down-0.png",
		"key/key-up-0.png",
		"key/key-down-0.png",
		"key/key-up-0.png",
		"key/key-down-0.png",
		"key/key-down-0.png",
		"key/key-up-0.png",
		"key/key-down-0.png",
		"key/key-up-0.png",
		"key/key-down-0.png",
		"key/key-0.png",
	},
})

playfield:disableCamera()

playfield:addBaseElements()

playfield:addDeltaTimeJudgement({
	x = 0, y = 540, ox = 0.5, oy = 0.5,
	rate = 2,
	transform = playfield:newLaneCenterTransform(1080),
	judgements = {
		-0.12,
		"judgements/-3.png",
		-0.080,
		"judgements/-2.png",
		-0.048,
		"judgements/-1.png",
		-0.016,
		"judgements/0.png",
		0.016,
		"judgements/1.png",
		0.048,
		"judgements/2.png",
		0.080,
		"judgements/3.png",
		0.12,
	}
})

return noteskin
