number = function(_, logicalState, n)
	return n
end

exponential = function(timeState, logicalState, data)
    return 0.250 ^ (-timeState.scaledVisualDeltaTime + 1)
end

linear = function(timeState, logicalState, data)
	return data[1] + data[2] * (timeState.scaledFakeVisualDeltaTime or timeState.scaledVisualDeltaTime)
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

color1 = function(timeState, logicalState, data)
	local dt = timeState.scaledFakeVisualDeltaTime or timeState.scaledVisualDeltaTime

	if dt <= 0 then
		local value = math.exp(0.75 * dt)
		return {
			255 * value,
			255 * value,
			255 * value,
			255
		}
	else
		return colors.missed
	end
end

colorWhite = function(timeState, logicalState, data)
	return colors.clear
end

color = function(timeState, logicalState, data)
    if logicalState == "clear" or logicalState == "skipped" then
		return color1(timeState, logicalState, data)
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
		return color1(timeState, logicalState, data)
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
