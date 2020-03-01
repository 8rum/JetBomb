-- requires

local physics = require ("physics")
local composer = require ("composer")
local mydata = require ("mydata")
local gameUI = require ("gameUI")
local score = require("score")
local defines = require( "defines" )
local progressBar = require( "progressBar" )
local GA = require ( "plugin.gameanalytics" )

local scene = composer.newScene()
physics.start()
if(SIMULATION) then physics.setDrawMode( "hybrid" ) end

local addListeners

local mainSpeed = 0
local increaseStep = 0.02

local function increaseSpeed(newStep)
	newStep = newStep or increaseStep

	obj1.speed = obj1.speed + newStep*0.5
	obj2.speed = obj1.speed
	obj3.speed = obj3.speed + newStep
	obj4.speed = obj3.speed

	--print("Bg speed: "..obj3.speed)

	mainSpeed = mainSpeed + newStep
	--print("Main speed step: "..newStep.." - Total speed: "..mainSpeed)

	for i=1, mines.numChildren do
		mines[i].speed = mines[i].speed + newStep
	end
end

local boostSpeed = 10
local zBoost = false
local boostTotalTime = 5
local boostTime = 0
local boostForEachMine = 0.2
local boost

local function boostBar (event)
	boostTime = boostTime - 1/display.fps
	--print("Boost time: "..boostTime)
	if(boostTime <= 0) then
		local evt = {phase = "ended"}
		boost(evt)
	end
end

function boost(event)
	if event.phase == "began" and not zBoost then
		if(boostTime <= 0) then return true end
		print("Boost ===>>>")
		jet:setLinearVelocity( 0, 0 )
		jet.gravityScale = 0
		zBoost = true
		increaseSpeed(boostSpeed)
		Runtime:addEventListener("enterFrame", boostBar)
		return true
	end

	if event.phase == "ended" and zBoost then
		print("<<<=== Boost")
		jet.gravityScale = 1
		jet.bodyType = "static"
		jet.bodyType = "dynamic"
		zBoost = false
		increaseSpeed(-boostSpeed)
		Runtime:removeEventListener("enterFrame", boostBar)
		return false
	end
end

local function resetMine(mine)
	mine.x = gameUI.width() + mine.width
	mine.y = math.random(20, gameUI.height() - 20)
	mine.speed = math.random(2+mainSpeed,5+mainSpeed)
	mine.initY = mine.y
	mine.amp = math.random(20,100)
	mine.angle = math.random(1,360)

	--reset to initial scale
	local originalXscale = 1
	if mine.myXscale then
		originalXscale = mine.width / (mine.width * mine.myXscale)
	end
	local originalYscale = 1
	if mine.myXscale then
		originalYscale = mine.height / (mine.height * mine.myYscale)
	end
	mine:scale(originalXscale, originalYscale)

	local newScale = math.random(100-game_img_mine_scale,100+game_img_mine_scale) / 100
	mine.myXscale = newScale * game_img_mine_width_scale
	mine.myYscale = newScale * game_img_mine_height_scale
	mine:scale(mine.myXscale, mine.myYscale)
	mine.scoreAdded = false
	mine.radius = mine.width * mine.myXscale / 2 * game_img_mine_physics_radius
	game_img_mine_physics["radius"] = mine.radius
	physics.addBody(mine, "static", game_img_mine_physics)
end

function addMines(groupMines)

	mainSpeed = 0
	number = 3
	if gameUI.getConfig(gameUI._LEVEL) == 3 then
		number = 5
	end

	for i=1, number do
		mine = gameUI.addBomb(game_img_mine, game_img_mine_width, game_img_mine_height,
			game_img_mine1, game_img_mine1_options, game_img_mine1_sprite,
			{game_img_mine1_width_scale, game_img_mine1_height_scale}, {game_img_mine1_X, game_img_mine1_Y})

		resetMine(mine)
		mine.x = gameUI.width() + 200
		groupMines:insert(mine)
	end
