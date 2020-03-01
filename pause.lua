-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

local game = require( "game" )
local composer = require( "composer" )
local gameUI = require ("gameUI")
local mydata = require ("mydata")
local score = require("score")
local defines = require( "defines" )
local GA = require ( "plugin.gameanalytics" )

local scene = composer.newScene()

function music(event)
	if gameUI.getConfig(gameUI._MUSIC) == 1 then
		setMusic(0)
	else
		setMusic(1)
	end
	gameUI.playEventSound( mydata.pause_btn_music_click )
end

function setMusic( zON )
	zON = zON or gameUI.getConfig(gameUI._MUSIC)
	if zON == 1 then
		musicBtnOn.isVisible = true
		musicTextOn.isVisible = true
		musicBtnOff.isVisible = false
		musicTextOff.isVisible = false
	else
		musicBtnOn.isVisible = false
		musicTextOn.isVisible = false
		musicBtnOff.isVisible = true
		musicTextOff.isVisible = true
	end
	gameUI.setConfig(gameUI._MUSIC, zON)
	GA.newEvent ( "design", { event_id="Update:Music:"..zON, value=zON } )
end

function effects(event)
	if gameUI.getConfig(gameUI._EFFECTS) == 1 then
		setEffects(0)
	else
		setEffects(1)
	end
	gameUI.playEventSound( mydata.pause_btn_effects_click )
end

function setEffects( zON )
	zON = zON or gameUI.getConfig(gameUI._EFFECTS)
	if zON == 1 then
		effectsBtnOn.isVisible = true
		effectsTextOn.isVisible = true
		effectsBtnOff.isVisible = false
		effectsTextOff.isVisible = false
	else
		effectsBtnOn.isVisible = false
		effectsTextOn.isVisible = false
		effectsBtnOff.isVisible = true
		effectsTextOff.isVisible = true
	end
	gameUI.setConfig(gameUI._EFFECTS, zON)
	GA.newEvent ( "design", { event_id="Update:Effects:"..zON, value=zON } )
end

function vibrate(event)
	if gameUI.getConfig(gameUI._VIBRATE) == 1 then
		setVibrate(0)
	else
		setVibrate(1)
	end
	gameUI.vibrate()
	gameUI.playEventSound( mydata.pause_btn_vibrate_click )
end

function setVibrate( zON )
	zON = zON or gameUI.getConfig(gameUI._VIBRATE)
	if zON == 1 then
		vibrateBtnOn.isVisible = true
		vibrateTextOn.isVisible = true
		vibrateBtnOff.isVisible = false
		vibrateTextOff.isVisible = false
	else
		vibrateBtnOn.isVisible = false
		vibrateTextOn.isVisible = false
		vibrateBtnOff.isVisible = true
		vibrateTextOff.isVisible = true
	end
	gameUI.setConfig(gameUI._VIBRATE, zON)
	GA.newEvent ( "design", { event_id="Update:Vibrate:"..zON, value=zON } )
end

local function menu(event)
	print("==> Enter Menu")
	gameUI.playEventSound( mydata.pause_btn_menu_click )
	gameUI.vibrate()
	menuText.alpha = 0.5
	menuText.xScale = 0.9
	menuText.yScale = 0.9
	menuBtn.xScale = 0.9
	menuBtn.yScale = 0.9

	local onComplete = function ( event )
		if "clicked" == event.action then
			local i = event.index
			if i == 2 then
				gameUI.vibrate()
				menuText.alpha = 1
				menuText.xScale = 1
				menuText.yScale = 1
				menuBtn.xScale = 1
				menuBtn.yScale = 1
			elseif i == 1 then
				gameUI.vibrate()
				gameUI.stop()
				GA.newEvent ( "design", { area="game", event_id="GiveUp:Level:"..gameUI.getConfig(_LEVEL), value=score.getScore() } )
				composer.gotoScene("start", "fade", 400)
			end
		end
	end

	-- Show alert with two buttons
	local alert = native.showAlert( pause_btn_menu_confirm_title, pause_btn_menu_confirm_text, 
											{ pause_btn_menu_confirm_btn_yes, pause_btn_menu_confirm_btn_cancel }, onComplete )
end

function hideOverlay(event)
	if backGame == nil then
		print("HIDE OVERLAY")
		gameUI.vibrate()
		gameUI.playEventSound( mydata.pause_btn_back_click )
		composer.hideOverlay("fade", 800)
		backGame = true
		backText.alpha = 0.5
		backText.xScale = 0.9
		backText.yScale = 0.9
		backBtn.xScale = 0.9
		backBtn.yScale = 0.9
	end
