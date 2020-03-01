-- requires
local composer = require ("composer")
local mydata = require( "mydata" )
local gameUI = require ("gameUI")
local defines = require("defines")
local score = require("score")
local social = require("social")

local scene = composer.newScene()

local addListeners
local removeListeners

local function start(event)
	print("==> Enter Start")
	gameUI.vibrate()
	startText.alpha = 0.5
	startText.xScale = 0.9
	startText.yScale = 0.9
	startBtn.xScale = 0.9
	startBtn.yScale = 0.9
	gameUI.playEventSound( mydata.start_btn_start_click )
	gameUI.stop()
	composer.gotoScene("game", "fade", 400)
end

local function options(event)
	print("==> Enter Options")
	gameUI.vibrate()
	optionsBtn.xScale = 0.9
	optionsBtn.yScale = 0.9

	removeListeners()

	gameUI.playEventSound( mydata.start_btn_options_click )
	local options = {
		isModal = true,
		effect = "fade",
		time = 400,
	}
	composer.showOverlay("options", options)
end

local function leaderboard(event)
	print("==> Enter Leaderboard")
	gameUI.vibrate()
	leaderboardBtn.xScale = 0.9
	leaderboardBtn.yScale = 0.9
	gameUI.playEventSound( mydata.start_btn_leaderboard_click )

	gameNet.postScore(score.getBest(1), 1)
	gameNet.postScore(score.getBest(2), 2)
	gameNet.postScore(score.getBest(3), 3)

	gameNet.showLeaderboards()

	timer.performWithDelay( 2000, resetButtons, 1 )
end

local function achievements(event)
	print("==> Enter Achievements")
	gameUI.vibrate()
	achievementsBtn.xScale = 0.9
	achievementsBtn.yScale = 0.9
	gameUI.playEventSound( mydata.start_btn_achievements_click )

	gameNet.showAchievements()

	timer.performWithDelay( 2000, resetButtons, 1 )
end

local function share(event)
	print("==> Enter Share")
	gameUI.vibrate()
	shareBtn.xScale = 0.9
	shareBtn.yScale = 0.9
	gameUI.playEventSound( mydata.start_btn_share_click )

	social.socialShare()

	timer.performWithDelay( 2000, resetButtons, 1 )
end

local function info(event)
	print("==> Enter Info")
	gameUI.vibrate()
	infoBtn.xScale = 0.9
	infoBtn.yScale = 0.9
	gameUI.playEventSound( mydata.start_btn_info_click )

	local onComplete = function ( event )
		print("Info response = " .. event.index)
		if(event.index == 2) then
			if native.canShowPopup( "mail" ) then
				native.showPopup( "mail", {to = global_my_mail, subject = "My JetBomb comments"} )
			else
				native.showAlert(
					"E-mail",
					"Error to send e-mail. Please, come back later.",
					{ "OK" } )
			end
		end
	end

	native.showAlert(
		"Info",
		"Developed by Rodrigo Brum.\nPlease, send your comments or bug reports to my mail.",
		{ "OK", "E-mail" }, onComplete )

	timer.performWithDelay( 2000, resetButtons, 1 )
end

local function help(event)
	print("==> Enter Help")
	gameUI.vibrate()
	helpBtn.xScale = 0.9
	helpBtn.yScale = 0.9
	gameUI.playEventSound( mydata.start_btn_help_click )

	removeListeners()

	local options = {
		isModal = true,
		effect = "fade",
		time = 400,
		params = {
			returnTo = "start"
		},
	}
	composer.showOverlay("help", options)
end

function scene:resumeStart()
	resetButtons()

	addListeners()
	
	local evt = {phase = "will"}
	scene:show(evt)
end

function resetButtons()
	optionsBtn.xScale = 1
	optionsBtn.yScale = 1
	leaderboardBtn.xScale = 1
	leaderboardBtn.yScale = 1
	achievementsBtn.xScale = 1
	achievementsBtn.yScale = 1
	shareBtn.xScale = 1
	shareBtn.yScale = 1
	infoBtn.xScale = 1
	infoBtn.yScale = 1
	helpBtn.xScale = 1
	helpBtn.yScale = 1
end

