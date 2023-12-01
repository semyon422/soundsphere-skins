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
	local chord = noteView.chords[noteView.graphicalNote.startNoteData.timePoint.absoluteTime]
	if not chord then
		return noChord
	end

	local sc = {}

	for i, head in pairs(chord) do
		if head.noteType == SN or head.noteType == LNS then
			sc[i] = head
		end
	end

	return sc
end

function chords.get_middle_chord(noteView)
	local startTime = noteView.graphicalNote.startNoteData.timePoint.absoluteTime
	local endTime = noteView.graphicalNote.endNoteData.timePoint.absoluteTime

	local sc = noteView.chords[startTime] or noChord
	local ec = noteView.chords[endTime] or noChord

	local mc = {}

	for i, head in pairs(sc) do
		local tail = ec[i]
		if tail and
			head.noteType == LNS and tail.noteType == LNE and
			head.timePoint.absoluteTime == startTime and
			tail.timePoint.absoluteTime == endTime and
			head.endNoteData == tail
		then
			mc[i] = ec[i]
		end
	end

	return mc
end

return chords
