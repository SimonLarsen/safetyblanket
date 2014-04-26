function moveTowards(from, to, interval)
	if from < to then
		return from+interval
	elseif from > to then
		return from-interval
	else
		return from
	end
end

function maxArg(...)
	local max = -10000
	for i,v in ipairs({...}) do
		max = math.max(max, v)
	end

	return max
end
