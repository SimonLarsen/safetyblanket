function moveTowards(from, to, interval)
	if from < to then
		return from+interval
	elseif from > to then
		return from-interval
	else
		return from
	end
end
