local composer = require ("composer")
local mydata = require( "mydata" )
local gameUI = require ("gameUI")
local defines = require( "defines" )
local gameNet = require ("gameNet")
local GA = require ( "plugin.gameanalytics" )

if(not PRINT) then
	function _G.print()
		-- Do nothing
	end
end

-- Prepare AdMob
mydata.provider = "admob"
if gameUI.isAndroid() then
	mydata.bannerAppID = "ca-app-pub-7114321639623664/3456919631"  --for your Android banner
	mydata.interstitialAppID = "ca-app-pub-7114321639623664/5219527636"  --for your Android interstitial
else
	mydata.bannerAppID = "ca-app-pub-7114321639623664/7241207233"  --for your iOS banner
	mydata.interstitialAppID = "ca-app-pub-7114321639623664/2671406832"  --for your iOS interstitial
end

gameUI.initAd()
gameUI.showAdBanner()

--system.activate( "multitouch" )
display.setStatusBar( display.HiddenStatusBar )
--display.setDefault( "background", 0.5 ) -- 1=white - 0=black

-- print helpers
print( "Pixel width / height ", display.pixelWidth, " / ",  display.pixelHeight)
print( "Display actual width / height ", display.actualContentWidth, " / ",  display.actualContentHeight )
print( "Display content width / height ", display.contentWidth, " / ",  display.contentHeight )
print( "Display origin x / y ", display.screenOriginX, " / ",  display.screenOriginY )
print( "Sacale factor ", display.pixelWidth / display.actualContentHeight )

local imageSuffix = display.imageSuffix
print( "Image sufix ", imageSuffix )

print ("Platform name: ", system.getInfo("platformName"))

local clock = os.clock()

-- load audios
mydata.start_bg_sound = gameUI.loadStream( start_bg_sound )
mydata.start_btn_start_click = gameUI.newEventSound( start_btn_start_click )
mydata.start_btn_options_click = gameUI.newEventSound( start_btn_options_click )
mydata.start_btn_leaderboard_click = gameUI.newEventSound( start_btn_leaderboard_click )
mydata.start_btn_achievement_click = gameUI.newEventSound( start_btn_achievement_click )
mydata.start_btn_share_click = gameUI.newEventSound( start_btn_share_click )
mydata.start_btn_info_click = gameUI.newEventSound( start_btn_info_click )
mydata.start_btn_help_click = gameUI.newEventSound( start_btn_help_click )

mydata.options_btn_level_click = gameUI.newEventSound( options_btn_level_click )
mydata.options_btn_music_click = gameUI.newEventSound( options_btn_music_click )
mydata.options_btn_effects_click = gameUI.newEventSound( options_btn_effects_click )
mydata.options_btn_vibrate_click = gameUI.newEventSound( options_btn_vibrate_click )
mydata.options_btn_back_click = gameUI.newEventSound( options_btn_back_click )
mydata.options_btn_start_click = gameUI.newEventSound( options_btn_start_click )
mydata.options_btn_best_click = gameUI.newEventSound( options_btn_best_click )

mydata.game_bg_sound_easy = gameUI.loadStream( game_bg_sound_easy )
mydata.game_bg_sound_normal = gameUI.loadStream( game_bg_sound_normal )
mydata.game_bg_sound_hard = gameUI.loadStream( game_bg_sound_hard )
mydata.game_img_explosion_sound = gameUI.newEventSound( game_img_explosion_sound )
mydata.game_btn_pause_click = gameUI.newEventSound( game_btn_pause_click )

mydata.pause_btn_music_click = gameUI.newEventSound( pause_btn_music_click )
mydata.pause_btn_effects_click = gameUI.newEventSound( pause_btn_effects_click )
mydata.pause_btn_vibrate_click = gameUI.newEventSound( pause_btn_vibrate_click )
mydata.pause_btn_menu_click = gameUI.newEventSound( pause_btn_menu_click )
mydata.pause_btn_back_click = gameUI.newEventSound( pause_btn_back_click )

