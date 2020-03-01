-- requires 

local composer = require ("composer")
local mydata = require( "mydata" )
local gameUI = require ("gameUI")
local defines = require( "defines" )

local scene = composer.newScene()

local function selectLevel(level)
	level = level or gameUI.getConfig(_LEVEL)

	levelBtnEasy.isVisible = false
	levelTextEasy.isVisible = false
	levelBtnNormal.isVisible = false
	levelTextNormal.isVisible = false
	levelBtnHard.isVisible = false
	levelTextHard.isVisible = false

	if level == 1 then
		levelBtnEasy.isVisible = true
		levelTextEasy.isVisible = true
	elseif level == 3 then
		levelBtnHard.isVisible = true
		levelTextHard.isVisible = true
	else
		levelBtnNormal.isVisible = true
		levelTextNormal.isVisible = true
	end

	gameUI.setConfig(_LEVEL, level)

	print("Level ", level)
end

function music(event)
	if gameUI.getConfig(gameUI._MUSIC) == 1 then
		setMusic(0)
	else
		setMusic(1)
	end
	gameUI.vibrate()
	gameUI.playEventSound( mydata.options_btn_music_click )
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
end

function effects(event)
	if gameUI.getConfig(gameUI._EFFECTS) == 1 then
		setEffects(0)
	else
		setEffects(1)
	end
	gameUI.vibrate()
	gameUI.playEventSound( mydata.options_btn_effects_click )
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
end

function vibrate(event)
	if gameUI.getConfig(gameUI._VIBRATE) == 1 then
		setVibrate(0)
	else
		setVibrate(1)
	end
	gameUI.vibrate()
	gameUI.playEventSound( mydata.options_btn_vibrate_click )
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
end

local function level(event)
	gameUI.vibrate()
	gameUI.playEventSound( mydata.options_btn_level_click )
	local level = gameUI.getConfig(_LEVEL)
	level = math.fmod( level, 3 ) + 1
	selectLevel(level)
end

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

