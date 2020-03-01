local mydata = require( "mydata" )
local json = require ( "json" )
local ads = require( "ads" )
local vibrator = require('plugin.vibrator')
local GA = require ( "plugin.gameanalytics" )

local filename = "options.json"
local directory = system.DocumentsDirectory
_MUSIC = "MUSIC"
_EFFECTS = "EFFECTS"
_VIBRATE = "VIBRATE"
_LEVEL = "LEVEL"
_SHOW_HELP = "SHOW_HELP"

local configDefault = {MUSIC = 1, EFFECTS = 1, LEVEL = 2, VIBRATE = 1, SHOW_HELP = 1}

local zSimulator = "simulator" == system.getInfo( "environment" )
function isSimulator() return zSimulator end
local zAndroid = "Android" == system.getInfo("platformName")
function isAndroid() return zAndroid end
local ziPhone = "iPhone OS" == system.getInfo("platformName")
function isiPhone() return ziPhone end
local zWinPhone = "WinPhone" == system.getInfo("platformName")
function isWinPhone() return zWinPhone end
local zMacOSX = "Mac OS X" == system.getInfo("platformName")
function isMacOSX() return zMacOSX end
local zWin = "Win" == system.getInfo("platformName")
function isWin() return zWin end

module(..., package.seeall)

function height()
	return display.contentHeight - heightAdBanner()
end

function width()
	return display.contentWidth
end

function checkLicense()
	if ( zAndroid ) then
		local licensing = require( "licensing" )
		licensing.init( "google" )

		local function licensingListener( event )
			print("Licence: ", event.response)
			local onComplete = function ( event )
				if (system.canOpenURL()) then
					system.openURL(global_playstore_url);
					GA.newEvent ( "error", { area="licensing", severity="info", message="Open URL: " ..  global_playstore_url} )
					print("Open URL: " ..  global_playstore_url)
				end
				native.requestExit()
			end
			if ( not event.isVerified and not event.isError ) then
				local alert = native.showAlert( "Pirates!!!", "Download JetBomb from the oficial store.", 
											{ "OK" }, onComplete )
				GA.newEvent( "error", { area="licensing", severity="error", message=event.response } )
				--native.requestExit()
			else
				GA.newEvent ( "error", { area="licensing", severity="info", message=event.response } )
			end
		end

		if (not DO_NOT_CHECK_LICENSE) then licensing.verify( licensingListener ) end
	end
end

function loadSound( params )
	if ((zAndroid or zWin) and params.android) then
		print("loadSound android ", params.android)
		soundID = audio.loadSound( params.android ) -- return sound file for Android
	elseif ((ziPhone or zMacOSX) and params.ios) then
		print("loadSound ios ", params.ios)
		soundID = audio.loadSound( params.ios ) -- return sound file for iOS/MacOS
	elseif params.default then
		print("loadSound default ", params.default)
		soundID = audio.loadSound( params.default )
	end

	return soundID
end

function loadStream( params )
	if ((zAndroid or zWin) and params.android) then
		print("loadStream android ", params.android)
		soundID = audio.loadStream( params.android ) -- return sound file for Android
	elseif ((ziPhone or zMacOSX) and params.ios) then
		print("loadStream ios ", params.ios)
		soundID = audio.loadStream( params.ios ) -- return sound file for iOS/MacOS
	elseif params.default then
		print("loadStream default ", params.default)
		soundID = audio.loadStream( params.default )
	end

	return soundID
end

function play( sound, options )
	if (bgChannel) then stop() end
	bgChannel = audio.play( sound, options )
	print("Play audio chanel ", bgChannel)
	return bgChannel
end

function stop()
	print("Stop audio chanel ", bgChannel)
	audio.rewind( {channel = bgChannel} )
	audio.stop( bgChannel )
	bgChannel = nil
end

function newEventSound( params )
	if ((zAndroid or zWin) and params.android) then
		print("newEventSound android ", params.android)
		soundID = media.newEventSound( params.android ) -- return sound file for Android
	elseif ((ziPhone or zMacOSX) and params.ios) then
		print("newEventSound ios ", params.ios)
		soundID = media.newEventSound( params.ios ) -- return sound file for iOS/MacOS
	elseif params.default then
		print("newEventSound default ", params.default)
		soundID = media.newEventSound( params.default )
	end

	return soundID
