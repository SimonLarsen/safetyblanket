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
	local max = -100000
	for i,v in ipairs({...}) do
		max = math.max(max, v)
	end

	return max
end

function timeToDigits(time)
	local hours = math.floor(time / 60) % 12
	local hour1 = math.floor(hours / 10)
	local hour2 = hours % 10
	local min1 = math.floor((time % 60) / 10)
	local min2 = math.floor((time % 60) % 10)

	return hour1, hour2, min1, min2
end

function digitsToString(hour1, hour2, min1, min2)
	if hour1 > 0 then
		return hour1 .. hour2 .. ":" .. min1 .. min2
	else
		return " ".. hour2 .. ":" .. min1 .. min2
	end
end

function printShadow(text, x, y, offset)
	local offset = offset or 1
	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.print(text, x, y+offset)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(text, x, y)
end
