-- requires 

local composer = require ("composer")
local mydata = require( "mydata" )
local gameUI = require ("gameUI")
local defines = require( "defines" )
local score = require( "score" )

local scene = composer.newScene()

local function retry(event)
	print("Start")
	gameUI.vibrate()
	retryBtn.xScale = 0.9
	retryBtn.yScale = 0.9
	gameUI.playEventSound( mydata.gameover_btn_retry_click )
	gameUI.stop()
	composer.gotoScene("game", "fade", 400)
end

local function menu(event)
	print("Menu")
	gameUI.vibrate()
	menuBtn.xScale = 0.9
	menuBtn.yScale = 0.9
	gameUI.playEventSound( mydata.gameover_btn_menu_click )
	gameUI.stop()

	local evt = {phase = "will"}
	scene:hide(evt)

	composer.gotoScene("start", "fade", 400)
end
function hideOverlay(event)
	menu(event)
end

function scene:create(event)
	local screenGroup = self.view

	local backgroundOverlay = display.newRect (gameUI.width()/2, gameUI.height()/2, gameUI.width(), gameUI.height())
	backgroundOverlay:setFillColor( 0 )
	backgroundOverlay.alpha = 0.6
	screenGroup:insert(backgroundOverlay)

	local overlay = nil
	if(gameover_bg) then
		overlay = gameUI.addButton(gameover_bg, gameUI.width()/2, gameUI.height()/2 + 5, gameover_bg_width, gameover_bg_height)
	else
		overlay = display.newRoundedRect( gameUI.width()/2, gameUI.height()/2 + 5, gameover_bg_width, gameover_bg_height, 12 )
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

	local gameoverTitle = display.newText(gameover_title, overlay.x, overlay.top, gameover_title_font, gameover_title_font_size)
	gameoverTitle:setFillColor(1)
	screenGroup:insert(gameoverTitle)

	local collumnNum = 3
	local collumnEq = overlay.width/(collumnNum+1)
	local collumn = {overlay.left+collumnEq*1,overlay.left+collumnEq*2,overlay.left+collumnEq*3,overlay.left+collumnEq*4}
	local lineNum = 3
	local lineEq = overlay.height/(lineNum)
	local shift = overlay.top-lineEq/2
	local line = {lineEq*1+shift, lineEq*2+shift, lineEq*3+shift}

	local levelText = display.newText(gameUI.getLevelText(), overlay.x, line[1]+15, gameover_txt_level_font, gameover_txt_level_font_size)
	levelText:setFillColor(1)
	screenGroup:insert(levelText)

	local scoreText = display.newText(gameover_txt_score, collumn[1], line[2], gameover_txt_score_font, gameover_txt_score_font_size)
	scoreText.anchorY = 1
	scoreText:setFillColor(1)
	screenGroup:insert(scoreText)

	local scoreTextVal = display.newText(score.getScore(), collumn[1], line[2], gameover_txt_val_score_font, gameover_txt_val_score_font_size)
	scoreTextVal.anchorY = 0
	scoreTextVal:setFillColor(1)
	screenGroup:insert(scoreTextVal)

	local bestText = display.newText(gameover_txt_best, collumn[3], line[2], gameover_txt_best_font, gameover_txt_best_font_size)
	bestText.anchorY = 1
	bestText:setFillColor(1)
	screenGroup:insert(bestText)

	local bestTextVal = display.newText(score.getBest(), collumn[3], line[2], gameover_txt_val_best_font, gameover_txt_val_best_font_size)
	bestTextVal.anchorY = 0
	bestTextVal:setFillColor(1)
	screenGroup:insert(bestTextVal)

	menuBtn = gameUI.addButton(gameover_btn_menu, collumn[1], line[3], gameover_btn_menu_width, gameover_btn_menu_height, gameover_btn_menu_color)
	screenGroup:insert(menuBtn)

	retryBtn = gameUI.addButton(gameover_btn_retry, collumn[3], line[3], gameover_btn_retry_width, gameover_btn_retry_height, gameover_btn_retry_color)
	screenGroup:insert(retryBtn)

	bgChannel = gameUI.play( mydata.gameover_bg_sound, gameover_bg_sound_options )
end

function scene:show(event)
	if ( event.phase == "will" ) then
		composer.isOverlay = true
		composer.currentScene = "gameover"
		composer.returnTo = "start"
	elseif ( event.phase == "did" ) then
		menuBtn:addEventListener("tap", menu)
		retryBtn:addEventListener("tap", retry)

		audio.resume()
	end
end

function scene:hide(event)
	if ( event.phase == "will" ) then
		menuBtn:removeEventListener("tap", menu)
		retryBtn:removeEventListener("tap", retry)

		gameUI.stop()
	elseif ( event.phase == "did" ) then
		composer.removeScene( "gameover", true )
	end
end

function scene:destroy(event)

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
