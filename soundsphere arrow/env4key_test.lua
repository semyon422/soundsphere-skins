number = function(_, n)
    return n
end

linear = function(timeState, data)
    return data[1] + data[2] * (timeState.scaledFakeVisualDeltaTime or timeState.scaledVisualDeltaTime)
end

key1x = function(timeState, data)
    return
        data + 0.1
        * math.sin(3 * (timeState.scaledFakeVisualDeltaTime or timeState.scaledVisualDeltaTime))
        * math.sin(10 * timeState.currentTime)
end