local function moveBgObj(self, event)
	if (self.pair.x <= 0) then
		self.x = self.pair.x + self.pair.width
	end
	self.x = self.x - self.speed
end

function scene:create(event)
	local screenGroup = self.view

	local bg = gameUI.addBG(start_bg)
	screenGroup:insert(bg)

	local function shakeIt(obj)
		transition.to( obj, { time=obj.totalTime/2, x=obj.x+obj.xMove, y=obj.y+obj.yMove, transition=easing.inOutSine } )
		transition.to( obj, { delay=obj.totalTime/2, time=obj.totalTime/2, x=obj.x, y=obj.y, transition=easing.inOutSine, onComplete=shakeIt } )
	end
	local function shakeObj(obj, totalTime, xMove, yMove)
		obj.totalTime = totalTime
		obj.xMove = xMove
		obj.yMove = yMove
		obj.x = obj.x - obj.xMove/2
		obj.y = obj.y - obj.yMove/2
		shakeIt(obj)
	end

	local shakeEasing = function(currentTime, duration, startValue, targetDelta)
		local shakeAmplitude = 5 -- maximum shake in pixels, at start of shake
		local timeFactor = 0.3--(duration-currentTime)/duration -- goes from 1 to 0 during the transition
		local scaledShake =( timeFactor*shakeAmplitude)+1 -- adding 1 prevents scaledShake from being less then 1 which would throw an error in the random code in the next line
		local randomShake = math.random(scaledShake)
		return startValue + randomShake - scaledShake*0.5 -- the last part detracts half the possible max shake value so the shake is "symmetrical" instead of always being added at the same side
	end -- shakeEasing

	start_bg_obj_base_width = start_bg_obj_base_width + start_bg_obj_speed
	objBase1 = gameUI.addBgObj(start_bg_obj_base, start_bg_obj_base_width, start_bg_obj_base_height)
	objBase1.name = "objBase1"
	objBase1.speed = start_bg_obj_speed
	screenGroup:insert(objBase1)

	objBase2 = gameUI.addBgObj(start_bg_obj_base, start_bg_obj_base_width, start_bg_obj_base_height, start_bg_obj_base_invert)
	objBase2.name = "objBase2"
	objBase2.speed = objBase1.speed
	objBase2.x = objBase1.width--gameUI.width()
	screenGroup:insert(objBase2)

	objBase1.pair = objBase2
	objBase2.pair = objBase1

	shareBtn = gameUI.addButton(start_btn_share, 20, 20, start_btn_share_width, start_btn_share_height, start_btn_share_color)
	shareBtn.x = shareBtn.x+(shareBtn.width/2)
	shareBtn.y = shareBtn.y+(shareBtn.height/2)
	screenGroup:insert(shareBtn)

	achievementsBtn = gameUI.addButton(start_btn_achievements, shareBtn.x+(shareBtn.width/2)+5, shareBtn.y, start_btn_achievements_width, start_btn_achievements_height, start_btn_achievements_color)
	achievementsBtn.x = achievementsBtn.x+(achievementsBtn.width/2)
	screenGroup:insert(achievementsBtn)

	leaderboardBtn = gameUI.addButton(start_btn_leaderboard, achievementsBtn.x+(achievementsBtn.width/2)+5, shareBtn.y, start_btn_leaderboard_width, start_btn_leaderboard_height, start_btn_leaderboard_color)
	leaderboardBtn.x = leaderboardBtn.x+(leaderboardBtn.width/2)
	screenGroup:insert(leaderboardBtn)

	optionsBtn = gameUI.addButton(start_btn_options, leaderboardBtn.x+(leaderboardBtn.width/2)+5, shareBtn.y, start_btn_options_width, start_btn_options_height, start_btn_options_color)
	optionsBtn.x = optionsBtn.x+(optionsBtn.width/2)
	screenGroup:insert(optionsBtn)

	infoBtn = gameUI.addButton(start_btn_info, gameUI.width() - 20, shareBtn.y, start_btn_info_width, start_btn_info_height, start_btn_info_color)
	infoBtn.x = infoBtn.x-(infoBtn.width/2)
	screenGroup:insert(infoBtn)

	helpBtn = gameUI.addButton(start_btn_help, infoBtn.x-(infoBtn.width/2)-5, infoBtn.y, start_btn_help_width, start_btn_help_height, start_btn_help_color)
	helpBtn.x = helpBtn.x-(helpBtn.width/2)
	screenGroup:insert(helpBtn)

	startBtn = gameUI.addButton(start_btn_start, gameUI.width()-20, gameUI.height()-20, start_btn_start_width, start_btn_start_height, start_btn_start_color)
	startBtn.x = startBtn.x - startBtn.width/2
	startBtn.y = startBtn.y - startBtn.height/2
	screenGroup:insert(startBtn)

	startText = gameUI.addText( start_btn_start_text, startBtn.x, startBtn.y, start_btn_start_font_size, start_btn_start_font)
	startText:setFillColor(1)
	screenGroup:insert(startText)

	local logoText = gameUI.addButton(start_logo_text_obj, startBtn.x+(startBtn.width/2), startBtn.y*0.4, start_logo_text_obj_width, start_logo_text_obj_height)
	logoText.anchorX = 1
	screenGroup:insert(logoText)

	local objBack = gameUI.addBomb(start_img_obj_back, start_img_obj_back_width, start_img_obj_back_height,
		start_img_obj_back1, start_img_obj_back1_options, start_img_obj_back1_sprite,
		{start_img_obj_back1_width_scale, start_img_obj_back1_height_scale}, {start_img_obj_back1_X, start_img_obj_back1_Y})
	objBack.x = logoText.x-(logoText.width*0.425)
	objBack.y = logoText.y
	objBack.spark:play()
	screenGroup:insert(objBack)
	transition.to(objBack, {time=1000, x=objBack.x, y=objBack.y, transition=shakeEasing, iterations=0}) -- use the displayObjects current x and y as parameter

	local logoJet = gameUI.addJet(start_logo_jet_obj, start_logo_jet_obj_width, start_logo_jet_obj_height,
		start_logo_jet_obj1, start_logo_jet_obj1_options, start_logo_jet_obj1_sprite,
		{start_logo_jet_obj1_width_scale, start_logo_jet_obj1_height_scale}, {start_logo_jet_obj1_X, start_logo_jet_obj1_Y})
	logoJet.x = bg.x-(bg.width*0.5) + (logoJet.width*0.5)
	logoJet.y = logoText.y+(logoText.height*0.7)
	logoJet.flame:play()
	screenGroup:insert(logoJet)
	shakeObj(logoJet, 2000, 0, 20)

	gameUI.loadConfig()

	bgChannel = gameUI.play( mydata.start_bg_sound, start_bg_sound_options )