end

function playEventSound( sound )
	if getConfig(_EFFECTS) == 1 then
		media.playEventSound( sound )
	end
end

function vibrate(time)
	if getConfig(_VIBRATE) == 1 then
		if zAndroid or ziPhone or zWinPhone then
			time = time or 50
			vibrator.vibrate(time)
		end
	end
end

function addBgObj( image, w, h, invert )
	local obj = display.newImageRect(image, w, h)
	obj.anchorY = 1
	obj.anchorX = 0
	if (invert) then
		obj.anchorX = 1
		obj:scale(-1, 1)
	end
	obj.x = 0
	obj.y = height()
	return obj
end

function addButton( image, xPos, yPos, w, h, color )
	local button = display.newImageRect(image, w, h)

	button.x = xPos or width() / 2
	button.y = yPos or height() / 2

	if color then
		button:setFillColor(unpack(color))
	end

	return button
end

function addText( text, x, y, size, font)
	x = x or width()/2
	y = y or height()/2
	size = size or 20
	font = font or global_font or native.systemFont
	btnText = display.newText(text, x, y, font, size)

	return btnText
end

function addBG( imageBG )
	local border = display.newRect( 0, height(), width(), heightAdBanner() )
	border.anchorY = 0
	border.anchorX = 0
	border:setFillColor( 0 ) -- 1=white - 0=black

	-- background
	local background = display.newImageRect( imageBG , width(), height())
	background.x = width() / 2
	background.y = height() / 2

	return background
end

function addBomb(bombImage, bombWidth, bombHeight, sparkImage, sparkOptions, sparkSprite, sparkScale, sparKPos)
	local bombImg = display.newImageRect(bombImage, bombWidth, bombHeight)

	local sparkSheet = graphics.newImageSheet( sparkImage, sparkOptions )
	spark = display.newSprite( sparkSheet, sparkSprite )
	spark:scale(sparkScale[1], sparkScale[2])
	spark.x = sparKPos[1]
	spark.y = sparKPos[2]

	local bomb = display.newGroup()
	bomb.spark = spark

	bomb:insert(bombImg)
	bomb:insert(spark)

	return bomb
end

function addJet(jetImage, jetWidth, jetHeight, flameImage, flameOptions, flameSprite, flameScale, flamePos)
	local jetImg = display.newImageRect(jetImage, jetWidth, jetHeight)

	local flameSheet = graphics.newImageSheet( flameImage, flameOptions )
	flame = display.newSprite( flameSheet, flameSprite )
	flame:scale(flameScale[1], flameScale[2])
	flame.x = flamePos[1]
	flame.y = flamePos[2]
	flame:rotate(-90)

	local jet = display.newGroup()
	jet.flame = flame

	jet:insert(jetImg)
	jet:insert(flame)

	return jet
end

local function saveTable()
	local path = system.pathForFile(filename, directory)
	--print(path)
	local file = io.open(path, "w")
	if file then
		local contents = json.encode(config)
		print(filename, " << ", contents)

		file:write( contents )
		io.close( file )
		return true
	else
		return false
	end
end

local function loadTable()
	local path = system.pathForFile(filename, directory)
	--print(path)
	local contents = ""
	local myTable = {}
	local file = io.open( path, "r" )
	if file then
		-- read all contents of file into a string
		local contents = file:read( "*a" )
		print(filename, " >> ", contents)

		myTable = json.decode(contents);
		io.close( file )
		return myTable or configDefault
	end
	return configDefault
end

function loadConfig()
	if config == nil then
		config = loadTable()
		setConfig(_MUSIC, config[_MUSIC])
	end
	return config
end

function getConfig( pos )
	if config == nil then
		config = loadTable()
	end

	return config[pos] or configDefault[pos]
end

function getLevelText(level)
	level = level or getConfig(_LEVEL)
	if level == 1 then
		return global_txt_easy
	elseif level == 3 then
		return global_txt_hard
	else
		return global_txt_normal
	end
end