end

local sin = math.sin
local function moveMines(self, event)
	if not self.isVisible then return end
	if self.x < -self.width then
		physics.removeBody( self )
		resetMine(self)
	else
		if(self.scoreAdded == false and self.x < jet.x and jet.isVisible == true) then
			newScore = newScore + 1
			scoreText.text = string.format("%s%03d", game_txt_score, newScore)
			self.scoreAdded = true

			if (newScore % 50 == 0) then
				increaseStep = increaseStep * 0.5
			end

			increaseSpeed()
			boostTime = boostTime + boostForEachMine
			if (boostTime > boostTotalTime) then
				boostTime = boostTotalTime
			end
			--if (newScore % 5 == 0) then
			--end
		end

		self.x = self.x - self.speed
		if (gameUI.getConfig(gameUI._LEVEL)) > 1 then
			self.angle = self.angle + .1
			self.y = self.amp*sin(self.angle)+self.initY
		end
	end
end


function jetReady()
	boostBtn.isVisible = true
	jet.bodyType = "dynamic"
	print ("JET READY!")
end

local function activateJets(self,event)
	if(self.bodyType == "dynamic") then
		self:applyForce(0, game_img_jet_force, self.x, self.y)
		local Vx, Vy = self:getLinearVelocity()
		if (Vy < game_img_jet_force_limit) then
			self:setLinearVelocity( 0, game_img_jet_force_limit )
		end
	end
end

local function setBar()
	--local Vx, Vy = jet:getLinearVelocity()
	--bar:setProgress(-Vy)
	bar:setProgress(boostTime)
end

local function touchScreen(event)
	--print("touch")
	if event.phase == "began" then
		jet.enterFrame = activateJets
		Runtime:addEventListener("enterFrame", jet)
	end

	if event.phase == "ended" then
		if(zBoost) then
			return boost(event)
		end
		local Vx, Vy = jet:getLinearVelocity()
		jet:setLinearVelocity( 0, Vy*game_img_jet_force_break )
		Runtime:removeEventListener("enterFrame", jet)
	end
end

local function gameOver()
	score.setScore(newScore)

	gameUI.showAdInterstitial()

	gameUI.stop()
	composer.showOverlay("gameover", "fade", 400, {isModal = true})
end

local function explode(xPos, yPos)
	local evt = {phase = "ended"}
	boost(evt)
	boostBtn.isVisible = false
	pauseBtn.isVisible = false
	pauseText.isVisible = false
	gameUI.playEventSound( mydata.game_img_explosion_sound )
	gameUI.stop()
	explosion.x = xPos
	explosion.y = yPos
	explosion.isVisible = true
	explosion:play()
	transition.to( explosion, { time=explosion.time, xScale=0.5, yScale=0.5, iterations=1 } )
	gameUI.vibrate(1000)
	timer.performWithDelay(3000, gameOver, 1)
end

local function onJetCollision(self, event)
	if event.phase == "began" then
		if self.collided == false then
			self.collided = true
			event.object1.bodyType = "static"
			event.object1.isVisible = false
			event.object2.bodyType = "static"
			event.object2.isVisible = false
			explode(self.x, self.y)

			bar:setProgress(0)
			Runtime:removeEventListener("enterFrame", bar)
		end
	end
end

local function pause(event)
	if(pauseBtn.isVisible) then
		gameUI.vibrate()
		gameUI.playEventSound( mydata.game_btn_pause_click )

		local evt = {phase = "will"}
		scene:hide(evt)

		pauseText.alpha = 0.5
		pauseText.xScale = 0.9
		pauseText.yScale = 0.9
		pauseBtn.xScale = 0.9
		pauseBtn.yScale = 0.9

		composer.showOverlay("pause", "fade", 400, {isModal = true})
		return true
	end
	return false
end

