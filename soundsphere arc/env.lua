number = function(timeState, logicalState, n)
    return n
end

perspective = function(timeState, logicalState, data)
    return 0.375 / (timeState.scaledVisualDeltaTime + 1)
end

exponential = function(timeState, logicalState, data)
    return 0.375 ^ (2 * timeState.scaledVisualDeltaTime + 1)
end

local colors = {
	transparent = {255, 255, 255, 0},
	clear = {255, 255, 255, 255},
	missed = {127, 127, 127, 255},
	passed = {255, 255, 255, 0},
	startMissed = {127, 127, 127, 255},
	startMissedPressed = {191, 191, 191, 255},
	startPassedPressed = {255, 255, 255, 255},
	endPassed = {255, 255, 255, 0},
	endMissed = {127, 127, 127, 255},
	endMissedPassed = {127, 127, 127, 255}
}

color = function(timeState, logicalState, data)
    if logicalState == "clear" or logicalState == "skipped" then
		return colors.clear
	elseif logicalState == "missed" then
		return colors.missed
	elseif logicalState == "passed" then
		return colors.passed
    end
	
	local startTimeState = timeState.startTimeState or timeState
	local endTimeState = timeState.endTimeState or timeState
	local sdt = timeState.scaledFakeVisualDeltaTime or timeState.scaledVisualDeltaTime

	if startTimeState.fakeCurrentVisualTime >= endTimeState.absoluteTime then
		return colors.transparent
	elseif logicalState == "clear" then
		return colors.clear
	elseif logicalState == "startMissed" then
		return colors.startMissed
	elseif logicalState == "startMissedPressed" then
		return colors.startMissedPressed
	elseif logicalState == "startPassedPressed" then
		return colors.startPassedPressed
	elseif logicalState == "endPassed" then
		return colors.endPassed
	elseif logicalState == "endMissed" then
		return colors.endMissed
	elseif logicalState == "endMissedPassed" then
		return colors.endMissedPassed
	end

    return colors.clear
end
