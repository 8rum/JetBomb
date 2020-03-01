local barImg = "barImg.png"
ProgressBar = {}

function ProgressBar:new(backColor, frontColor, strokeColor, startWidth, startHeight, maxBar)
	maxBar = maxBar or 100

	local group = display.newGroup()
	group.anchorChildren = true
	group.anchorY = 0.5

	local bar = display.newRect(0, 0, startWidth, startHeight)
	bar.anchorY = 1
	local gradient = {
		type="gradient",
		color1=backColor, color2=frontColor, direction="up"
	}
	bar:setFillColor( gradient )
	group:insert(bar)

	local barStroke = display.newRect(0, 0, startWidth, startHeight)
	barStroke.anchorY = 1
	barStroke:setFillColor( 1, 0 )
	barStroke:setStrokeColor( strokeColor )
	barStroke.strokeWidth = 3
	group:insert(barStroke)

	function group:setProgress(current)
		local size = current * startHeight / maxBar
		if (size>startHeight) then size = startHeight end
		if (size<0) then size = 0 end
		bar.height = size
	end
 
	return group
end
 
return ProgressBar