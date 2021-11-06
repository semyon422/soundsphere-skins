local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg:new({
	path = ...,
	name = "circle connected",
	inputMode = "4key",
	range = {-1, 1},
	unit = 480,
	hitposition = 450,
})

noteskin:setInput({
	"key1",
	"key2",
	"key3",
	"key4",
})

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {48, 48, 48, 48},
	space = {24, 0, 0, 0, 24},
})

noteskin:setTextures({
	{pixel = "pixel.png"},

	{bwhite = "body/white.png"},
	{bwhite_left = "body/white-left.png"},
	{bwhite_right = "body/white-right.png"},
	{bwhite_center = "body/white-center.png"},

	{hwhite = "headtail/white.png"},
	{hwhite_left = "headtail/white-left.png"},
	{hwhite_right = "headtail/white-right.png"},
	{hwhite_center = "headtail/white-center.png"},

	{nwhite = "note/white.png"},
	{nwhite_left = "note/white-left.png"},
	{nwhite_right = "note/white-right.png"},
	{nwhite_center = "note/white-center.png"},
})

noteskin:setImages({
	pixel = {"pixel"},
	bwhite = {"bwhite"},
	bwhite_left = {"bwhite_left"},
	bwhite_right = {"bwhite_right"},
	bwhite_center = {"bwhite_center"},
	hwhite = {"hwhite"},
	hwhite_left = {"hwhite_left"},
	hwhite_right = {"hwhite_right"},
	hwhite_center = {"hwhite_center"},
	nwhite = {"nwhite"},
	nwhite_left = {"nwhite_left"},
	nwhite_right = {"nwhite_right"},
	nwhite_center = {"nwhite_center"},
})

local inputsCount = noteskin.inputsCount
local function getSuffix(chord, column)
	local suffix = ""
	if column < inputsCount and not chord[column - 1] and chord[column + 1] then
		suffix = "_left"
	elseif column > 1 and chord[column - 1] and not chord[column + 1] then
		suffix = "_right"
	elseif column > 1 and column < inputsCount and chord[column - 1] and chord[column + 1] then
		suffix = "_center"
	end
	return suffix
end
-- local function getSuffix2(startChord, endChord, column)
-- 	local startSuffix = getSuffix(startChord, column)
-- 	local endSuffix = getSuffix(endChord, column)
-- 	if startSuffix == "" or endSuffix == "" or startSuffix ~= endSuffix then
-- 		return ""
-- 	elseif startSuffix == endSuffix then
-- 		return startSuffix
-- 	end
-- end

noteskin:setShortNote({
	image = function(timeState, noteView, column) return "nwhite" .. getSuffix(noteView.startChord, column) end,
	h = 48,
})

noteskin:setLongNote({
	head = function(timeState, noteView, column) return "hwhite" .. getSuffix(noteView.startChord, column) end,
	body = function(timeState, noteView, column) return "bwhite" .. getSuffix(noteView.middleChord, column) end,
	tail = function(timeState, noteView, column) return "hwhite" .. getSuffix(noteView.endChord, column) end,
	h = 48,
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

local playfield = BasePlayfield:new({
	noteskin = noteskin
})

playfield:addBga({
	transform = {{1 / 2, -16 / 9 / 2}, {0, -7 / 9 / 2}, 0, {0, 16 / 9}, {0, 16 / 9}, 0, 0, 0, 0}
})
playfield:enableCamera()
playfield:addNotes()
playfield:addKeyImages({
	h = 480,
	padding = 0,
	pressed = {
		"key/key-down-1.png",
		"key/key-up-1.png",
		"key/key-up-1.png",
		"key/key-down-1.png",
	},
	released = {
		"key/key-down-0.png",
		"key/key-up-0.png",
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
