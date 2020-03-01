--[[
_WIDTH = 480
_HEIGHT = 320

_WIDTH_OUT = 570
_HEIGHT_OUT = 380
--]]

local aspectRatio = display.pixelHeight / display.pixelWidth
application =
{
	content =
	{
		--width = _HEIGHT,
		width = aspectRatio > 1.5 and 320 or math.floor( 480 / aspectRatio ),
		--height = _WIDTH,
		height = aspectRatio < 1.5 and 480 or math.floor( 320 * aspectRatio ),
		scale = "letterBox",
		xAlign = "left",
		yAlign = "top",
	 	fps = 30,

		imageSuffix =
		{
			["@2x"] = 1.5,
			["@4x"] = 3.0,
		},
   },

	license =
	{
		google =
		{
			key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjTbMofpj9J6mYRga9we01XB5VyyWyTDJ5E1Jnhrki2BRA8BR4d7GpL8fk+cmlkE0pEznpgRYQYAPP1yVweFIuzPO16jqfqTkM59q4SKYm1UeIv5raMbLMx1DSXPAJzpMCQ8ZJqYubk0qQzV5MyMvqZ+IdLm0keXx060n4VIYiCSNi/4GFt1vNSggVfo1ws1mF0l8+9vyvNJebnnDZLh2oAlYh+02W5zoFLnk5URiZQi9inQxxnY5c9jPmSQu0Us2CWyCMyiRbhoY22zPoO9O+OSF+dpUCN3/wx86I0OglpAmoWjia5X+J9sxq7BAWxDmhv5A6eHxfXB4+YeuZtjyTwIDAQAB",
			policy = "serverManaged",
		},
	},
}