end

function scene:create( event )
	local screenGroup = self.view

	local backgroundOverlay = display.newRect (gameUI.width()/2, gameUI.height()/2, gameUI.width(), gameUI.height())
	backgroundOverlay:setFillColor( 0 )
	backgroundOverlay.alpha = 0.6
	screenGroup:insert(backgroundOverlay)

	local overlay = nil
	if(pause_bg) then
		overlay = gameUI.addButton(pause_bg, gameUI.width()/2, gameUI.height()/2 + 5, pause_bg_width, pause_bg_height)
	else
		overlay = display.newRoundedRect( gameUI.width()/2, gameUI.height()/2 + 5, pause_bg_width, pause_bg_height, 12 )
		local gradient = {
			type="gradient",
			color1={ 0.6, 0.6, 0.6, 0.7 }, color2={ 0.4, 0.4, 0.4, 0.7 }, direction="down"
		}
		overlay:setFillColor( gradient )
	end
	screenGroup:insert (overlay)
	overlay.top = overlay.y-overlay.height/2
	overlay.botton = overlay.y+overlay.height/2
	overlay.left = overlay.x-overlay.width/2
	overlay.right = overlay.x+overlay.width/2

	local pauseTitle = display.newText(pause_title, overlay.x, overlay.top, pause_title_font, pause_title_font_size)
	pauseTitle:setFillColor(1)
	screenGroup:insert(pauseTitle)

	backBtn = gameUI.addButton(pause_btn_back, overlay.right - 20, overlay.top, pause_btn_back_width, pause_btn_back_height, pause_btn_back_color)
	backBtn.anchorX = 1
	screenGroup:insert(backBtn)

	backText = gameUI.addText( "X", backBtn.x-backBtn.width*0.45, backBtn.y-backBtn.height*0.01, pause_btn_back_height*0.75)
	backText:setFillColor(1)
	screenGroup:insert(backText)

	local collumnEq = overlay.x
	local collumn = {collumnEq + 0, collumnEq + 20}
	local lineNum = 6
	local lineEq = overlay.height/(lineNum+1)
	local shift = overlay.top-30
	local line = {lineEq*1+shift, lineEq*2+shift, lineEq*3+shift, lineEq*4+shift, lineEq*5+shift, lineEq*6+shift}

	local levelScoreText = display.newText(gameUI.getLevelText().." "..pause_txt_levelScore.." "..score.getScore(),
										   overlay.x, line[2], pause_txt_levelScore_font, pause_txt_levelScore_font_size)
	levelScoreText:setFillColor(1)
	screenGroup:insert(levelScoreText)

	local musicText = display.newText(pause_txt_music, collumn[1], line[3], pause_txt_music_font, pause_txt_music_font_size)
	musicText.anchorX = 1
	musicText:setFillColor(1)
	screenGroup:insert(musicText)

	local effectsText = display.newText(pause_txt_effects, collumn[1], line[4], pause_txt_effects_font, pause_txt_effects_font_size)
	effectsText.anchorX = 1
	effectsText:setFillColor(1)
	screenGroup:insert(effectsText)

	local vibrateText = display.newText(pause_txt_vibrate, collumn[1], line[5], pause_txt_vibrate_font, pause_txt_vibrate_font_size)
	vibrateText.anchorX = 1
	vibrateText:setFillColor(1)
	screenGroup:insert(vibrateText)

	musicBtnOn = gameUI.addButton(pause_btn_music_on, collumn[2], line[3], pause_btn_music_width, pause_btn_music_height, pause_btn_music_on_color)
	musicBtnOn.x = musicBtnOn.x + musicBtnOn.width
	screenGroup:insert(musicBtnOn)
	musicTextOn = gameUI.addText( pause_btn_music_on_text, musicBtnOn.x, musicBtnOn.y,
										  pause_btn_music_font_size, pause_btn_music_font)
	musicTextOn:setFillColor(1)
	screenGroup:insert(musicTextOn)

	musicBtnOff = gameUI.addButton(pause_btn_music_off, collumn[2], line[3], pause_btn_music_width, pause_btn_music_height, pause_btn_music_off_color)
	musicBtnOff.x = musicBtnOff.x + musicBtnOff.width
	screenGroup:insert(musicBtnOff)
	musicTextOff = gameUI.addText( pause_btn_music_off_text, musicBtnOff.x, musicBtnOff.y,
										  pause_btn_music_font_size, pause_btn_music_font)
	musicTextOff:setFillColor(1)
	screenGroup:insert(musicTextOff)

	effectsBtnOn = gameUI.addButton(pause_btn_effects_on, collumn[2], line[4], pause_btn_effects_width, pause_btn_effects_height, pause_btn_effects_on_color)
	effectsBtnOn.x = effectsBtnOn.x + effectsBtnOn.width
	screenGroup:insert(effectsBtnOn)
	effectsTextOn = gameUI.addText( pause_btn_effects_on_text, effectsBtnOn.x, effectsBtnOn.y,
										  pause_btn_effects_font_size, pause_btn_effects_font)
	effectsTextOn:setFillColor(1)
	screenGroup:insert(effectsTextOn)

	effectsBtnOff = gameUI.addButton(pause_btn_effects_off, collumn[2], line[4], pause_btn_effects_width, pause_btn_effects_height, pause_btn_effects_off_color)
	effectsBtnOff.x = effectsBtnOff.x + effectsBtnOff.width
	screenGroup:insert(effectsBtnOff)
	effectsTextOff = gameUI.addText( pause_btn_effects_off_text, effectsBtnOff.x, effectsBtnOff.y,
										  pause_btn_effects_font_size, pause_btn_effects_font)
	effectsTextOff:setFillColor(1)
	screenGroup:insert(effectsTextOff)

	vibrateBtnOn = gameUI.addButton(pause_btn_vibrate_on, collumn[2], line[5], pause_btn_vibrate_width, pause_btn_vibrate_height, pause_btn_vibrate_on_color)
	vibrateBtnOn.x = vibrateBtnOn.x + vibrateBtnOn.width
	screenGroup:insert(vibrateBtnOn)
	vibrateTextOn = gameUI.addText( pause_btn_vibrate_on_text, vibrateBtnOn.x, vibrateBtnOn.y,
										  pause_btn_vibrate_font_size, pause_btn_vibrate_font)
	vibrateTextOn:setFillColor(1)
	screenGroup:insert(vibrateTextOn)

	vibrateBtnOff = gameUI.addButton(pause_btn_vibrate_off, collumn[2], line[5], pause_btn_vibrate_width, pause_btn_vibrate_height, pause_btn_vibrate_off_color)
	vibrateBtnOff.x = vibrateBtnOff.x + vibrateBtnOff.width
	screenGroup:insert(vibrateBtnOff)
	vibrateTextOff = gameUI.addText( pause_btn_vibrate_off_text, vibrateBtnOff.x, vibrateBtnOff.y,
										  pause_btn_vibrate_font_size, pause_btn_vibrate_font)
	vibrateTextOff:setFillColor(1)
	screenGroup:insert(vibrateTextOff)

	menuBtn = gameUI.addButton(pause_btn_menu, overlay.x, overlay.botton-20, pause_btn_menu_width, pause_btn_menu_height, pause_btn_menu_color)
	menuBtn.y = menuBtn.y - menuBtn.height/2
	screenGroup:insert(menuBtn)

	menuText = gameUI.addText( pause_btn_menu_text, menuBtn.x, menuBtn.y, pause_btn_menu_font_size, pause_btn_menu_font)
	menuText:setFillColor(1)
	screenGroup:insert(menuText)

	setMusic()
	setEffects()
	setVibrate()
