local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local JustConfig = require("sphere.JustConfig")

local piano = {}

local octave = {
	{0, 1},
	{1, -1},
	{0, 2},
	{1, 1},
	{0, 3},
	{0, 1},
	{1, -1},
	{0, 4},
	{1, 0},
	{0, 5},
	{1, 1},
	{0, 3}
}

local hitposition = 880

function piano.createNoteskin(keys, start, root)
	local config = JustConfig:fromFile(root .. "/piano.config.lua")

	local noteskin = NoteSkinVsrg({
		name = "piano",
		inputMode = keys .. "key",
		range = {-1, 1},
		unit = 1080,
		hitposition = hitposition,
		config = config
	})

	local input = {}
	for i = 1, keys do
		input[i] = "key" .. i
	end
	noteskin:setInput(input)

	local images = {}
	for i = 0, keys - 1 do
		local key = octave[(start - 1 + i) % 12 + 1]
		table.insert(images, {unpack(key)})
	end

	if images[2][1] == 1 then
		images[1][2] = 6
	else
		images[1][2] = 0
	end

	if images[keys - 1][1] == 1  then
		if images[keys - 3][1] == 1  then
			images[keys][2] = 3
		else
			images[keys][2] = 7
		end
	else
		images[keys][2] = 0
	end

	local w = {}
	local total_width = 0
	for i = 1, #images do
		w[i] = images[i][1] == 0 and 6 or 4
		total_width = total_width + 6 * (images[i][1] == 0 and 6 or 0)
	end

	local x = {}
	local cb = 0
	local cw = 0
	for i = 1, #images do
		local x_i = cw * 6
		if images[i][1] == 0 then
			cw = cw + 1
		elseif images[i][1] == 1 then
			cb = cb + 1
			x_i = x_i - 2 + images[i][2]
		end
		x[i] = x_i
	end

	local scale = config:get("scale")
	for i = 1, #w do
		x[i] = x[i] * 1872 / 312 * scale
		w[i] = w[i] * 1872 / 312 * scale
	end

	noteskin:setColumns({
		offset = 0,
		align = "center",
		width = w,
		position = x,
	})

	local function getKeyName(i)
		if images[i][1] == 1 then
			return "keyBlack.png"
		end
		return string.format("keyWhite%d.png", images[i][2])
	end

	local keysPressed = {}
	local keysReleased = {}
	for i = 1, #w do
		keysPressed[i] = "pressed/" .. getKeyName(i)
		keysReleased[i] = "released/" .. getKeyName(i)
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
		short[i] = image[1] == 0 and "clear" or "dark"
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

	if config:get("measureLine") then
		noteskin:addMeasureLine({
			h = 2,
			color = {0.5, 0.5, 0.5, 1},
			image = "measure"
		})
	end

	local playfield = BasePlayfield(noteskin)

	local tf = playfield:newFullTransform(1920, 1080)
	tf[1] = {1 / 2, 0}

	playfield:enableCamera()
	playfield:addNotes({
		transform = tf
	})
	playfield:addImageView({
		x = -total_width / 2,
		y = hitposition,
		w = total_width,
		h = 200,
		transform = tf,
		image = "background.png",
	})
	playfield:addKeyImages({
		h = 200,
		padding = 0,
		transform = tf,
		released = keysReleased,
		pressed = keysPressed,
	})
	playfield:disableCamera()
	if config:get("baseElements") then
		playfield:addBaseElements()
	end

	return noteskin
end

return piano
