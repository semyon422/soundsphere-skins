local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg:new({
	path = ...,
	name = "circle",
	inputMode = "8key",
	range = {-1, 1},
	unit = 480,
	hitposition = 450,
})

noteskin:setInput({
	"key1",
	"key2",
	"key3",
	"key4",
	"key5",
	"key6",
	"key7",
	"key8",
})

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {48, 48, 48, 48, 48, 48, 48, 48},
	space = {24, 0, 0, 0, 0, 0, 0, 0, 24},
})

noteskin:setTextures({
	{pixel = "pixel.png"},
	{nwhite = "note/white.png"},
	{ngreen = "note/green.png"},
	{hwhite = "headtail/white.png"},
	{hgreen = "headtail/green.png"},
	{bwhite = "body/white.png"},
	{bgreen = "body/green.png"},
})

noteskin:setImages({
	pixel = {"pixel"},
	nwhite = {"nwhite"},
	ngreen = {"ngreen"},
	hwhite = {"hwhite"},
	hgreen = {"hgreen"},
	bwhite = {"bwhite"},
	bgreen = {"bgreen"},
})

noteskin:setShortNote({
	image = {
		"nwhite",
		"ngreen",
		"nwhite",
		"ngreen",
		"ngreen",
		"nwhite",
		"ngreen",
		"nwhite",
	},
	h = 48,
})

noteskin:setLongNote({
	head = {
		"hwhite",
		"hgreen",
		"hwhite",
		"hgreen",
		"hgreen",
		"hwhite",
		"hgreen",
		"hwhite",
	},
	body = {
		"bwhite",
		"bgreen",
		"bwhite",
		"bgreen",
		"bgreen",
		"bwhite",
		"bgreen",
		"bwhite",
	},
	tail = {
		"hwhite",
		"hgreen",
		"hwhite",
		"hgreen",
		"hgreen",
		"hwhite",
		"hgreen",
		"hwhite",
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
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
	},
	released = {
		"key/key-down-0.png",
		"key/key-up-0.png",
		"key/key-down-0.png",
		"key/key-up-0.png",
		"key/key-up-0.png",
		"key/key-down-0.png",
		"key/key-up-0.png",
		"key/key-down-0.png",
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
