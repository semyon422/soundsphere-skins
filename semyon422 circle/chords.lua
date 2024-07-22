local chords = {}

local SN = "ShortNote"
local LNS = "LongNoteStart"
local LNE = "LongNoteEnd"

local start_type_to_suffix = {
	[0] = 1,
	[1] = 2,
	[-1] = 0,
}

local end_type_to_suffix = {
	[0] = 0,
	[1] = 0,
	[-1] = 3,
}

function chords.get_suffix(c, column)
	local l, m, r = c[column - 1], c[column], c[column + 1]
	if not m then
		return "_00"
	end

	local tts = start_type_to_suffix
	if m.weight == -1 then
		tts = end_type_to_suffix
	end

	local a, b = 0, 0
	if l then
		a = tts[l.weight] or 0
	end
	if r then
		b = tts[r.weight] or 0
	end

	return "_" .. a .. b
end

local noChord = {}
function chords.get_start_chord(noteView)
	local chord = noteView.chords[noteView.graphicalNote.startNote:getTime()]
	if not chord then
		return noChord
	end

	local sc = {}

	for i, nds in pairs(chord) do
		local head = nds[1]
		if head.weight == 0 or head.weight == 1 then
			sc[i] = head
		end
	end

	return sc
end

function chords.get_middle_chord(noteView)
	local startTime = noteView.graphicalNote.startNote:getTime()
	local endTime = noteView.graphicalNote.endNote:getTime()

	local sc = noteView.chords[startTime] or noChord
	local ec = noteView.chords[endTime] or noChord

	local mc = {}

	for i, nds in pairs(sc) do
		local head = nds[1]
		local tail = ec[i] and ec[i][1]
		if tail and
			head.weight == 1 and tail.weight == -1 and
			head:getTime() == startTime and
			tail:getTime() == endTime
			-- head.endNote == tail
		then
			mc[i] = tail
		end
	end

	return mc
end

return chords