local function onKeyEvent( event )
	local phase = event.phase
	local keyName = event.keyName

	if ( ("back" == keyName or "deleteBack" == keyName) and phase == "up" ) then
		composer.currentScene = nil
		pause(event)
		return true
	end

	if ( ("space" == keyName) and phase == "down" ) then
		local evt = {phase = "began"}
		boost(evt)
		return true
	end

	if ( ("space" == keyName) and phase == "up" ) then
		local evt = {phase = "ended"}
		boost(evt)
		return true
	end

	return false
end

local function onSystemEvent( event )
	if event.type == "applicationSuspend" then
		print("SUSPEND!")
		pause(event)
--		return true
	end
	return false
end

function scene:resumeStart()
	addListeners()
	
	local evt = {phase = "will"}
	scene:show(evt)
end

local function checkHelp()
	if (gameUI.getConfig(gameUI._SHOW_HELP) == 1) then
		local evt = {phase = "will"}
		scene:hide(evt)

		local options = {
			isModal = true,
			effect = "fade",
			time = 400,
			params = {
				returnTo = "game"
			},
		}
		composer.showOverlay("help", options)
	end
end

local function listener( event )
	count = count - 1
	print( "count ", count )
	if(count <= 0) then
		countText:removeSelf()
		countText = nil
		addListeners()
	else
		countText.text = count
		timer.performWithDelay( 1000, listener )
	end
end

function scene:resumeGame()
	count = 3
	print( "count ", count )
	countText = display.newText(count, gameUI.width()/2, gameUI.height()/2, game_txt_count_font, game_txt_count_font_size)
	timer.performWithDelay( 1000, listener )

	pauseText.alpha = 1
	pauseText.xScale = 1
	pauseText.yScale = 1
	pauseBtn.xScale = 1
	pauseBtn.yScale = 1
end

local function moveBgObj(self, event)
	if (self.pair.x <= 0) then
		self.x = self.pair.x + self.pair.width
	end
	self.x = self.x - self.speed
end