mydata.gameover_bg_sound = gameUI.loadStream( gameover_bg_sound )
mydata.gameover_btn_menu_click = gameUI.newEventSound( gameover_btn_menu_click )
mydata.gameover_btn_retry_click = gameUI.newEventSound( gameover_btn_retry_click )

clock = os.clock() - clock

print("audio load time ", clock)

local function onKeyEvent( event )

	local phase = event.phase
	local keyName = event.keyName

	local onComplete = function ( event )
		if "clicked" == event.action then
			local i = event.index
			if i == 2 then
			elseif i == 1 then
				gameUI.exit()
			end
		end
	end

	if ( ("back" == keyName or "deleteBack" == keyName) and phase == "up" ) then
		local lastScene = composer.returnTo
		if(not composer.currentScene) then
			return true
		end
		local currentScene = composer.currentScene
		print( currentScene, " >> to scene >> ", lastScene )
		if (currentScene == lastScene) then
			return false
		end
		if ( currentScene == "splash" ) then
			local alert = native.showAlert( main_btn_exit_confirm_title, main_btn_exit_confirm_text, 
													{ main_btn_exit_confirm_btn_yes, main_btn_exit_confirm_btn_cancel }, onComplete )
			return true
		elseif ( composer.isOverlay ) then
			composer.currentScene = nil
			hideOverlay()
			return true
		else
			if ( lastScene ) then
				print("Stop audio chanel", bgChannel)
				audio.rewind( {channel = bgChannel} )
				audio.stop( bgChannel )
				composer.gotoScene( lastScene, { effect="fade", time=400 } )
				composer.currentScene = nil
				return true
			else
				local alert = native.showAlert( main_btn_exit_confirm_title, main_btn_exit_confirm_text, 
														{ main_btn_exit_confirm_btn_yes, main_btn_exit_confirm_btn_cancel }, onComplete )
				return true
			end
		end
	end
	return false
end

--add the key callback
Runtime:addEventListener( "key", onKeyEvent )

------HANDLE SYSTEM EVENTS------
local function systemEvents( event )
	print("systemEvent " .. event.type)
	if ( event.type == "applicationSuspend" ) then
		print( "suspending..........................." )
	elseif ( event.type == "applicationResume" ) then
		print( "resuming............................." )
	elseif ( event.type == "applicationExit" ) then
		print( "exiting.............................." )
	elseif ( event.type == "applicationStart" ) then
		print( "starting.............................." )
		gameNet.gameNetworkSetup() --login to the network here
	end
	return true
end

Runtime:addEventListener( "system", systemEvents )

composer.gotoScene( "start" )

-- Game Analytics
GA.submitSystemInfo = true
GA.submitUnhandledErrors = true
GA.maxErrorCount = 30
GA.submitAverageFps = true
GA.submitAverageFpsInterval = 5
--GA.submitCriticalFps = true
GA.criticalFpsBelow = 20
GA.criticalFpsRange = 15
GA.criticalFpsInterval = 10
GA.useComposer = true
GA.submitComposerEvents = true
if(not SIMUL_USE_GA) then GA.isDebug = false end
if(SIMUL_USE_GA) then GA.runInSimulator = true end

GA.newSessionOnResume = false

GA.submitWhileRoaming = false
--GA.batchRequests = true
GA.batchRequestsInterval = 10
GA.archiveEvents = true
GA.archiveEventsLimit = 1024

GA.waitForCustomUserID = true

GA.init ( {
			game_key = '854ff97303e1ebf15f8ac85d491d7fe1',
			secret_key = '07d9224e3ffe638d10cf563121729618633ef6aa',
			build_name = BUILD_NUMBER,
} )

local uniqueID = system.getInfo("deviceID")
GA.setCustomUserID ( uniqueID )

-- LICENSE CHECK
gameUI.checkLicense()

GA.newEvent ( "design", { area="load", event_id="Load:AudioLoadTime", value=clock } )
