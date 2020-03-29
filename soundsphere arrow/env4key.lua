number = function(_, n)
    return n
end

linear = function(timeState, data)
    return data[1] + data[2] * (timeState.scaledFakeVisualDeltaTime or timeState.scaledVisualDeltaTime)
end