function scene:create(event)
	local screenGroup = self.view

	local bg = gameUI.addBG(game_bg)
	screenGroup:insert(bg)

	game_bg_obj1_width = game_bg_obj1_width + game_bg_obj1_speed
	obj1 = gameUI.addBgObj(game_bg_obj1, game_bg_obj1_width, game_bg_obj1_height)
	obj1.name = "obj1"
	obj1.speed = game_bg_obj1_speed
	screenGroup:insert(obj1)

	obj2 = gameUI.addBgObj(game_bg_obj1, game_bg_obj1_width, game_bg_obj1_height, game_bg_obj1_invert)
	obj2.name = "obj2"
	obj2.speed = obj1.speed
	obj2.x = obj1.width--gameUI.width()
	screenGroup:insert(obj2)

	obj1.pair = obj2
	obj2.pair = obj1

	game_bg_obj2_width = game_bg_obj2_width + game_bg_obj2_speed
	obj3 = gameUI.addBgObj(game_bg_obj2, game_bg_obj2_width, game_bg_obj2_height)
	obj3.name = "obj3"
	obj3.speed = game_bg_obj2_speed
	screenGroup:insert(obj3)

	obj4 = gameUI.addBgObj(game_bg_obj2, game_bg_obj2_width, game_bg_obj2_height, game_bg_obj2_invert)
	obj4.name = "obj4"
	obj4.speed = obj3.speed
	obj4.x = obj3.width--gameUI.width()
	screenGroup:insert(obj4)

	obj3.pair = obj4
	obj4.pair = obj3

	local ceiling = display.newRect( 0, -15, gameUI.width(), 50 )
	ceiling.anchorX = 0
	ceiling.anchorY = 1
	physics.addBody(ceiling, "static", {density=.1, bounce=0.1, friction=.2})
	screenGroup:insert(ceiling)

	local floor = display.newRect( 0, gameUI.height()+15, gameUI.width(), 50 )
	floor.anchorX = 0
	floor.anchorY = 0
	if(not SIMULATION) then physics.addBody(floor, "static", {density=.1, bounce=0.1, friction=.2}) end
	screenGroup:insert(floor)

	jet = gameUI.addJet(game_img_jet, game_img_jet_width, game_img_jet_height,
		game_img_jet1, game_img_jet1_options, game_img_jet1_sprite,
		{game_img_jet1_width_scale, game_img_jet1_height_scale}, {game_img_jet1_X, game_img_jet1_Y})

	jet.x = -80
	jet.y = 100
	jet.flame:play()
	jet.collided = false
	physics.addBody(jet, "static", game_img_jet_physics)
	jet.isFixedRotation = true

	screenGroup:insert(jet)
	transition.to(jet,{time=2000, x=100, onComplete=jetReady})

	explosionSpriteSheet = graphics.newImageSheet( game_img_explosion, game_img_explosion_options )
	explosion = display.newSprite( explosionSpriteSheet, game_img_explosion_sprite )
	explosion:scale(game_img_explosion_width_scale, game_img_explosion_height_scale)

	explosion.x = 100
	explosion.y = 100
	explosion.isVisible = false
	screenGroup:insert(explosion)

	mines = display.newGroup()
	screenGroup:insert(mines)

	addMines(mines)

	scoreText = display.newText(game_txt_score .. "000", gameUI.width() - 10, 10, game_txt_score_font, game_txt_score_font_size)
	scoreText:setFillColor(255,0,0)
	scoreText.anchorX = 0
	scoreText.anchorY = 0
	scoreText.x = scoreText.x - scoreText.width
	newScore = 0
	screenGroup:insert(scoreText)

	local celling = gameUI.addBgObj(game_img_celling, game_img_celling_width, game_img_celling_height)
	celling.anchorY = 0
	celling.y = 0
	screenGroup:insert(celling)

	local floor = gameUI.addBgObj(game_img_floor, game_img_floor_width, game_img_floor_height)
	screenGroup:insert(floor)

	pauseBtn = gameUI.addButton(game_img_pause, 10, 10, game_img_pause_width, game_img_pause_height, game_img_pause_color)
	pauseBtn.anchorX = 0
	pauseBtn.anchorY = 0
	screenGroup:insert(pauseBtn)

	pauseText = gameUI.addText( "||", pauseBtn.x+pauseBtn.width*0.53, pauseBtn.y+pauseBtn.height*0.45, game_img_pause_height*0.75)
	pauseText:setFillColor(1)
	screenGroup:insert(pauseText)

	boostBtn = display.newGroup()
	local boostBtnBase = gameUI.addButton(game_img_boost, 0, 0, game_img_boost_width, game_img_boost_height, game_img_boost_color)
	boostBtn:insert(boostBtnBase)

	local boostBtnIcon = gameUI.addButton(game_img_boost_icon, boostBtnBase.x, boostBtnBase.y, game_img_boost_icon_width, game_img_boost_icon_height, game_img_boost_icon_color)
	boostBtn:insert(boostBtnIcon)

	boostBtn.isVisible = false
	boostBtn.x = gameUI.width()-10 - boostBtn.width*0.5
	boostBtn.y = gameUI.height()-10 - boostBtn.height*0.5
	screenGroup:insert(boostBtn)

	boostTime = 0
	bar = progressBar:new({1, 0, 0, 0.8}, {1, 0, 0, 0.8}, {0}, 20, gameUI.height()*0.6, boostTotalTime)
	bar.x = boostBtn.x
	bar.y = gameUI.height()/2
	bar:setProgress(boostTime)
	screenGroup:insert(bar)

	if gameUI.getConfig(gameUI._LEVEL) == 1 then
		bgChannel = gameUI.play( mydata.game_bg_sound_easy, game_bg_sound_easy_options )
		boostForEachMine = 0.2
	elseif gameUI.getConfig(gameUI._LEVEL) == 3 then
		bgChannel = gameUI.play( mydata.game_bg_sound_hard, game_bg_sound_hard_options )
		boostForEachMine = 0.05
	else
		bgChannel = gameUI.play( mydata.game_bg_sound_normal, game_bg_sound_normal_options )
		boostForEachMine = 0.1
	end

	gameUI.newGameStarted()

	GA.newEvent ( "design", { event_id="Start:Level:"..gameUI.getConfig(gameUI._LEVEL), value=gameUI.getConfig(gameUI._LEVEL) } )
	GA.newEvent ( "design", { event_id="Start:Music:"..gameUI.getConfig(gameUI._MUSIC), value=gameUI.getConfig(gameUI._MUSIC) } )
	GA.newEvent ( "design", { event_id="Start:Effects:"..gameUI.getConfig(gameUI._EFFECTS), value=gameUI.getConfig(gameUI._EFFECTS) } )
	GA.newEvent ( "design", { event_id="Start:Vibrate:"..gameUI.getConfig(gameUI._VIBRATE), value=gameUI.getConfig(gameUI._VIBRATE) } )
