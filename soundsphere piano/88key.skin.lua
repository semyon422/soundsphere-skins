local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg:new({
	path = ...,
	name = "piano",
	inputMode = "88key",
	range = {-1, 1},
	unit = 1080,
	hitposition = 880,
})

local input = {}
for i = 1, 88 do
	input[i] = "key" .. i
end
noteskin:setInput(input)

noteskin.align = "center"

local keys = {3, 1, 4, 3, 1, 5, 1, 6, 3, 1, 7, 1, 8, 1, 6, 3, 1, 5, 1, 6, 3, 1, 7, 1, 8, 1, 6, 3, 1, 5, 1, 6, 3, 1, 7, 1, 8, 1, 6, 3, 1, 5, 1, 6, 3, 1, 7, 1, 8, 1, 6, 3, 1, 5, 1, 6, 3, 1, 7, 1, 8, 1, 6, 3, 1, 5, 1, 6, 3, 1, 7, 1, 8, 1, 6, 3, 1, 5, 1, 6, 3, 1, 7, 1, 8, 1, 6, 2}
local images = {0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0}
local w = {6, 4, 6, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 6, 4, 6, 4, 6, 4, 6, 6}
local x = {0, 3, 6, 12, 15, 18, 23, 24, 30, 33, 36, 40, 42, 47, 48, 54, 57, 60, 65, 66, 72, 75, 78, 82, 84, 89, 90, 96, 99, 102, 107, 108, 114, 117, 120, 124, 126, 131, 132, 138, 141, 144, 149, 150, 156, 159, 162, 166, 168, 173, 174, 180, 183, 186, 191, 192, 198, 201, 204, 208, 210, 215, 216, 222, 225, 228, 233, 234, 240, 243, 246, 250, 252, 257, 258, 264, 267, 270, 275, 276, 282, 285, 288, 292, 294, 299, 300, 306}

for i = 1, #w do
	x[i] = x[i] * 320 / 52
	w[i] = w[i] * 320 / 52
end

noteskin.columns = x
noteskin.width = w

local keysImages = {
	"keyBlack.png",
	"keyWhite.png",
	"keyWhite1.png",
	"keyWhite2.png",
	"keyWhite3.png",
	"keyWhite4.png",
	"keyWhite5.png",
	"keyWhite6.png"
}

for i = 1, #w do
	keys[i] = keysImages[keys[i]]
end

noteskin:setTextures({
	{measure = "white.png"},
	{clearB = "clearB.png"},
	{darkB = "darkB.png"},
	{clearT = "clearT.png"},
	{darkT = "darkT.png"},
	{clearH = "clearH.png"},
	{darkH = "darkH.png"},
	{clear = "clear.png"},
	{dark = "dark.png"},
})

noteskin:setImages({
	measure = {"white"},
	clearB = {"clearB"},
	darkB = {"darkB"},
	clearT = {"clearT"},
	darkT = {"darkT"},
	clearH = {"clearH"},
	darkH = {"darkH"},
	clear = {"clear"},
	dark = {"dark"},
})

local short = {}
for i, image in ipairs(images) do
	short[i] = image == 0 and "clear" or "dark"
end
noteskin:setShortNote({
	image = short,
	h = 24,
})

local head = {}
local body = {}
local tail = {}
for i, image in ipairs(images) do
	head[i] = image == 0 and "clearH" or "darkH"
	body[i] = image == 0 and "clearB" or "darkB"
	tail[i] = image == 0 and "clearT" or "darkT"
end
noteskin:setLongNote({
	head = head,
	body = body,
	tail = tail,
	h = 24,
})

noteskin:addMeasureLine({
	h = 2,
	color = {0.5, 0.5, 0.5, 1},
	image = "measure"
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

local tf = playfield:newTransform(1920, 1080, "left")

playfield:addBga({
	transform = {{1 / 2, -16 / 9 / 2}, {0, -7 / 9 / 2}, 0, {0, 16 / 9}, {0, 16 / 9}, 0, 0, 0, 0}
})
playfield:enableCamera()
playfield:addNotes({
	transform = tf
})
playfield:add({
	class = "ImageView",
	x = 0, y = 1080 - 200, w = 1920, h = 200,
	transform = tf,
	image = "Piano.png",
})

playfield:addKeyImages({
	h = 200,
	padding = 0,
	transform = tf,
	pressed = keys,
	released = {},
})
playfield:disableCamera()

playfield:addBaseElements()

return noteskin