end

function scene:show( event )
	if ( event.phase == "will" ) then
		composer.isOverlay = true
		composer.currentScene = "pause"
		composer.returnTo = "game"
	elseif ( event.phase == "did" ) then
		backGame = nil

		musicBtnOn:addEventListener("tap", music)
		musicBtnOff:addEventListener("tap", music)
		effectsBtnOn:addEventListener("tap", effects)
		effectsBtnOff:addEventListener("tap", effects)
		vibrateBtnOn:addEventListener("tap", vibrate)
		vibrateBtnOff:addEventListener("tap", vibrate)
		backBtn:addEventListener("tap", hideOverlay)
		menuBtn:addEventListener("tap", menu)
	end
end

function scene:hide( event )
	if ( event.phase == "will" ) then
		musicBtnOn:removeEventListener("tap", music)
		musicBtnOff:removeEventListener("tap", music)
		effectsBtnOn:removeEventListener("tap", effects)
		effectsBtnOff:removeEventListener("tap", effects)
		vibrateBtnOn:removeEventListener("tap", vibrate)
		vibrateBtnOff:removeEventListener("tap", vibrate)
		backBtn:removeEventListener("tap", hideOverlay)
		menuBtn:removeEventListener("tap", menu)
	elseif ( event.phase == "did" ) then
		if backGame then
			event.parent:resumeGame()
		end
		composer.removeScene( "pause", true )
	end
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene