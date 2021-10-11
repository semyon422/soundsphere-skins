local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg:new({
	path = ...,
	name = "circle",
	inputMode = "4bt2fx2laserleft2laserright",
	range = {-1, 1},
	unit = 480,
	hitposition = 450,
})

noteskin:setInput({
	"laserleft1",
	"laserright1",
	"bt1",
	"bt2",
	"fx1",
	"fx2",
	"bt3",
	"bt4",
	"laserleft2",
	"laserright2",
})

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {48, 48, 48, 48, 48, 48, 48, 48, 48, 48},
	space = {24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24},
})

noteskin:setTextures({
	{pixel = "pixel.png"},
	{nwhite = "note/white.png"},
	{ngreen = "note/green.png"},
	{norange = "note/orange.png"},
	{nblue = "note/blue.png"},
	{hwhite = "headtail/white.png"},
	{hgreen = "headtail/green.png"},
	{horange = "headtail/orange.png"},
	{hblue = "headtail/blue.png"},
	{bwhite = "body/white.png"},
	{bgreen = "body/green.png"},
	{borange = "body/orange.png"},
	{bblue = "body/blue.png"},
})

noteskin:setImages({
	pixel = {"pixel"},
	nwhite = {"nwhite"},
	ngreen = {"ngreen"},
	norange = {"norange"},
	nblue = {"nblue"},
	hwhite = {"hwhite"},
	hgreen = {"hgreen"},
	horange = {"horange"},
	hblue = {"hblue"},
	bwhite = {"bwhite"},
	bgreen = {"bgreen"},
	borange = {"borange"},
	bblue = {"bblue"},
})

noteskin:setShortNote({
	image = {
		"nblue",
		"nblue",
		"nwhite",
		"nwhite",
		"norange",
		"norange",
		"nwhite",
		"nwhite",
		"ngreen",
		"ngreen",
	},
	h = 48,
})

noteskin:setLongNote({
	head = {
		"hblue",
		"hblue",
		"hwhite",
		"hwhite",
		"horange",
		"horange",
		"hwhite",
		"hwhite",
		"hgreen",
		"hgreen",
	},
	body = {
		"bblue",
		"bblue",
		"bwhite",
		"bwhite",
		"borange",
		"borange",
		"bwhite",
		"bwhite",
		"bgreen",
		"bgreen",
	},
	tail = {
		"hblue",
		"hblue",
		"hwhite",
		"hwhite",
		"horange",
		"horange",
		"hwhite",
		"hwhite",
		"hgreen",
		"hgreen",
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
		"key/key-1.png",
		"key/key-up-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-up-1.png",
		"key/key-1.png",
		"key/key-1.png"
	},
	released = {
		"key/key-0.png",
		"key/key-0.png",
		"key/key-up-0.png",
		"key/key-up-0.png",
		"key/key-down-0.png",
		"key/key-down-0.png",
		"key/key-up-0.png",
		"key/key-up-0.png",
		"key/key-0.png",
		"key/key-0.png"
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