end

function addListeners()
	print("START addListeners")

	startBtn:addEventListener("tap", start)

	optionsBtn:addEventListener("tap", options)
	leaderboardBtn:addEventListener("tap", leaderboard)
	achievementsBtn:addEventListener("tap", achievements)
	shareBtn:addEventListener("tap", share)
	infoBtn:addEventListener("tap", info)
	helpBtn:addEventListener("tap", help)
end

function scene:show(event)
	if ( event.phase == "will" ) then
		composer.currentScene = "start"
		composer.returnTo = nil
		composer.isOverlay = false
	elseif ( event.phase == "did" ) then
		addListeners()

		objBase1.enterFrame = moveBgObj
		Runtime:addEventListener("enterFrame", objBase1)
		objBase2.enterFrame = moveBgObj
		Runtime:addEventListener("enterFrame", objBase2)

		audio.resume()
	end
end

function removeListeners()
	print("START removeListeners")

	startBtn:removeEventListener("tap", start)

	optionsBtn:removeEventListener("tap", options)
	leaderboardBtn:removeEventListener("tap", leaderboard)
	achievementsBtn:removeEventListener("tap", achievements)
	shareBtn:removeEventListener("tap", share)
	infoBtn:removeEventListener("tap", info)
	helpBtn:removeEventListener("tap", help)
end

function scene:hide(event)
	if ( event.phase == "will" ) then
		removeListeners()

		Runtime:removeEventListener("enterFrame", objBase1)
		Runtime:removeEventListener("enterFrame", objBase2)

		gameUI.stop()
	elseif ( event.phase == "did" ) then
		composer.removeScene( "start", true )
	end
end

function scene:destroy(event)
	print("destroy")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