function scene:create(event)
	local screenGroup = self.view

	local backgroundOverlay = display.newRect (gameUI.width()/2, gameUI.height()/2, gameUI.width(), gameUI.height())
	backgroundOverlay:setFillColor( 0 )
	backgroundOverlay.alpha = 0.6
	screenGroup:insert(backgroundOverlay)

	local overlay = nil
	if(options_bg) then
		overlay = gameUI.addButton(options_bg, gameUI.width()/2, gameUI.height()/2 + 5, options_bg_width, options_bg_height)
	else
		overlay = display.newRoundedRect( gameUI.width()/2, gameUI.height()/2 + 5, options_bg_width, options_bg_height, 12 )
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

	local optionsTitle = display.newText(options_title, overlay.x, overlay.top, options_title_font, options_title_font_size)
	optionsTitle:setFillColor(1)
	screenGroup:insert(optionsTitle)

	backBtn = gameUI.addButton(options_btn_back, overlay.right - 20, overlay.top, options_btn_back_width, options_btn_back_height, options_btn_back_color)
	backBtn.anchorX = 1
	screenGroup:insert(backBtn)

	backText = gameUI.addText( "X", backBtn.x-backBtn.width*0.45, backBtn.y-backBtn.height*0.01, options_btn_back_height*0.75)
	backText:setFillColor(1)
	screenGroup:insert(backText)

	local collumnEq = overlay.x
	local collumn = {collumnEq + 0, collumnEq + 20}
	local lineNum = 5
	local lineEq = overlay.height/(lineNum)
	local shift = overlay.top-50
	local line = {lineEq*1+shift, lineEq*2+shift, lineEq*3+shift, lineEq*4+shift, lineEq*5+shift}

	local musicText = display.newText(options_txt_music, collumn[1], line[2], options_txt_music_font, options_txt_music_font_size)
	musicText.anchorX = 1
	musicText:setFillColor(1)
	screenGroup:insert(musicText)

	local effectsText = display.newText(options_txt_effects, collumn[1], line[3], options_txt_effects_font, options_txt_effects_font_size)
	effectsText.anchorX = 1
	effectsText:setFillColor(1)
	screenGroup:insert(effectsText)

	local vibrateText = display.newText(options_txt_vibrate, collumn[1], line[4], options_txt_vibrate_font, options_txt_vibrate_font_size)
	vibrateText.anchorX = 1
	vibrateText:setFillColor(1)
	screenGroup:insert(vibrateText)

	local levelText = display.newText(options_txt_level, collumn[1], line[5], options_txt_level_font, options_txt_level_font_size)
	levelText.anchorX = 1
	levelText:setFillColor(1)
	screenGroup:insert(levelText)

	musicBtnOn = gameUI.addButton(options_btn_music_on, collumn[2], line[2], options_btn_music_width, options_btn_music_height, options_btn_music_on_color)
	musicBtnOn.x = musicBtnOn.x + musicBtnOn.width/2
	screenGroup:insert(musicBtnOn)
	musicTextOn = gameUI.addText( options_btn_music_on_text, musicBtnOn.x, musicBtnOn.y,
										  options_btn_music_font_size, options_btn_music_font)
	musicTextOn:setFillColor(1)
	screenGroup:insert(musicTextOn)

	musicBtnOff = gameUI.addButton(options_btn_music_off, collumn[2], line[2], options_btn_music_width, options_btn_music_height, options_btn_music_off_color)
	musicBtnOff.x = musicBtnOff.x + musicBtnOff.width/2
	screenGroup:insert(musicBtnOff)
	musicTextOff = gameUI.addText( options_btn_music_off_text, musicBtnOff.x, musicBtnOff.y,
										  options_btn_music_font_size, options_btn_music_font)
	musicTextOff:setFillColor(1)
	screenGroup:insert(musicTextOff)

	effectsBtnOn = gameUI.addButton(options_btn_effects_on, collumn[2], line[3], options_btn_effects_width, options_btn_effects_height, options_btn_effects_on_color)
	effectsBtnOn.x = effectsBtnOn.x + effectsBtnOn.width/2
	screenGroup:insert(effectsBtnOn)
	effectsTextOn = gameUI.addText( options_btn_effects_on_text, effectsBtnOn.x, effectsBtnOn.y,
										  options_btn_effects_font_size, options_btn_effects_font)
	effectsTextOn:setFillColor(1)
	screenGroup:insert(effectsTextOn)

	effectsBtnOff = gameUI.addButton(options_btn_effects_off, collumn[2], line[3], options_btn_effects_width, options_btn_effects_height, options_btn_effects_off_color)
	effectsBtnOff.x = effectsBtnOff.x + effectsBtnOff.width/2
	screenGroup:insert(effectsBtnOff)
	effectsTextOff = gameUI.addText( options_btn_effects_off_text, effectsBtnOff.x, effectsBtnOff.y,
										  options_btn_effects_font_size, options_btn_effects_font)
	effectsTextOff:setFillColor(1)
	screenGroup:insert(effectsTextOff)

	vibrateBtnOn = gameUI.addButton(options_btn_vibrate_on, collumn[2], line[4], options_btn_vibrate_width, options_btn_vibrate_height, options_btn_vibrate_on_color)
	vibrateBtnOn.x = vibrateBtnOn.x + vibrateBtnOn.width/2
	screenGroup:insert(vibrateBtnOn)
	vibrateTextOn = gameUI.addText( options_btn_vibrate_on_text, vibrateBtnOn.x, vibrateBtnOn.y,
										  options_btn_vibrate_font_size, options_btn_vibrate_font)
	vibrateTextOn:setFillColor(1)
	screenGroup:insert(vibrateTextOn)

	vibrateBtnOff = gameUI.addButton(options_btn_vibrate_off, collumn[2], line[4], options_btn_vibrate_width, options_btn_vibrate_height, options_btn_vibrate_off_color)
	vibrateBtnOff.x = vibrateBtnOff.x + vibrateBtnOff.width/2
	screenGroup:insert(vibrateBtnOff)
	vibrateTextOff = gameUI.addText( options_btn_vibrate_off_text, vibrateBtnOff.x, vibrateBtnOff.y,
										  options_btn_vibrate_font_size, options_btn_vibrate_font)
	vibrateTextOff:setFillColor(1)
	screenGroup:insert(vibrateTextOff)

	levelBtnEasy = gameUI.addButton(options_btn_level_easy, collumn[2], line[5], options_btn_level_width, options_btn_level_height, options_btn_level_easy_color)
	levelBtnEasy.x = levelBtnEasy.x + levelBtnEasy.width/2
	screenGroup:insert(levelBtnEasy)
	levelTextEasy = gameUI.addText( options_btn_level_easy_text, levelBtnEasy.x, levelBtnEasy.y,
										  options_btn_level_easy_font_size, options_btn_level_easy_font)
	levelTextEasy:setFillColor(1)
	screenGroup:insert(levelTextEasy)

	levelBtnNormal = gameUI.addButton(options_btn_level_normal, collumn[2], line[5], options_btn_level_width, options_btn_level_height, options_btn_level_normal_color)
	levelBtnNormal.x = levelBtnNormal.x + levelBtnNormal.width/2
	screenGroup:insert(levelBtnNormal)
	levelTextNormal = gameUI.addText( options_btn_level_normal_text, levelBtnNormal.x, levelBtnNormal.y,
											options_btn_level_normal_font_size, options_btn_level_normal_font)
	levelTextNormal:setFillColor(1)
	screenGroup:insert(levelTextNormal)

	levelBtnHard = gameUI.addButton(options_btn_level_hard, collumn[2], line[5], options_btn_level_width, options_btn_level_height, options_btn_level_hard_color)
	levelBtnHard.x = levelBtnHard.x + levelBtnHard.width/2
	screenGroup:insert(levelBtnHard)
	levelTextHard = gameUI.addText( options_btn_level_hard_text, levelBtnHard.x, levelBtnHard.y,
										  options_btn_level_hard_font_size, options_btn_level_hard_font)
	levelTextHard:setFillColor(1)
	screenGroup:insert(levelTextHard)

	selectLevel()
	setMusic()
	setEffects()
	setVibrate()
