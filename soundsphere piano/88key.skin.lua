local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg({
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

local function append(t1, t2)
	for i, v in ipairs(t2) do
		t1[#t1 + 1] = v
	end
	return t1
end

local images = {0, 1, 0}
for _ = 1, 7 do
	append(images, {0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0})
end
images[#images + 1] = 0

local w = {}
for i = 1, #images do
	w[i] = images[i] == 0 and 6 or 4
end

local blackKeysOffsets = {-1}
for _ = 1, 7 do
	append(blackKeysOffsets, {-1, 1, -1, 0, 1})
end
local keyToOffset = {}
local c = 0
for i = 1, #images do
	if images[i] == 1 then
		c = c + 1
		keyToOffset[i] = blackKeysOffsets[c]
	end
end

local x = {}
local cb = 0
local cw = 0
for i = 1, #images do
	local x_i = cw * 6
	if images[i] == 0 then
		cw = cw + 1
	elseif images[i] == 1 then
		cb = cb + 1
		x_i = x_i - 2 + blackKeysOffsets[cb]
	end
	x[i] = x_i
end

for i = 1, #w do
	x[i] = x[i] * 1920 / 312
	w[i] = w[i] * 1920 / 312
end

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = w,
	position = x,
})

local keysImages = {
	"keyBlack.png",
	"keyWhite.png",
	"keyWhite1.png",
	"keyWhite2.png",
	"keyWhite3.png",
	"keyWhite4.png",
	"keyWhite5.png",
	"keyWhite6.png",
}
local function getKeyName(i)
	if images[i] == 1 then
		return 1
	end
	if i == 88 then
		return 2
	elseif i == 1 then
		return 3
	end

	local prev = keyToOffset[i - 1]
	local next = keyToOffset[i + 1]
	if not prev and next == -1 then
		return 3
	elseif prev == -1 and not next then
		return 4
	elseif prev == -1 and next == 1 then
		return 5
	elseif prev == 1 and not next then
		return 6
	elseif prev == -1 and next == 0 then
		return 7
	elseif prev == 0 and next == 1 then
		return 8
	end
end

local keys  ={}
for i = 1, #w do
	keys[i] = keysImages[getKeyName(i)]
end

noteskin:setTextures({
	{measure = ""},
	{clearB = "clearB.png"},
	{darkB = "darkB.png"},
	{clearT = "clearT.png"},
	{darkT = "darkT.png"},
	{clearH = "clearH.png"},
	{darkH = "darkH.png"},
	{clear = "clear.png"},
	{dark = "dark.png"},
})

noteskin:setImagesAuto()

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

local playfield = BasePlayfield(noteskin)

local tf = playfield:newFullTransform(1920, 1080)
tf[1] = {1 / 2, 0}

playfield:enableCamera()
playfield:addNotes({
	transform = tf
})
playfield:addImageView({
	x = -960, y = 1080 - 200, w = 1920, h = 200,
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
