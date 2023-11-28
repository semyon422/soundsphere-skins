local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg({
	path = ...,
	name = "taiko",
	inputMode = "2key",
	range = {-1, 2},
	unit = 480,
	hitposition = 280,
})

noteskin:setInput({
	"key1",
	"key2",
})

local note_size = 56

noteskin:setColumns({
	offset = 0,
	align = "center",
	count = 1,
	width = {note_size},
	space = {0, 0},
	inputs = {
		{"key1", 1},
		{"key2", 1},
	},
})

noteskin:setTextures({
	{pixel = "pixel.png"},
	{bwhite = "body/white.png"},
	{hwhite = "headtail/white.png"},
	{nwhite = "note/white.png"},
})

noteskin:setImagesAuto({
	nred = {"nwhite", color = {1, 0.3, 0.22}},
	nblue = {"nwhite", color = {0.3, 0.65, 0.8}},
	hyellow = {"hwhite", color = {0.94, 0.69, 0.04}},
	byellow = {"bwhite", color = {0.94, 0.69, 0.04}},
})

noteskin:setShortNote({
	image = function(_, noteView)
		if noteView.graphicalNote.inputIndex == 1 then
			return "nred"
		end
		return "nblue"
	end,
	h = note_size,
})

noteskin:setLongNote({
	head = {
		"hyellow",
	},
	body = {
		"byellow",
	},
	tail = {
		"hyellow",
	},
	h = note_size,
})

noteskin:addMeasureLine({
	h = 2,
	color = {1, 1, 1, 0.5},
	image = "pixel"
})

noteskin:addBga({
	x = 0,
	y = 0,
	w = 1,
	h = 1,
	color = {0.25, 0.25, 0.25, 1}
})

local playfield = BasePlayfield(noteskin)

playfield:addBga({
	transform = {{1 / 2, -16 / 9 / 2}, {0, -7 / 9 / 2}, 0, {0, 16 / 9}, {0, 16 / 9}, 0, 0, 0, 0}
})

local transform = {0, 0, math.pi / 2, {0, 1 / noteskin.unit}, {0, 1 / noteskin.unit}, -noteskin.unit / 2, noteskin.unit, 0, 0}
playfield:enableCamera()
playfield:addNotes({
	transform = transform,
})
playfield:addKeyImages({
	h = note_size,
	padding = 480 - 280,
	pressed = {
		"key/key-taiko.png",
	},
	released = {
		"key/key-taiko.png",
	},
	transform = transform,
})

playfield:disableCamera()

playfield:addBaseElements()

return noteskin
