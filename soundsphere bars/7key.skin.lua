local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg:new({
	path = ...,
	name = "bar",
	inputMode = "7key",
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
})

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {48, 48, 48, 48, 48, 48, 48},
	space = {24, 0, 0, 0, 0, 0, 0, 24},
})

noteskin:setTextures({
	{pixel = "pixel.png"},
	{note = "body.png"},
	{bwhite = "body.png"},
})

noteskin:setImages({
	pixel = {"pixel"},
	note = {"note"},
	body = {"body"},
})

noteskin:setShortNote({
	image = {
		"note",
		"note",
		"note",
		"note",
		"note",
		"note",
		"note",
	},
	h = 48,
})

noteskin:setLongNote({
	head = {
		"note",
		"note",
		"note",
		"note",
		"note",
		"note",
		"note",
	},
	body = {
		"body",
		"body",
		"body",
		"body",
		"body",
		"body",
		"body",
	},
	tail = {
		"note",
		"note",
		"note",
		"note",
		"note",
		"note",
		"note",
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
		"key.png",
		"key.png",
		"key.png",
		"key.png",
		"key.png",
		"key.png",
		"key.png",
	},
	released = {
		"key.png",
		"key.png",
		"key.png",
		"key.png",
		"key.png",
		"key.png",
		"key.png",
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