-- TO MUTE BG SOUND
--audio.setVolume(0)
-- TO MUTE SOUND EFFECTS
--config[_EFFECTS] = 0
function setConfig( pos, zON )
	if config == nil then
		config = loadTable()
	end

	if pos == _MUSIC then
		if zON == 1 then
			audio.setVolume( 1 )
		else
			audio.setVolume( 0 )
		end
	end

	if config[pos] == zON then
		return true
	end

	config[pos] = zON
	return saveTable()
end

local gamesEASY = 0
local gamesNORMAL = 0
local gamesHARD = 0
function newGameStarted(level)
	level = level or getConfig(_LEVEL)
	if level == 1 then
		gamesEASY = gamesEASY + 1
	elseif level == 3 then
		gamesHARD = gamesHARD + 1
	else
		gamesNORMAL = gamesNORMAL + 1
	end
end

local function getGamesPlayed(level)
	if level == 1 then
		return gamesEASY
	elseif level == 3 then
		return gamesHARD
	else
		return gamesNORMAL
	end
end

function exit()
	GA.newEvent ( "design", { event_id="TimesPlayed:Level:1", value=getGamesPlayed(1) } )
	GA.newEvent ( "design", { event_id="TimesPlayed:Level:2", value=getGamesPlayed(2) } )
	GA.newEvent ( "design", { event_id="TimesPlayed:Level:3", value=getGamesPlayed(3) } )
	vibrate()
	showAdInterstitial(true)
	native.requestExit()
end

local function adListener( event )
	-- The 'event' table includes:
	-- event.name: string value of "adsRequest"
	-- event.response: message from the ad provider about the status of this request
	-- event.phase: string value of "loaded", "shown", or "refresh"
	-- event.type: string value of "banner" or "interstitial"
	-- event.isError: boolean true or false

	GA.newEvent ( "design", { area="admob", event_id="AdMob:"..event.type..":"..event.phase } )
	if ( event.isError ) then
		print( "=ADS= Error, no ad ", event.type, " received: ", event.response )
		GA.newEvent ( "error", { area="admob", severity="warning", message="Admob error: ["..event.response.."]" } )
		ads.init( mydata.provider, mydata.bannerAppID, adListener )
	elseif ( event.phase == "loaded" ) then
		print( "=ADS= Ad ", event.type, " loaded" )
	elseif ( event.phase == "shown" ) then
		print( "=ADS= Ad ", event.type, " shown" )
	elseif ( event.phase == "refreshed" ) then
		print( "=ADS= Ad ", event.type, " refreshed" )
	else
		print( "=ADS= Ah ha! Got one! ", event.type, " ", event.phase )
	end
end

local _TESTMODE = false
function initAd()
	if zAndroid or ziPhone or zWinPhone then
		print( "Init BANNER" )
		ads.init( mydata.provider, mydata.bannerAppID, adListener )
		print( "Init INTERSTITIAL" )
		--ads.init( mydata.provider, mydata.interstitialAppID, adListener )
		ads.load( "interstitial", { appId=mydata.interstitialAppID, testMode=_TESTMODE } )
	end
end

function showAdBanner()
	if zAndroid or ziPhone or zWinPhone then
		print( "Show BANNER" )
		ads.show( "banner", { x=0, y=100000, appId=mydata.bannerAppID, testMode=_TESTMODE} )
	end
end

local adCounter = {}
adCounter.default = 3
adCounter.counter = 0

function showAdInterstitial(force)
	if zAndroid or ziPhone or zWinPhone then
		if ( adCounter.counter <= 0 or force) then
			if ( ads.isLoaded("interstitial") ) then
				print( "Show INTERSTITIAL" )
				ads.show( "interstitial", { appId=mydata.interstitialAppID, testMode=_TESTMODE} )
				adCounter.counter = adCounter.default
			else
				print( "INTERSTITIAL not loaded" )
			end
			ads.load( "interstitial", { appId=mydata.interstitialAppID, testMode=_TESTMODE } )
		else
			adCounter.counter = adCounter.counter - 1
			print( "Counter INTERSTITIAL ", adCounter.counter )
		end
	end
end

function hideAd()
	if zAndroid or ziPhone or zWinPhone then
		print( "Hide BANNER/INTERSTITIAL" )
		ads.hide()
	end
end

function heightAdBanner()
	if zAndroid or ziPhone or zWinPhone then
		return ads.height() or 0
	end
	return 0
end