end

function scene:show(event)
	if ( event.phase == "will" ) then
		composer.isOverlay = true
		composer.currentScene = "options"
		composer.returnTo = "start"
	elseif ( event.phase == "did" ) then
		musicBtnOn:addEventListener("tap", music)
		musicBtnOff:addEventListener("tap", music)
		effectsBtnOn:addEventListener("tap", effects)
		effectsBtnOff:addEventListener("tap", effects)
		vibrateBtnOn:addEventListener("tap", vibrate)
		vibrateBtnOff:addEventListener("tap", vibrate)
		levelBtnEasy:addEventListener("tap", level)
		levelBtnNormal:addEventListener("tap", level)
		levelBtnHard:addEventListener("tap", level)

		backBtn:addEventListener ("tap", back)
	end
end

function scene:hide(event)
	if ( event.phase == "will" ) then
		musicBtnOn:removeEventListener("tap", music)
		musicBtnOff:removeEventListener("tap", music)
		effectsBtnOn:removeEventListener("tap", effects)
		effectsBtnOff:removeEventListener("tap", effects)
		vibrateBtnOn:removeEventListener("tap", vibrate)
		vibrateBtnOff:removeEventListener("tap", vibrate)
		levelBtnEasy:removeEventListener("tap", level)
		levelBtnNormal:removeEventListener("tap", level)
		levelBtnHard:removeEventListener("tap", level)

		backBtn:removeEventListener ("tap", back)
	elseif ( event.phase == "did" ) then
		event.parent:resumeStart()
		composer.removeScene( "options" )
	end
end

function scene:destroy(event)

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
