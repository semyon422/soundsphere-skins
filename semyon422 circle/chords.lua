local chords = {}

local SN = "ShortNote"
local LNS = "LongNoteStart"
local LNE = "LongNoteEnd"

local start_type_to_suffix = {
	ShortNote = 1,
	LongNoteStart = 2,
	LongNoteEnd = 0,
}

local end_type_to_suffix = {
	ShortNote = 0,
	LongNoteStart = 0,
	LongNoteEnd = 3,
}

function chords.get_suffix(c, column)
	local l, m, r = c[column - 1], c[column], c[column + 1]
	if not m then
		return "_00"
	end

	local tts = start_type_to_suffix
	if m.noteType == LNE then
		tts = end_type_to_suffix
	end

	local a, b = 0, 0
	if l then
		a = tts[l.noteType] or 0
	end
	if r then
		b = tts[r.noteType] or 0
	end

	return "_" .. a .. b
end

local noChord = {}
function chords.get_start_chord(noteView)
	local chord = noteView.chords[noteView.graphicalNote.startNote.visualPoint.point.absoluteTime]
	if not chord then
		return noChord
	end

	local sc = {}

	for i, nds in pairs(chord) do
		local head = nds[1]
		if head.noteType == SN or head.noteType == LNS then
			sc[i] = head
		end
	end

	return sc
end

function chords.get_middle_chord(noteView)
	local startTime = noteView.graphicalNote.startNote.visualPoint.point.absoluteTime
	local endTime = noteView.graphicalNote.endNote.visualPoint.point.absoluteTime

	local sc = noteView.chords[startTime] or noChord
	local ec = noteView.chords[endTime] or noChord

	local mc = {}

	for i, nds in pairs(sc) do
		local head = nds[1]
		local tail = ec[i] and ec[i][1]
		if tail and
			head.noteType == LNS and tail.noteType == LNE and
			head.visualPoint.point.absoluteTime == startTime and
			tail.visualPoint.point.absoluteTime == endTime and
			head.endNote == tail
		then
			mc[i] = tail
		end
	end

	return mc
end

return chords
