-- requires 

local composer = require ("composer")
local mydata = require( "mydata" )
local gameUI = require ("gameUI")
local defines = require( "defines" )

local scene = composer.newScene()

local function back(event)
	print("==> Enter Back")
	gameUI.vibrate()
	backText.alpha = 0.5
	backText.xScale = 0.9
	backText.yScale = 0.9
	backBtn.xScale = 0.9
	backBtn.yScale = 0.9
	gameUI.playEventSound( mydata.options_btn_back_click )
	composer.hideOverlay("fade", 800)
end

function hideOverlay(event)
	back(event)
end

local function onSwitchPress( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
end

local function setCkb(event)
	if (gameUI.getConfig(gameUI._SHOW_HELP) == 1) then
		setCkbConfig(0)
	else
		setCkbConfig(1)
	end
	gameUI.vibrate()
	gameUI.playEventSound( mydata.options_btn_music_click )
end

function setCkbConfig( zON )
	zON = zON or gameUI.getConfig(gameUI._SHOW_HELP)
	if zON == 1 then
		ckbOn.isVisible = false
		ckbOff.isVisible = true
	else
		ckbOn.isVisible = true
		ckbOff.isVisible = false
	end
	gameUI.setConfig(gameUI._SHOW_HELP, zON)
end

function scene:create(event)
	local screenGroup = self.view

	local backgroundOverlay = display.newRect (gameUI.width()/2, gameUI.height()/2, gameUI.width(), gameUI.height())
	backgroundOverlay:setFillColor( 0 )
	backgroundOverlay.alpha = 1
	screenGroup:insert(backgroundOverlay)

	local helpImg = gameUI.addButton( help_img_help, gameUI.width()/2, gameUI.height()/2, help_img_help_width, help_img_help_height, help_img_help_color )
	screenGroup:insert(helpImg)

	backBtn = gameUI.addButton(options_btn_back, helpImg.x+(helpImg.width/2)-20, helpImg.y-(helpImg.height/2),
		options_btn_back_width, options_btn_back_height, options_btn_back_color)
	backBtn.anchorX = 1
	screenGroup:insert(backBtn)

	backText = gameUI.addText( "X", backBtn.x-backBtn.width*0.45, backBtn.y-backBtn.height*0.01, options_btn_back_height*0.75)
	backText:setFillColor(1)
	screenGroup:insert(backText)

	ckbOn = gameUI.addButton(help_img_ckb_on, helpImg.x-(helpImg.width/2)+10, helpImg.y+(helpImg.height/2)-10,
		help_img_ckb_width, help_img_ckb_height, help_img_ckb_on_color)
	ckbOn.anchorX = 0
	ckbOn.anchorY = 1
	screenGroup:insert(ckbOn)

	ckbOff = gameUI.addButton(help_img_ckb_off, helpImg.x-(helpImg.width/2)+10, helpImg.y+(helpImg.height/2)-10,
		help_img_ckb_width, help_img_ckb_height, help_img_ckb_off_color)
	ckbOff.anchorX = 0
	ckbOff.anchorY = 1
	screenGroup:insert(ckbOff)

	setCkbConfig()

	local textOptions = 
	{
		text = help_img_ckb_text,     
		x = ckbOn.x+ckbOn.width+4,
		y = ckbOn.y,
		font = help_img_ckb_font,   
		fontSize = help_img_ckb_font_size,
		align = "left"
	}
	local ckbText = display.newText(textOptions)
	ckbText.anchorX = 0
	ckbText.anchorY = 1
	screenGroup:insert(ckbText)

	local bgForCkb = display.newRoundedRect( ckbOn.x + (ckbOn.width+ckbText.width)*0.5 + 2, ckbOn.y - ckbText.height*0.5,
		(ckbOn.width+ckbText.width)+10, ckbText.height+6, 8 )
	bgForCkb:setFillColor(0, 0.8)
	screenGroup:insert(bgForCkb)

	ckbOn:toFront()
	ckbOff:toFront()
	ckbText:toFront()
end

function scene:show(event)
	if ( event.phase == "will" ) then
		composer.isOverlay = true
		composer.currentScene = "help"
		composer.returnTo = event.params.returnTo
	elseif ( event.phase == "did" ) then
		backBtn:addEventListener("tap", back)
		ckbOn:addEventListener("tap", setCkb)
		ckbOff:addEventListener("tap", setCkb)
	end
end

function scene:hide(event)
	if ( event.phase == "will" ) then
		backBtn:removeEventListener("tap", back)
		ckbOn:removeEventListener("tap", setCkb)
		ckbOff:removeEventListener("tap", setCkb)
	elseif ( event.phase == "did" ) then
		event.parent:resumeStart()
		composer.removeScene( "help" )
	end
end

function scene:destroy(event)

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
