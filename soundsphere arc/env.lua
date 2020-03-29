number = function(_, n)
    return n
end

perspective = function(timeState)
    return 0.375 / (timeState.scaledVisualDeltaTime + 1)
end

exponential = function(timeState)
    return 0.375 ^ (2 * timeState.scaledVisualDeltaTime + 1)
end