end

function addListeners()
	pauseBtn:addEventListener("tap", pause)
	boostBtn:addEventListener("touch", boost)

	Runtime:addEventListener("touch", touchScreen)

	for i=1, mines.numChildren do
		mines[i].enterFrame = moveMines
		Runtime:addEventListener("enterFrame", mines[i])
		mines[i].spark:play()
	end
	
	jet.collision = onJetCollision
	Runtime:addEventListener("collision", jet)

	Runtime:addEventListener( "key", onKeyEvent )
	Runtime:addEventListener("system", onSystemEvent)

	jet.flame:play()

	obj1.enterFrame = moveBgObj
	Runtime:addEventListener("enterFrame", obj1)
	obj2.enterFrame = moveBgObj
	Runtime:addEventListener("enterFrame", obj2)
	obj3.enterFrame = moveBgObj
	Runtime:addEventListener("enterFrame", obj3)
	obj4.enterFrame = moveBgObj
	Runtime:addEventListener("enterFrame", obj4)

	bar.enterFrame = setBar
	Runtime:addEventListener("enterFrame", bar)

	transition.resume()
	physics.start()
	audio.resume()
end

function scene:show(event)
	print("Game " .. event.phase .. " show scene")
	if ( event.phase == "will" ) then
		-- LICENSE CHECK
		gameUI.checkLicense()
		composer.currentScene = "game"
		composer.returnTo = "game"
		composer.isOverlay = false
	elseif ( event.phase == "did" ) then
		addListeners()

		checkHelp()
	end
end

function scene:hide(event)
	print("Game " .. event.phase .. " hide scene")
	if ( event.phase == "will" ) then
		pauseBtn:removeEventListener("tap", pause)
		boostBtn:removeEventListener("touch", boost)

		Runtime:removeEventListener("touch", touchScreen)
		for i=1, mines.numChildren do
			Runtime:removeEventListener("enterFrame", mines[i])
			mines[i].spark:pause()
		end

		Runtime:removeEventListener("collision", onCollision)

		score.setScore(newScore)

		Runtime:removeEventListener( "key", onKeyEvent )
		Runtime:removeEventListener("system", onSystemEvent)

		jet.flame:pause()

		Runtime:removeEventListener("enterFrame", obj1)
		Runtime:removeEventListener("enterFrame", obj2)
		Runtime:removeEventListener("enterFrame", obj3)
		Runtime:removeEventListener("enterFrame", obj4)

		Runtime:removeEventListener("enterFrame", bar)
	
		transition.pause()
		physics.pause()
		gameUI.stop()
	elseif ( event.phase == "did" ) then
		composer.removeScene( "game", true )
	end
end

function scene:destroy(event)
	transition.cancel(jet)
	score.setScore(newScore)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
